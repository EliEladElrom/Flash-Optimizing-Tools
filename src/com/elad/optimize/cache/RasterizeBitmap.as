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
package com.elad.optimize.cache
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class RasterizeBitmap
	{
		public static function cacheAsBitmapData( source:Sprite ):BitmapData
		{
			var bounds:Rectangle = source.getBounds(source); 
			var matrix:Matrix = new Matrix(); 
			
			matrix.translate( -bounds.x, -bounds.y ); 
			
			var bitmapData:BitmapData = new BitmapData( source.width + 1, source.height + 1, true, 0); 
			bitmapData.draw( source, matrix ); 
			
			return bitmapData;
		}
		
		public static function cacheAsBitmap( source:Sprite ):Bitmap
		{
			return new Bitmap( cacheAsBitmapData( source ) );
		}
	}
}