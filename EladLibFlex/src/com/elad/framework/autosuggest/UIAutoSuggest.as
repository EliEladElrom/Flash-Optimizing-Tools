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
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.controls.TextInput;
	import mx.controls.listClasses.TileBase;
	import mx.events.FlexEvent;
	
	/**
	 * Auto Suggest User interface handle the TileBase and TextInput related operations and events. 
	 * 
	 * @author Elad Elrom
	 */	
	public class UIAutoSuggest extends AbstractAutoSuggest implements IUIAutoSuggestClient
	{
		protected var textInput : TextInput;
		protected var tileList : TileBase;

		/**
		 * Set the TextInput that will be used in the user interface 
		 * 
		 * @param	textInput	The XML which will be used as original list to sort from.
		 * 
		 * @see com.elad.framework.autosuggest.IUIAutoSuggestClient
		 */
		public function set input( textInput : TextInput ) : void
		{
			this.textInput = textInput;
		}

		/**
		 * Set the TileBase that will be used in the user interface.
		 * 
		 * @param	tileList	The XML which will be used as original list to sort from.
		 * 
		 * @see com.elad.framework.autosuggest.IUIAutoSuggestClient
		 * 
		 */		
		public function set output( tileList : TileBase ) : void
		{
			this.tileList = tileList;
		}
		
		/**
		 * Method to feed the list of keywords.
		 * 
		 * @param	xml	The XML which will be used as original list to sort from.
		 */		
		public override function setKeywordsList( xml : XML ) : void
		{
			super.setKeywordsList( xml );
			initEventListners();
		}
		
		/**
		 * Initiate the event listners.
		 */			
		protected function initEventListners():void 
		{
			textInput.addEventListener( Event.CHANGE, ChangeEventHandler );
			textInput.addEventListener( FlexEvent.ENTER, PressEnterEventHandler );
			textInput.addEventListener( KeyboardEvent.KEY_DOWN, TextInputKeyboardEventHandler );
			tileList.addEventListener( MouseEvent.CLICK, ListMouseClickedEventHandler );
			tileList.addEventListener( KeyboardEvent.KEY_DOWN, ListKeyDownEventHandler );			
		}		

		/**
		 * Event handler for user clicking the enter key.
		 * 
		 * @param	event	the event returned with the value from the keyboard.
		 */			
		protected function PressEnterEventHandler( event : FlexEvent ) : void 
		{
			selectedWord( textInput.text );
		}
		
		/**
		 * Set the result. This method can also be changed to add an option to lunch coringorm event. 
		 * 
		 * <p>This method also set the text input to the value and closes the tile list.</p>
		 * 
		 * @param	word	the keyword that need to be searched.
		 */
		protected function selectedWord( word : String ) : void {
			textInput.text = word;
			result = word;
			tileList.visible = false;
		}
		
		/**
		 * Update the tile list information with the sorted list.
		 */			
		protected function updateTileListDataProivder():void 
		{
			tileList.dataProvider = sortedKeywordsList;
		}
		
		/**
		 * Event handler after a change in the input box is made.
		 * 
		 * @param	event	the event returned with the value from the keyboard.
		 */			
		protected function ChangeEventHandler( event : Event ):void {

			sortedKeywordsList = sortList( event.target.text );
			updateTileListDataProivder();
			tileList.visible = true;				
			
			tileList.visible = ( (sortedKeywordsList.length > 0) && ( String(event.currentTarget.text).length > 0) ) ? true : false;			
		}

		/**
		 * Event handler after a change in the tile list is made.
		 * 
		 * @param	event	The event returned with the value from the keyboard.
		 */			
		protected function ListMouseClickedEventHandler( event : MouseEvent ):void {
			selectedWord( String(event.target.text) );
		}
		/**
		 * Event handler to trace certain keyboard strokes  in tile list.
		 * 
		 * @param	event	The event returned with the value from the keyboard.
		 */			
		protected function ListKeyDownEventHandler( event : KeyboardEvent ):void 
		{
			//trace(event.keyCode);
			switch ( event.keyCode ) 
			{
				// Enter key was presses
				case 13 : 
					selectedWord( String(event.currentTarget.value) );
					break;
				case 27 :
					tileList.visible = false;
					break;					 	
			}			
		}
		
		/**
		 * Event handler to trace certain keyboard strokes in text input.
		 * 
		 * @param	event	the event returned with the value from the keyboard.
		 */		
		protected function TextInputKeyboardEventHandler( event : KeyboardEvent ):void {
			//trace(event.keyCode);
			if (sortedKeywordsList.length > 0)
			{
				switch ( event.keyCode ) 
				{
					// Arrow down key was presses
					case 40 :
						tileList.visible = true;
						tileList.setFocus();
						break;
					// Arrow up key was presses
					case 38 :
						tileList.visible = true;
						tileList.setFocus();
						break;
					case 27 :
						tileList.visible = false;
						break;						
				}				
			}
		}	
	}
}
