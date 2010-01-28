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

 */

package com.elad.framework.autosuggest
{
	import mx.controls.TextInput;
	import mx.controls.listClasses.TileBase;

	/**
	 * Interface method to keep the TextInput and TileBase protected.
	 * 
	 * @author Elad Elrom
	 */		
	public interface IUIAutoSuggestClient 
	{
		/**
		 * Set the TextInput that will be used in the user interface 
		 * 
		 * @param	textInput	The XML which will be used as original list to sort from.
		 */
		function set input(textInput : TextInput ) : void;
		
		/**
		 * Set the TileBase that will be used in the user interface.
		 * 
		 * @param	tileList	The XML which will be used as original list to sort from.
		 */				
		function set output(tileList : TileBase ) : void;
	}
}