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
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

@author  Elad Elrom
*/
package com.elad.optimize.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	import mx.controls.Image;
	import mx.core.UIComponent;
	
	import spark.components.Group;

	public final class FXGHelper
	{
		// retrieve the bitmap data of a component 
		public static function getBitmapData( target:UIComponent, isTransparent:Boolean = false ):BitmapData
		{ 
			var bitmapData:BitmapData = new BitmapData( target.width, target.height, true, 0x00FFFFFF );
			var matrix:Matrix = new Matrix();
			bitmapData.draw( target, matrix );
			return bitmapData;  
		}
		
		public static function getImage(target:UIComponent ):Image
		{
			var bitmapData:BitmapData = new BitmapData( target.width, target.height, true, 0x00FFFFFF );
			var matrix:Matrix = new Matrix();
			bitmapData.draw( target, matrix );

			var bitmap:Bitmap = new Bitmap( bitmapData );				
			var image:Image = new Image();
			image.source = bitmap;	
			return image;
		}

		public static function getBitmap(target:UIComponent ):Bitmap
		{
			var bitmapData:BitmapData = new BitmapData( target.width, target.height, true, 0x00FFFFFF );
			var matrix:Matrix = new Matrix();
			bitmapData.draw( target, matrix );
			
			var bitmap:Bitmap = new Bitmap( bitmapData );
			return bitmap;
		}
	
		
		/**
		 * Utility method to find the object based on id
		 *  
		 * @param object
		 * @param id
		 * @return 
		 * 
		 */
		
		public static function findSparkObjectById(object:Group, id:String):*
		{
			var numElements:int = object.numElements;
			var child:*;
			
			
			for (var index:int; index<numElements; index++)
			{
				child = object.getElementAt( index );
				
				if ( child.id == id )
					return child;
			}
			
			return child;
		}		
		
		
	}
}