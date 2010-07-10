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
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.describeType;

	/**
	 * <p>BitmapCaching API can be useful when you need to cache bitmap.  
	 * Not only does it takes into account the new features in Flash Player 10.1 it adds utilities that can help for a 
	 * quick manual caching. The API includes the following static operations:</p>
	 * 
	 * <ul>
	 * 	<li>Manually cache as BitmapData</li>
	 * 	<li>Manually cache as Bitmap</li>
	 * 	<li>Cache all children as Bitmap</li>
	 * 	<li>Cache UIComponent</li>
	 * 	<li>Cache as BitmapMatrix</li>
	 * </ul>
	 * 
	 * <p>It also includes small utility methods to help you get your content cached and protect innocent bystanders. 
	 * 
	 * Additionally, the API is cross platform and will work with Pure AS3, Flex, AIR as well as different versions of 
	 * the player including FP 9 or FP 10.1, so it will allow you to use 
	 * what you need based on the platform and FP version you are using.
	 * </p> 
	 * 
	 */	
	public class BitmapCaching
	{
		/**
		 *	<p>Using the <code>cacheAsBitmap</code> method instruct the Player to cached the content as a bitmap and to render it on screen. 
		 *	In case a change to the visual ocour then each frame will result in updating the cached copy on memory before updating the screen.  
		 *	The solution is to use a technique where you rasterized and create different bitmap references using the same BitmapData. 
		 *	Then, when you change the visual of the original BitmapData in memory the Flash Player will avoid redrawing, which will reduce 
		 *	CPU usage while keeping a smooth animation.</p>
		 *  
		 * @param source holds the sprite source that will be used to cache
		 * @param main	it holds the main container, which is different between Flex (FlexGlobals.topLevelApplication), AIR and PureAS project (this).
		 * @param finalStageQuality	based on <code>StageQuality</code> and allow you to set the final stage quality.  AIR needs to be set to HIGH since below HIGH will be disregard
		 * @return <code>BitmapData</code> representation
		 * 
		 * @see flash.display.BitmapData
		 * 
		 */
		public static function manualCacheAsBitmapData( source:Sprite, main:Object = null, finalStageQuality:String = "low" ):BitmapData
		{
			var sourceRectangle:Rectangle = source.getBounds(source); 
			var matrix:Matrix = new Matrix(); 
			
			matrix.translate( -sourceRectangle.x, -sourceRectangle.y ); 
			
			var bitmapData:BitmapData = new BitmapData( source.width + 1, source.height + 1, true, 0); 
			
			if ( main != null )
				main.stage.quality = StageQuality.HIGH;
			
			bitmapData.draw( source, matrix );
			
			if ( main != null )
				main.stage.quality = finalStageQuality;
			
			return bitmapData;
		}
		
		/**
		 * This method can be used to wrap the display object as <code>Bitmap</code> when needed.
		 * 
		 * @param source holds the sprite source that will be used to cache
		 * @param main	it holds the main container, which is different between Flex (FlexGlobals.topLevelApplication), AIR and PureAS project (this).

		 * @return <code>Bitmap</code> representation
		 * 
		 * @see flash.display.Bitmap
		 * 
		 */		
		public static function manualCacheAsBitmap( source:Sprite, main:Object = null ):Bitmap
		{
			return new Bitmap( manualCacheAsBitmapData( source, main ) );
		}		
		
		/**
		 * 
		 * create a <code>MovieClip</code> based on <code>Sprite</code> provided.  
		 * You pass the graphic source (which is the sprite with the vector graphic or bitmap representation) 
		 * and you pass a method that will set the event handlers (in case they are needed).  
		 * In case you use Flash Professional and the MovieClip is created you wont need this methods.
		 * 
		 * 
		 * @param spriteSource
		 * @param isCacheAsBitmap
		 * @param setClipEventHandlers	event handlers (in case they are needed)
		 * @return a <code>MovieClip</code> based on <code>Sprite</code> provided
		 * 
		 */
		public static function createMovieClipBasedOnSprite(spriteSource:Sprite, 
										isCacheAsBitmap:Boolean = false, 
										setClipEventHandlers:Function = null):MovieClip
		{
			var movieClip:MovieClip = new MovieClip();
			var source:Sprite = spriteSource;
			
			movieClip.addChild( source );
			movieClip.cacheAsBitmap = isCacheAsBitmap;
			
			if (setClipEventHandlers != null)
				setClipEventHandlers( movieClip );
			
			return movieClip;
		}
		
		/**
		 * create a <code>Bitmap</code> based on <code>Sprite</code> provided.  
		 * You pass the graphic source (which is the sprite with the vector graphic or bitmap representation) 
		 * and you pass a method that will set the event handlers (in case they are needed).  
		 * In case you use Flash Professional and the MovieClip is created you wont need this methods.
		 * 
		 * @param bitmapData
		 * @param setClipEventHandlers
		 * @return <code>Bitmap</code> based on <code>Sprite</code> provided
		 * 
		 */		
		public static function createBitmapClip(bitmapData:BitmapData, 
										setClipEventHandlers:Function = null):Bitmap
		{
			var movieClip:Bitmap = new Bitmap(bitmapData);
			movieClip.smoothing = true;
			
			if (setClipEventHandlers != null)
				setClipEventHandlers( movieClip );
			
			return movieClip;
		}	
		
		/**
		 * This method is useful when you want to know the cache policy of each display object. 
		 * 
		 * @param displayObject
		 * 
		 */		
		private static function showAllChildrenCacheAsBitmapFlagStatus(displayObject:*):void
		{
			setAllChildrenCachingPolicy( displayObject, false, false, true );
		}
		
		/**
		 *	<p>This method allows you to protect innocent bystanders and remove 
		 * caching once you dont need it any more or set an entire display object and it/'s children.  
		 * The method iterate throw the class and set every display object caching policy.</p>
		 *  
		 * @param displayObject
		 * @param isCacheAsBitmap
		 * @param isCacheAsBitmapMatrix
		 * @param isDebugMode
		 * @param scaleXBitmapMatrix
		 * @param scaleYBitmapMatrix
		 * 
		 */	
		public static function setAllChildrenCachingPolicy( displayObject:*, isCacheAsBitmap:Boolean = true, 
											  isCacheAsBitmapMatrix:Boolean = false,
											  isDebugMode:Boolean = false, scaleXBitmapMatrix:Number = 1, 
											  scaleYBitmapMatrix:Number = 1 ):void 
		{
			var len:int = 0;
			
			var description:XML = describeType(displayObject);
			var componentType:String = description.@name;
			var isSpark:Boolean = false;
			var isSprite:Boolean = false;

			if( componentType == "mx.core::UIComponent" || 
				componentType == "flash.display::Sprite" || 
				componentType == "flash.display::MovieClip")
			{
				isSprite = true;
				len = displayObject.numChildren;
			}
			else if ( componentType == "spark.components::Group" )
			{
				isSpark = true;
				len = displayObject.numElements;				
			}
			
			if (!isSpark && !isSprite)
			{
				if (isDebugMode)
					trace("warning: " + componentType + " is not supported!");
				
				return;
			}
			
			if( displayObject.hasOwnProperty("cacheAsBitmap") ) 
			{
				// Cache as bitmap
				if (componentType == "mx.core::UIComponent")
					cacheUIComponent(displayObject, isCacheAsBitmap, "auto", true, isDebugMode);
				else
					displayObject.cacheAsBitmap = isCacheAsBitmap;
				
				// Cache as bitmapMatrix
				if ( displayObject.hasOwnProperty("cacheAsBitmapMatrix") )
					cacheAsBitmapMatrix(displayObject, scaleXBitmapMatrix, scaleYBitmapMatrix, isCacheAsBitmapMatrix, isCacheAsBitmap, isDebugMode);
				
				if (isDebugMode)
				{
					var isBitmapMatrix:Boolean = BitmapCaching.isCacheAsBitmapMatrix( displayObject );
					trace("cache status: " + displayObject.name + ", isCacheAsBitmap: " + isCacheAsBitmap + ", cacheAsBitmap: " + 
						displayObject.cacheAsBitmap + ", isCacheAsBitmapMatrix: " + isBitmapMatrix);
				}
			}
			
			var dispalyObjectItem:*;
			
			for (var i:int=0; i<len; i++)
			{
				if( isSprite )
					dispalyObjectItem = displayObject.getChildAt(i);
				else if ( isSpark )
					dispalyObjectItem = displayObject.getElementAt(i);
				
				if( dispalyObjectItem.hasOwnProperty("cacheAsBitmap") ) 
				{						
					setAllChildrenCachingPolicy( dispalyObjectItem, 
						isCacheAsBitmap, 
						isCacheAsBitmapMatrix,
						isDebugMode, 
						scaleXBitmapMatrix, 
						scaleYBitmapMatrix  );
				}
				else
				{
					if (isDebugMode)
						trace("warning: " + dispalyObjectItem.name + " doesn't support cacheAsBitmap");					
				}
			}		
		}
		
		/**
		 * Allows you to set <code>cacheUIComponent</code> policy. 
		 * 
		 * @param component
		 * @param isCacheAsBitmap
		 * @param uicomponentCachePolicy	based on <code>UIComponentCachePolicy</code>
		 * @param cacheHeuristic
		 * 
		 */
		public static function cacheUIComponent(component:Object, isCacheAsBitmap:Boolean = true, 
												uicomponentCachePolicy:String = "auto", 
												cacheHeuristic:Boolean = true, isDebugMode:Boolean = false):void
		{
			if ( component.hasOwnProperty("cacheAsBitmap") &&
				component.hasOwnProperty("cachePolicy") && 
				component.hasOwnProperty("cacheHeuristic") )
			{
				component.cacheAsBitmap = isCacheAsBitmap;
				component.cachePolicy = uicomponentCachePolicy;
				component.cacheHeuristic = cacheHeuristic;
			}
			else
			{
				if (isDebugMode)
					trace("warning: cannot cache UIComponent");
			}
		}
		
		/**
		 * The <code>cacheAsBitmapMatrix</code> will allow you to pass a display object and cache a matrix as <code>BitmapMatrix</code>.  
		 * You can also set the scale property, which will allow you to scale up or down the display object in case you dont need 
		 * a matrix representation at the same size.  
		 * Keep in mind that just like <code>cacheAsBitmap</code>, <code>cacheAsBitmapMatrix</code> limits the content to be not more
		 *  then 1020x1020 pixels and/or about four million pixels.
		 * 
		 * @param sprite
		 * @param scaleX	sets the scale of the x.  Example: 0.5 is 50%
		 * @param scaleY	sets the scale of the y.  Example: 0.5 is 50%
		 * 
		 */		
		public static function cacheAsBitmapMatrix(displayObject:*, 
										scaleX:Number = 1, scaleY:Number = 1, 
										isCacheAsBitmapMatrix:Boolean = true, 
										isCacheAsBitmap:Boolean = false, 
										isDebugMode:Boolean = false):void
		{
			var matrix:Matrix;
			
			if( displayObject.hasOwnProperty("cacheAsBitmapMatrix") ) 
			{
				if ( !isCacheAsBitmapMatrix )
				{
					if (isDebugMode)
						trace("remove cacheAsBitmapMatrix");
					
					displayObject.cacheAsBitmapMatrix = null;
					displayObject.cacheAsBitmap = isCacheAsBitmap;
					return;
				}
				
				if (scaleX != 1 && scaleY != 1 )
				{
					if (isDebugMode)
						trace("set cacheAsBitmapMatrix and scale");
					
					matrix = new Matrix()
					matrix.scale(scaleX, scaleY); 
				}
				else
				{
					if (isDebugMode)
						trace("set cacheAsBitmapMatrix");
					
					matrix = displayObject.transform.concatenatedMatrix;
				}
				
				displayObject.cacheAsBitmapMatrix = displayObject.transform.concatenatedMatrix;
				displayObject.cacheAsBitmap = isCacheAsBitmap;				
			}
			else
			{
				if (isDebugMode)
					trace("warning :: method cacheAsBitmapMatrix is only avaliable in FP10.1");
			}
		}
		
		/**
		 * Allow you to find out whether the display object Bitmap Matrix was set
		 * 
		 * @param displayObject
		 * @param isDebugMode
		 * @return 
		 * 
		 */		
		public static function isCacheAsBitmapMatrix(displayObject:*, isDebugMode:Boolean = false):Boolean
		{
			var isBitmapMatrix:Boolean = false;
			
			if( displayObject.hasOwnProperty("cacheAsBitmapMatrix") &&
				displayObject.cacheAsBitmapMatrix != null ) 
			{
				isBitmapMatrix = true; 
			}
			else
			{
				if (isDebugMode)
					trace("warning :: method cacheAsBitmapMatrix is only avaliable in FP10.1");				
			}
			
			return isBitmapMatrix;
		}
	}
}