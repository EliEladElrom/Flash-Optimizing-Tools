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
	 * Abstract builder - set all the methods to be used by each concrete 
	 * class and keep cursor class as protected
	 * 
	 * @author Elad Elrom
	 *
	 */

	import mx.core.FlexSprite;
	
	public class AbstractCursorBuilder
	{
	    protected var cursor:Cursor;

		/**
		 * Method getCursor return an instanes of the cursor class.
		 * 
		 * @return The Cursor class instance.
		 * @see com.elad.framework.cursor.Cursor
		 * 
		 */		 
	    public function getCursor():Cursor
	    { 
	        return this.cursor; 
	    }

		/**
		 * Method to create the cursor class.
		 * 
		 * @see com.elad.framework.cursor.Cursor
		 * 
		 */	    
	    public function createNewCursorProduct():void
	    { 
	        cursor = new Cursor(); 
	    }

		/**
		 * Method to remove the custom cursor. The method will be eventually 
		 * initiate the CursorManager.removeAllCursors(); method.
		 * 
		 * @see mx.managers.CursorManager;
		 * 
		 */	    
	    public function removeCursor():void
	    {
	    	cursor.removeCursor();
	    }

		/**
		 * Method to be declate in each concrete product class.  
		 * It is used to set different mouse for each mouse event.  
		 * It takes the current UI and impliments the mouse events. 
		 * 
		 * @param	flexSprite	You can set any UI that is an extention of the FlexSprite most basic flex class, similiar to Sprite in Actionscript
		 * @see mx.core.FlexSprite
		 * 
		 */	    
	    public function setEvents(flexSprite:FlexSprite):void
	    {
	    }

		/**
		 * Method to create regular mouse cursor.
		 * 
		 */
	    public function buildCursorMouse():void
	    {
	    }

		/**
		 * Method to create mouseup cursor.
		 * 
		 */	    
	    public function buildCursorMouseUp():void
	    {
	    }
	    
		/**
		 * Method to create mouse down cursor.
		 * 
		 */	    
	    public function buildCursorMouseDown():void
	    {
	    }
	    
		/**
		 * Method to create busy cursor.
		 * 
		 */	    
	    public function buildCursorMouseBusy():void
	    {
	    }	
	    
		/**
		 * Method to set the name of the set of cursors.
		 * 
		 */	        		
		public function buildName():void
	    { 
	    }	    
	}
}