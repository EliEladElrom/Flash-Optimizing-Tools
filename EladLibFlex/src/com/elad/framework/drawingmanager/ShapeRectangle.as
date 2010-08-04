/* 
	
	////////////////////////////////////////////////////////////////////////////////
	//
	//  Elad Elrom (elad@elromdesign.com)
	//  Copyright 2008 Elorm LLC,
	//  All Rights Reserved.
	//
	//  NOTICE: Elad Elrom permits you to use, modify, and distribute this file
	//  in accordance with the terms of the license agreement accompanying it.
	//
	////////////////////////////////////////////////////////////////////////////////

 */

package com.elad.framework.drawingmanager
{
	import flash.display.Sprite;

	/**
	 * Concerte class to create a shape.
	 * 
	 * @author Elad Elrom
	 * 
	 */	
	internal class ShapeRectangle extends AbstractShape implements IShape
	{	
		
		/**
		 * Draw method is used to generate the shape. 
		 * 
		 * <p>
		 * The order is as followed:
		 * <br>
		 * <ol>
		 * 	<li>Setting all the variables in use.</li>
		 *  <li>Creating the shape.</li>
		 *  <li>Setting all common elements.</li>
		 * </ol>
		 * </p>
		 *  
		 * @param args	Dynamic arguments
		 * @return	The shape that was created
		 * 
		 */	
		public function Draw(...args):Sprite 
		{			

			// set dynamic arguments
			var width:int = args[0];
			var height:int = args[1];
			var x:int = args[2];
			var y:int = args[3];
			var color:uint = args[4];
			var style:String = args[5];
			var radius:int = args[6];
			var alpha:Number = args[7];
			var rotation:Number = args[8];			
			var instname:String = args[9];
			
			var sprite:Sprite = new Sprite();
			
			//////////////////////////////////////////////////////////////////
			//  
			//	Create shape
			//
			//////////////////////////////////////////////////////////////////
						
			sprite.graphics.beginFill(color);
			
			if (style=="round")
				sprite.graphics.drawRoundRect(0, 0, width, height, radius);
			else if (style=="linear")
				sprite.graphics.drawRect(0, 0, width, height);
			
			sprite.graphics.endFill( );
						
			//////////////////////////////////////////////////////////////////
			//  
			//	Create shape
			//
			//////////////////////////////////////////////////////////////////
			
			// set everything
			setAll(x, y, alpha, rotation, instname, sprite);
			
			return this
		}		
	}
}