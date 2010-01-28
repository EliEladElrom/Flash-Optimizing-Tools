/*
 
 	Copyright (c) 2008 Elad Elrom.  Elrom LLC. All rights reserved. 
	
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
 	@contact elad@elromdesign.com

 	@internal
 	
 */

package com.elad.framework.cursor
{

	/**
	* Concrete cursor set with all the properties and objects to be used by the product (cursor), to set the different events and look of mouse throughout the application. 
	*/

	import flash.events.MouseEvent;
	import mx.core.FlexSprite;       	
	
	public class ConcreteMouseHand extends AbstractCursorBuilder
	{

	    [Embed(source="images/mouse2_1.png")]
	    public var cursorClass1:Class;	
	    [Embed(source="images/mouse2_2.png")]
	    public var cursorClass2:Class;	
	    [Embed(source="images/mouse2_3.png")]
	    public var cursorClass3:Class;	    	    	
		    	    
	    /**
	     * Method to set all the different events that will be used, such as mouse up, mouse down and others if needed.
	     * 
	     * @param flexSprite	Most basic UI can be submited.
	     * @see mx.core.FlexSprite
	     */		    	    
	    override public function setEvents(flexSprite:FlexSprite):void
	    {
	    	flexSprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEventHandler);
	    	flexSprite.addEventListener(MouseEvent.MOUSE_UP, mouseUpEventHandler);
	    }

	    /**
	     * build the regular cursor mouse 
	     * 
	     */	    
	    override public function buildCursorMouse():void
	    {
	    	cursor.setCursorMouse(cursorClass1);
	    }
	    
	    /**
	     * build the mouse up cursor  
	     * 
	     */	    
	    override public function buildCursorMouseUp():void
	    {
	    	cursor.setCursorMouseUp(cursorClass2);
	    }
	    
	    /**
	     * build the mouse down cursor  
	     * 
	     */	    
	    override public function buildCursorMouseDown():void
	    {
	    	cursor.setCursorMouseDown(cursorClass1);
	    }
	    
	    /**
	     * build the busy mouse cursor  
	     * 
	     */		    
	    override public function buildCursorMouseBusy():void
	    {
	    	cursor.setCursorMouseBusy(cursorClass3);
	    }
	    
	    /**
	     * Create the name of the cursor set
	     * 
	     */		    	    
	    override public function buildName():void
	    { 
	        cursor.setName("MOUSE_HAND"); 
	    }
	    
	    /**
	     * Method to change the cursor on mouse down event
	     * 
	     * @param events	Handle mouse down event
	     * 
	     */	    
	    private function mouseDownEventHandler(event:MouseEvent):void {
	    	cursor.setMouseDownCursor(); 
	    }
	    
	    /**
	     * Method to change the cursor up mouse down event
	     * 
	     * @param events	Handle mouse up event
	     * 
	     */		    
	    private function mouseUpEventHandler(event:MouseEvent):void {
    		cursor.setMouseUpCursor();  
	    }	    
	}
}