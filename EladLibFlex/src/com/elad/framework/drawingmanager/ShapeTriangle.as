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
	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * Concerte class to create a shape.
	 * 
	 * @author Elad Elrom
	 * 
	 */	
	internal class ShapeTriangle extends AbstractShape implements IShape
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
		 * @param args
		 * @return 
		 * 
		 */		
		public function Draw(...args):Sprite
		{
			
			// setting variables
			var width:int = args[0];
			var height:int = args[1];
			var x:int = args[2];
			var y:int = args[3];
			var color:uint = args[4];
			var alpha:Number = args[5];
			var rotation:Number = args[6];
			var instname:String = args[7];
						
			var triangle:Shape = new Shape();
			
			//////////////////////////////////////////////////////////////////
			//  
			//	Create shape
			//
			//////////////////////////////////////////////////////////////////
			
			triangle.graphics.beginFill(color);
			triangle.graphics.moveTo(0 + width/2, 0);
			triangle.graphics.lineTo(0 + height, height);
			triangle.graphics.lineTo(0, height);
			triangle.graphics.lineTo(0 + width/2, 0);

			//////////////////////////////////////////////////////////////////
			//  
			//	Create shape
			//
			//////////////////////////////////////////////////////////////////
			
			// set all common elements			
			setAll(x, y, alpha, rotation, instname, triangle);
			
			return this;
		}

	}
}