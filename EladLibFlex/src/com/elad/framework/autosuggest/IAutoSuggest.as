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

	/**
	 * Interface to be implemented by AutoSuggest class.
	 *  
	 * @author Elad Elrom
	 * 
	 */
	public interface IAutoSuggest
	{
		/**
		 * Converts an xml list into an array.
		 * 
		 * @param The XML which will be converted into an array.
		 * 
		 * @return An array with the list of words converted from XML.
		 * 
		 */	
		function convertXMLToArray( xml : XML ) : Array;
		
		/**
		 * Method to get the list of keyword after the list was sorted.
		 * 
		 * @return An array with the list of words.
		 * 
		 */		
		function getKeywordsList() : Array;

		/**
		 * Method to feed the list of keywords.
		 * 
		 * @param	xml	The XML which will be used as original list to sort from.
		 * 
		 */			
		function setKeywordsList( xml : XML ) : void;

		/**
		 * method to sort the list of keywords for specific letter/s or word/s.
		 * 
		 * @param	text	the text string that will be used to sort the list.
		 * 
		 * @return An array with the sorted list of words.
		 * 
		 */		
		function sortList(  text : String ) : Array;

	}
}