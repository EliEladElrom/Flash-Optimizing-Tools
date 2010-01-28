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
	* Cursor is the "product" that will used by the application to display the cursor mouse sets.
	* It will use the CursorManager API built into Flex to set the different curor types.
	* 
	*/
	
	import flash.ui.Mouse;
	
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	
	public class Cursor
	{

	    protected var name:String;
	    protected var cursorMouse:Class;
	    protected var cursorMouseUp:Class;
	    protected var cursorMouseDown:Class;
	    protected var cursorMouseBusy:Class;
	    protected var copyCursorMouseDown:Class;
	    protected var copyCursorMouseUp:Class;

		/**
		 * Method to set regular cursor to the application.
		 * 
		 */
	    public function setCursor():void
	    {
	    	removeCursor();
	    	CursorManager.setCursor(cursorMouse);
	    }
	    
		/**
		 * Method to set busy cursor to the application.
		 * 
		 */	    
	    public function setBusyCursor():void
	    {
	    	removeCursor();
	    	cursorMouseUp=cursorMouseBusy;
	    	cursorMouseDown=cursorMouseBusy;
	    	CursorManager.setCursor(cursorMouseBusy);
	    }

		/**
		 * Method to set busy cursor to the application. With the application being disabled.
		 * To be used when you don't want the user to be able to use the application until busy is off
		 * 
		 * @see mx.core.Application
		 * 
		 */		    
	    public function setBusyCursorApplicationDisabled():void
	    {
	    	removeCursor();
	    	cursorMouseUp=cursorMouseBusy;
	    	cursorMouseDown=cursorMouseBusy;
	    	CursorManager.setCursor(cursorMouseBusy);
	    	FlexGlobals.topLevelApplication.enabled=false;
	    }	    

		/**
		 * Method to set mouse down cursor.
		 * 
		 */		    
	    public function setMouseDownCursor():void
	    {
	    	removeCursor();
	    	CursorManager.setCursor(cursorMouseUp);
	    }
	    
		/**
		 * Method to set mouse up cursor.
		 * 
		 */		    
	    public function setMouseUpCursor():void
	    {
	    	removeCursor();
	    	CursorManager.setCursor(cursorMouseDown);
	    }

		/**
		 * Method to retrieve the name of the cursor name
		 * 
		 */		    
	    public function getCursorSetName():String {
	    	return name;
	    }

		/**
		 * Method to remove busy cursor.
		 * 
		 */		    
	    public function removeBusyCursor():void
	    {
	    	FlexGlobals.topLevelApplication.enabled=true;
	    	removeCursor();
	    	cursorMouseUp=copyCursorMouseUp;
	    	cursorMouseDown=copyCursorMouseDown;
	    	CursorManager.setCursor(cursorMouse);	    	
	    }
	     
		/**
		 * Method to remove all the cursors.
		 * 
		 */		    
	    internal function removeCursor():void
	    { 
	    	CursorManager.removeAllCursors();
	    	Mouse.hide();
	    }
	    
		/**
		 * Method to set name of the mouse cursor name
		 * 
		 * @param	name	Name of the cursr set, can be retrieve when needed, to know which cursor set is used.
		 * 
		 */		    
	    internal function setName(name:String):void
	    { 
	    	this.name = name; 
	    }

		/**
		 * Method to set cursor mouse object
		 * 
		 * @param	cursorMouse	Object can be swf, image or sprite
		 */	
	    internal function setCursorMouse(cursorMouse:Class):void
	    { 
	    	this.cursorMouse = cursorMouse; 
	    }
	    
		/**
		 * Method to set cursor mouse up object.
		 * 
		 * @param	cursorMouseUp	Object can be swf, image or sprite
		 * 
		 */		    
	    internal function setCursorMouseUp(cursorMouseUp:Class):void
	    { 
	    	this.cursorMouseUp = cursorMouseUp; 
	    	this.copyCursorMouseUp = cursorMouseUp;
	    }
	    
		/**
		 * Method to set cursor mouse down object.
		 * 
		 * @param	cursorMouseDown	Object can be swf, image or sprite
		 * 
		 */		    
	    internal function setCursorMouseDown(cursorMouseDown:Class):void
	    { 
	    	this.cursorMouseDown = cursorMouseDown;
	    	this.copyCursorMouseDown = cursorMouseDown; 
	    }
	    
		/**
		 * Method to set cursor busy mouse object.
		 * 
		 * @param	cursorMouseBusy	Object can be swf, image or sprite
		 * 
		 */		    
	    internal function setCursorMouseBusy(cursorMouseBusy:Class):void
	    { 
	    	this.cursorMouseBusy = cursorMouseBusy;
	    }	    		         
	}
}