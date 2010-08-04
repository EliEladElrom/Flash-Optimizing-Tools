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

package com.elad.framework.sound
{
	import com.elad.framework.sound.events.TrackMixerErrorEvent;
	
	import flash.display.Shader;
	import flash.display.ShaderJob;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * 
	 *  @example The following code is used in the Pixel Bender Toolkit to create an pbk file; 
	 * <listing version="3.0" > 
	 * <languageVersion : 1.0;>
	 * 
	 * kernel sound
	 * <   namespace : "Your Namespace";
	 *     vendor : "Your Vendor";
	 *     version : 1;
	 *     description : "your description";
	 * >
	 * {
	 *     input image4 src0;
	 *     input image4 src1;
	 *     
	 *     output float4 dst;
	 *     
	 *     parameter float distort 
	 *     <       
	 *         minValue:float(0);
	 *         maxValue:float(1.0); 
	 *         defaultValue:float(1.0);
	 *     >;    
	 * 
	 * 
	 *     void
	 *     evaluatePixel()
	 *     {
	 *         float4 s1 = sampleNearest(src0,outCoord());
	 *         float4 s2 = sampleNearest(src1,outCoord());
	 *         dst = mix(s1,s2,distort);
	 *     }
	 * }
	 * </listing>
	 * 
	 *  Here's an implimentation example for Flex Gumbo:
	 * <listing version="3.0" > 
	 * 		[Embed("assets/pbj/TwoTracksMixer.pbj", mimeType="application/octet-stream")]
	 *		private var Kernal:Class;
	 *		
	 *		private var trackMixer:TrackMixer;
	 *
	 *		protected function creationCompleteHandler(event:FlexEvent):void
	 *		{
	 *			trackMixer = new TrackMixer(Kernal);
	 *			trackMixer.addEventListener(TrackMixerErrorEvent.TRACK_MIXER_ERROR, function(e:*):void { trace(e.message); } );
	 *			trackMixer.start( ["assets/tracks/FeelinGood.mp3", "assets/tracks/Sunshine.mp3"] );
	 *		}
	 *
	 *		protected function balanceSliderChangeHandler(event:Event):void
	 *		{
	 *			trackMixer.balance = event.currentTarget.value ;
	 *		}
	 * 
	 *		<mx:Slider x="28" y="171" id="balanceSlider" 
	 *			minimum="0" maximum="1" 
	 *			liveDragging="true" value="0.5"
	 *			change="balanceSliderChangeHandler(event)" />
	 * 
	 * </listing>
	 * 
	 */	
	
	/**
	 *  Dispatched after the calculation is completed
	 *
	 *  @eventType com.elad.framework.sound.events.TRACK_MIXER_ERROR
	 */	
	[Event(name="trackMixerError", type="com.elad.framework.sound.events.TrackMixerErrorEvent")]	
	
	/**
	 * API to mix two tracks together into one track 
	 */	
	public class TrackMixer extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
		//
		//  consts
		//
		//--------------------------------------------------------------------------
		
		private const BUFFER_SIZE:int = 1024;
		
		//--------------------------------------------------------------------------
		//
		//  variable
		//
		//--------------------------------------------------------------------------		
		
		// pixel bender class and shader
		private var KernalClass:Class;
		private var shader:Shader;
		private var shaderJob:ShaderJob;
		
		// num of tracks
		private var numOfTracks:Number = 0;
		
		// counter
		private var trackDownloadCounter:int = 0;
		
		// buffer & sound objects
		private var buffer:Vector.<ByteArray> = new Vector.<ByteArray>;
		private var sound:Vector.<Sound> = new Vector.<Sound>;	
		
		//--------------------------------------------------------------------------
		//
		//  getter / setters
		//
		//--------------------------------------------------------------------------
		
		private var _balance:Number = 0.5;		
		public function get balance():Number
		{
			return _balance;
		}
		
		public function set balance(value:Number):void
		{
			_balance = value;
		}		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function TrackMixer(kernalClass:Class)
		{
			this.KernalClass = kernalClass;
			shader = new Shader(new KernalClass() as ByteArray);
		}
		
		//--------------------------------------------------------------------------
		//
		//  methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Start method takes the urls of the track and create new sound instance.
		 * Currently the API is limited to two tracks at a time. 
		 *  
		 * @param urls	holds an array with the urls of the tracks.
		 * 
		 */		
		public function start(urls:Array):void 
		{
			if (urls.length >2)
			{
				this.dispatchErrorEvent( "API only supports two tracks at this point." );
			}
			
			numOfTracks = urls.length;
			
			for (var i:int = 0; i< numOfTracks; i++)
			{
				sound[i] = new Sound(new URLRequest(urls[i]));
				sound[i].addEventListener(Event.COMPLETE, onSoundLoaded);
				sound[i].addEventListener(IOErrorEvent.IO_ERROR, onError);
			}
		}
		
		/**
		 * Method to dispatch an error event
		 *  
		 * @param message	message to include wit the event
		 * 
		 */		
		private function dispatchErrorEvent( message:String ):void
		{
			this.dispatchEvent( new TrackMixerErrorEvent( message ) );
		}
		
		//--------------------------------------------------------------------------
		//
		//  event handlers
		//
		//--------------------------------------------------------------------------		
		
		private function onError(event:IOErrorEvent):void
		{
			this.dispatchErrorEvent( event.text );
		}
		
		private function onSoundLoaded(event:Event):void 
		{
			trackDownloadCounter++;
			
			if (trackDownloadCounter == numOfTracks) 
			{
				var sound:Sound = new Sound();
				
				sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleDataHandler);  
				sound.play();
			}
		}
		
		private function onSampleDataHandler(event:SampleDataEvent):void 
		{
			var width:int = 1;
			var height:Vector.<int> = new Vector.<int>(numOfTracks);
			
			for (var i:int = 0; i < numOfTracks; i++)
			{
				buffer[i] = new ByteArray();
				sound[i].extract(buffer[i],BUFFER_SIZE * 4);
				height[i] = buffer[i].length >> 4;
				buffer[i].position = 0;
				
				shader.data["src"+i]["input"] = buffer[i];
				shader.data["src"+i]["width"] = width;
				shader.data["src"+i]["height"] = height[i];
			}
			
			shader.data.distort.value = [this.balance];
			shaderJob = new ShaderJob(shader, event.data,width, height[0]);
			shaderJob.start(true);
		}		
	}
}