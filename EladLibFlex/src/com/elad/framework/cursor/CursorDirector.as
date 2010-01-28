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
	* The class is the director that set all the properties for the product (cursor).  It allow us to create
	* different cursor set and set them throughout the application.
	*/
	
	import mx.core.FlexSprite;
	
	public class CursorDirector
	{
	    private var cursorBuilder:AbstractCursorBuilder;

		/**
		 * Method to set the cursor director instance with the concrete type of cursor types and properties.
		 * 
		 */	 
	    public function setCursorBuilder(pb:AbstractCursorBuilder):void
	    {
	        cursorBuilder = pb; 
	    }
	    
	    /**
	     * Method to return an instance of the concrete type of cursor
	     * 
	     * @return	Cursor	The cursor set that was created using the concrete propeties. 
	     * 
	     */	    
	    public function getCursor():Cursor
	    { 
	        return cursorBuilder.getCursor(); 
	    }

	    /**
	     * Method to create all the methods in the cursor. 
	     * 
	     * @param flexSprite	Most basic UI, will be used to set all the events.
	     * 
	     */	 
	    public function constructCursor(flexSprite:FlexSprite):void
	    {	    	
	        cursorBuilder.createNewCursorProduct();
	        cursorBuilder.removeCursor();
	        cursorBuilder.setEvents(flexSprite);
	        cursorBuilder.buildName();
	        cursorBuilder.buildCursorMouseDown();
	        cursorBuilder.buildCursorMouseUp();
	        cursorBuilder.buildCursorMouse();
	        cursorBuilder.buildCursorMouseBusy();
	    }
	}
}