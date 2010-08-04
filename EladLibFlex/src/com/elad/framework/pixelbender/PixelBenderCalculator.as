/*

Copyright (c) 2009 Elad Elrom.  Elrom LLC. All rights reserved. 

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

@author  Elad Elrom
@contact elad.ny at gmail.com

*/

package com.elad.framework.pixelbender
{
	import com.elad.framework.pixelbender.events.PixelBenderCompleteEvent;
	
	import flash.display.Shader;
	import flash.display.ShaderJob;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * 
	 *  @example The following code is used in the Pixel Bender Toolkit to create an pbk file; 
	 * <listing version="3.0" > 
	 * <languageVersion : 1.0;>
	 *	kernel SinCalculator
	 *	< 
	 *	    namespace : "Your namespace";
	 *	    vendor : "Your name or company name";
	 *	    version : 1;
	 *	    description : "Your description";
	 *	>
	 *	{
	 *	    input image1 src;
	 *	    output pixel3 result;
	 *	
	 *	    void evaluatePixel()
	 *	    {
	 *	    	pixel1 value = pixel1(sin(sample(src, outCoord())));
	 *    	result = pixel3(value, 0.0, 0.0);
	 *	    }
	 *	} 
	 * </listing>
	 * 
	 *  Here's an implimentation example for Flex Gumbo:
	 * <listing version="3.0" > 
	 *		[Embed(source="SinCalculator.pbj", mimeType="application/octet-stream")]
	 *		private var kernalClass:Class;
	 * 		private var pixelBenderCalc:PixelBenderCalculator;
	 *		
	 *		protected function startCalculatorPixelBender():void
	 *		{
	 *			// create a number collection
	 *			var numberCollection:Array = new Array();
	 *			
	 *			for (var i:int=0; i<5000000; i++)
	 *			{
	 *				numberCollection.push( i );
	 *			}
	 *			
	 *			// calculate
	 *			pixelBenderCalc = new PixelBenderCalculator(numberCollection, kernalClass);
	 *			pixelBenderCalc.addEventListener( PixelBenderCompleteEvent.COMPLETED_EVENT, onComplete );
	 *			
	 *			pixelBenderCalc.start();
	 *		}
	 * </listing>
	 * 
	 */
	
	/**
	 *  Dispatched after the calculation is completed
	 *
	 *  @eventType com.elad.framework.pixelBender.events.COMPLETED_EVENT
	 */	
	[Event(name="completedEvent", type="com.elad.framework.pixelbender.events.PixelBenderCompleteEvent")]
	
	
	/**
	 *  The PixelBenderCalculator class is the base class for math calculation with pixel bender
	 */	
	public class PixelBenderCalculator extends EventDispatcher
	{
		
		//  We need to define the PBJ class we will be 
		// using; we’ll assign a class in our implementation.
		
		public var KernalClass:Class;
		
		// We also need to define an array, numberCollection, 
		// which will hold the collection of numbers we need to do 
		// a calculation for, as well as shader and shaderJob
		
		public var numberCollection:Array;
		private var shader:Shader;
		private var shaderJob:ShaderJob;
		private var input:ByteArray;
		private var output:ByteArray;
		private var destinationCollection:Array;
		private var requestsCounter:Number;
		private var numberOfRequest:Number;
		
		/**
		 * Number of calculations per kernal.  Define a const to hold the number of calculations per kernal.
		 */		
		private const COLLECTION_SIZE:int = 5000;
		
		/**
		 * Default constructor for the pixel bender calculator.  In our default constructor, 
		 * we reset the variables, set the kernal class we will be using, and set the collection of 
		 * numbers we will be performing calculations on. We also define the number of requests we 
		 * will be making, and since Pixel Bender will produce an error message if there are too many
		 *  calculations, we will set the number of requests here.
		 * 
		 * @param sourceCollection	collection contain numbers
		 * @param destinationCollection	destination collection holds the results of the calculation
		 * @param kernalClass	the kernal class of type pbj to be used to run the calculation
		 * 
		 */		
		public function PixelBenderCalculator(sourceCollection:Array, kernalClass:Class)
		{
			reset();
			
			this.destinationCollection = destinationCollection;
			this.KernalClass = kernalClass;
			this.numberCollection = sourceCollection;
			
			requestsCounter = sourceCollection.length/COLLECTION_SIZE;
		}
		
		/**
		 * Method to start the calculation.  This is the method we will be exposing in our API
		 *  to start the calculations. The method sets the output and input. 
		 * The input is based on the size of the <code>COLLECTION_SIZE</code>.
		 * 
		 */		
		public function start():void
		{
			output = new ByteArray();
			output.endian = Endian.LITTLE_ENDIAN;
			
			var start:int = numberOfRequest*COLLECTION_SIZE;
			var end:int = ( (numberOfRequest+1)*COLLECTION_SIZE > numberCollection.length) ? numberCollection.length : ((numberOfRequest+1)*COLLECTION_SIZE);
			
			input = convertArrayToByteArray(numberCollection, start, end);
			createShaderJob();
			numberOfRequest++;
		}
		
		/**
		 * Creates a shader class based on the kernal to pass the numbers and start the calculations. 
		 * This method makes the request and is very similar to any loader we would use in Flash. 
		 * Once we set the ShaderJob, we can define a listener and start the job.
		 * 
		 * @see flash.display.ShaderJob
		 * @see flash.display.Shader
		 * 
		 */		
		private function createShaderJob():void
		{
			var width:int = input.length >> 2;
			var height:int = 1;
			
			shader = new Shader(new KernalClass());
			shader.data.src.width = width;
			shader.data.src.height = height;
			shader.data.src.input = input;			    
			
			shaderJob = new ShaderJob(shader, output, width, height);
			shaderJob.addEventListener(Event.COMPLETE, shaderJobCompleteHandler);
			shaderJob.start();				
		}
		
		/**
		 * Static method to convert the array given into byte array.
		 *  
		 * @param array
		 * @return 
		 * 
		 */		
		private static function convertArrayToByteArray(array:Array, start:int, end:int):ByteArray
		{
			var retVal:ByteArray = new ByteArray();
			var number:Number;
			
			retVal.endian = Endian.LITTLE_ENDIAN;
			
			for (var i:int=start; i<end; i++)
			{
				number = Number(array[i]);
				retVal.writeFloat(number);
			}
			
			retVal.position = 0;	
			return retVal;			
		}
		
		/**
		 * Convert the a <code>ByteArray</code> into an <code>Array</code> The addByteArrayToCollection method takes the byte array 
		 * we received from Pixel Bender kernel, converts the information to float number, and adds the information 
		 * to the array we will return to the user. We are checking the data to ensure we are passing three 
		 * variables; if(i % 3 == 0), since we had to add three extra pieces of data to pass to pixel bender 
		 * kernel: pixel3(value, 0.0, 0.0);
		 *  
		 * @param byteArray 
		 * @return an array collection
		 * 
		 */		
		private function addByteArrayToCollection(byteArray:ByteArray):void
		{
			var length:int = byteArray.length;
			var number:Number;
			
			for(var i:int=0; i<length; i+=4)
			{
				number = byteArray.readFloat();
				if(i % 3 == 0)
				{
					destinationCollection.push(number);
				}
			}
		}
		
		/**
		 * Handler for the shader once job is completed. The handler adds the results to the collection. 
		 * We split our task into parts, and this method starts another request if needed passed 
		 * to the calculationCompleted method once we complete our task.
		 * 
		 * @param event
		 * 
		 */		
		private function shaderJobCompleteHandler(event:Event):void
		{
			output.position = 0;
			addByteArrayToCollection(output);
			
			input = null;
			output = null;
			
			if (requestsCounter>numberOfRequest)
			{
				start();
			}
			else
			{
				calculationCompleted();
			}
			
		}
		
		/**
		 * Method to dispatch an event once calculation is completed and reset this class. Once the task is completed, 
		 * we will dispatch an event to notify that we are done and pass the array containing the calculation 
		 * results we made in Pixel Bender. We also use the reset method to clean all the data we don’t need anymore.
		 * 
		 */		
		private function calculationCompleted():void
		{
			this.dispatchEvent( new PixelBenderCompleteEvent(destinationCollection) );
			reset();			
		}
		
		/**
		 * Method to clean up this class so we are not using un-needed memory. The reset method 
		 * just cleaned up our arrays and other data. Since the amount of data may be large, 
		 * we need a method to destroy the data before we start and after we complete a task.
		 * 
		 */		
		public function reset():void
		{
			destinationCollection = new Array();
			numberCollection = new Array();
			requestsCounter = 0;
			numberOfRequest = 0;
			numberCollection = null;			
		}
	}
}