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
	internal class ShapeCircle extends AbstractShape implements IShape
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
			var radius:int = args[5];
			var alpha:Number = args[6];
			var rotation:Number = args[7];			
			var instname:String = args[8];
			
			var sprite:Sprite = new Sprite();
			
			//////////////////////////////////////////////////////////////////
			//  
			//	Create shape
			//
			//////////////////////////////////////////////////////////////////
						
			sprite.graphics.beginFill(color);
			sprite.graphics.drawCircle(0, 0, radius);
			sprite.graphics.endFill();
						
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