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
	 * Interface for Shapes, each shape must include a method for Draw which basically creates the shape.
	 * 
	 * @author Elad Elrom
	 * 
	 */	
	internal interface IShape
	{
		function Draw( ... args):Sprite
	}
}