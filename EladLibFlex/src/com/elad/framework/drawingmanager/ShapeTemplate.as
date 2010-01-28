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
	 * Concerte class that create a shape and set all the properties of the shape.
	 * 
	 * <p>
	 *  Shape has similiar properties that is shared with all shapes, 
	 *  such as X,Y,width etc and unique properties.
	 * </p>
	 * 
	 * @author Elad Elrom
	 * 
	 */	
	internal class ShapeTemplate extends AbstractShape implements IShape
	{
		/**
		 * Draw method is used to generate the shape. 
		 * 
		 * <p>
		 * The order is as followed:
		 * <br>
		 * <ol>
		 * 	<li>Setting all the variables in use.</li>
		 *  <li>Creating the shape and setting all the properties.</li>
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
			
			// setting variables
			var width:int = args[0];
			var height:int = args[1];
			var x:int = args[2];
			var y:int = args[3];
			var color:uint = args[4];
			var alpha:Number = args[5];
			var rotation:Number = args[6];
			var instname:String = args[7];
						
			var shape:Shape = new Shape();
			
			//////////////////////////////////////////////////////////////////
			//  
			//	Create shape
			//
			//////////////////////////////////////////////////////////////////
			
			// set the shape properties

			//////////////////////////////////////////////////////////////////
			//  
			//	Create shape
			//
			//////////////////////////////////////////////////////////////////
			
			// set all common elements			
			setAll(x, y, alpha, rotation, instname, shape);
			
			return this;
		}

	}
}