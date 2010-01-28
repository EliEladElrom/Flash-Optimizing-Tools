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
	import mx.core.UIComponent;

	/**
	 * Drawing Manager API will allow to use the drawing API to draw shapes.
	 * 
	 * <p>
	 * Drawing Manager allow you to create shapes with one statment instead of creating 
	 * blocks of codes to create a simple shape or using swf/images which cost valuable resources
	 * since the player need to upload these resources.
	 * </p>
	 * 
	 * <p>
	 * Creating shapes using the drawing API will boost Flex application since the application doesn't need to upload
	 * images or swf, when the graphic is simple and it will allow you to quickly create graphic.
	 * </p>
	 * 
	 * <p>
	 * Pitfall:
	 * Each shape has minimum settings that need 
	 * to be submitted such as: width, height, x, y, color, alpha, instname, rotation.
	 * </p>
	 * 
	 * <p>
	 * Remember that since the class extends UIComponents, 
	 * all the method that are avaliable such as buttonMode, click etc...
	 * </p>
	 * 
	 * @example
	 * <listing version="3.0">
	 * 
	 * 	private function draw():void 
	 *	{
	 *		drawing.Rect(100, 100, 100, 200, 0xFFCC00, "round", 50, 0.7);
	 *		drawing.Triangle(100, 100, 0, 0, 0xFFFFFF);
	 *	}
	 *  
	 *  <!-- drawingmanager:Drawing id="drawing" /-->
	 * 
	 * </listing>
	 * 
	 * @author Elad Elrom
	 * 
	 */
	
	public class Drawing extends UIComponent
	{

		/**
		 * Protected var to keep all the objects that are going to be added. 
		 */
		protected var component:UIComponent = new UIComponent();
			
	    //--------------------------------------------------------------------------
	    //
	    //  Overridden methods: UIComponent
	    //
	    //--------------------------------------------------------------------------
	    
	    /**
	     * @see	mx.core.UIComponent 
	     * 
	     */
	    override protected function createChildren():void
	    {
	        super.createChildren();
	        addChild(component);
	 
	    }

	    //--------------------------------------------------------------------------
	    //
	    //  Overridden methods: UIComponent
	    //
	    //--------------------------------------------------------------------------

		/**
		 * Rect method create a rectangle shape.
		 * 
		 * <listing ver="3.0">
		 * 		CreateRectangle(100, 100, 100, 200, 0xFFCC00, "round", 50, 0.7);
		 * </listing>
		 * 
		 * @see com.elad.framework.drawingmanager.DrawRectangle
		 * 
		 * @param width	width of the rectangle.
		 * @param height	height of the rectangle.
		 * @param x	location of x.
		 * @param y	location of y.
		 * @param color	values in unit for example: 1xFFFFFF.
		 * @param style	two options "round" for round edges rectangle and linear for straight edges rectangle.
		 * @param radious	is used only when it's round edges rectangle.
		 * @param rotation	option to rotate the sprite.
		 * @param alpha	values from 0-1.
		 * @param instname	instname of the sprite that will be created.
		 * 
		 */		
		public function CreateRectangle(width:int, height:int, x:int, y:int, color:uint, style:String="linear", radius:int=0, alpha:Number=1, rotation:Number=0, instname:String=null):void
		{
			component.addChild( new ShapeRectangle().Draw(width, height, x, y, color, style, radius, alpha, rotation, instname) );
		}

		/**
		 * Method to create a triangle shape.
		 * 
		 * <listing ver="3.0">
		 * 		CreateTriangle(31, 38, -251, -293, 0x000000, 1, 90);
		 * </listing>
		 * 
		 * @see com.elad.framework.drawingmanager.ShapeTriangle
		 * 
		 * @param width	width of triangle.
		 * @param height	height  of triangle.
		 * @param x	location of x.
		 * @param y	location of y.
		 * @param color	color in uint such as 1xFFFFFF.
		 * @param alpha	values between 0-1.
		 * @param rotation	values between 0-360.
		 * @param instname	name of sprite object.
		 * 
		 */		
		public function CreateTriangle(width:int, height:int, x:int, y:int, color:uint, alpha:Number=1, rotation:Number=0, instname:String=null):void
		{
			component.addChild( new ShapeTriangle().Draw(width, height, x, y, color, alpha, rotation, instname) );
		}

		/**
		 * CreateCircle method, create a circle.
		 * 
		 * <listing ver="3.0">
		 * 		CreateRectangle(100, 100, 100, 200, 0xFFCC00, 50, 0.7);
		 * </listing>
		 * 
		 * @see com.elad.framework.drawingmanager.DrawRectangle
		 * 
		 * @param width	width of the rectangle.
		 * @param height	height of the rectangle.
		 * @param x	location of x.
		 * @param y	location of y.
		 * @param color	values in unit for example: 1xFFFFFF.
		 * @param radious	circle radious.
		 * @param rotation	option to rotate the sprite.
		 * @param alpha	values from 0-1.
		 * @param instname	instname of the sprite that will be created.
		 * 
		 */		
		public function CreateCircle(width:int, height:int, x:int, y:int, color:uint, radious:int, alpha:Number=1, rotation:Number=0, instname:String=null):void
		{
			component.addChild( new ShapeCircle().Draw(width, height, x, y, color, radious, alpha, rotation, instname) );
		}		
		
	}
}