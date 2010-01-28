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
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * Abstract class to define all the common methods for each shape.
	 * 
	 * <p>
	 * Abstract class set all the method that are shared to create an instances of the concrete classes. 
	 * </p>
	 * 
	 * @author Elad Elrom
	 * 
	 */	
	internal class AbstractShape extends Sprite
	{

		/**
		 * 
		 * Method to set all the properties of the sprite such as location, alpha, name, rotation.
		 * 
		 * @param x	location of x.
		 * @param y	location of y.
		 * @param alpha	alpha values between 0-1.
		 * @param rotation	rotation of shape.
		 * @param instname	instname of the sprite.
		 * @param displayObject	can be any display object to be added to the sprite.
		 * 
		 */		
		internal function setAll(x:int, y:int, alpha:Number, rotation:Number, instname:String, displayObject:DisplayObject):void 
		{			
			setSprite(displayObject);					
			setLocation(x,y);
			
			if (alpha != 1)
				setAlpha(alpha);
			
			if (instname != null)
				setInstname(instname);
				
			if (rotation > 0)
				setRotation(rotation);
		}

		/**
		 * Method to set the name of the sprite.
		 *  
		 * @param instname	name of the sprite.
		 * 
		 */		
		private function setInstname(instname:String):void
		{			
			this.name = instname;
		}

		/**
		 * Method to set the alpha channel. 
		 * 
		 * @param alpha	values between 0-1.
		 * 
		 */		
		private function setAlpha(alpha:Number):void
		{
			this.alpha=alpha;
		}

		/**
		 * Method to set the location of the sprite on the screen
		 *  
		 * @param x	location of x.
		 * @param y	location of y.
		 * 
		 */		
		private function setLocation(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}

		/**
		 * Method to set the rotation of the sprite.
		 *  
		 * @param rotation	use numbers between 0-360
		 * 
		 */
		private function setRotation(rotation:Number):void
		{
			this.rotation = rotation;
		}

		/**
		 * Method to add the created shape to the sprite. Shape can be any type of display object.
		 *  
		 * @param sprite	type DisplayObject.
		 * 
		 */		
		private function setSprite(sprite:DisplayObject):void {						
			this.addChild(sprite);
		}
	}
}