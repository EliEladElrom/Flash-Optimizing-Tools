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
	 * Abstraction of the Auto suggest API handle all the data.
	 * 
	 * @author Elad Elrom
	 *
	 */

	public class AbstractAutoSuggest implements IAutoSuggest
	{
		[Bindable] public var result : String;		
		protected var keywordsList : Array;
		protected var sortedKeywordsList : Array = new Array();

		/**
		 * Converts an xml list into an array.
		 * 
		 * @param The XML which will be converted into an array.
		 * 
		 * @return An array with the list of words converted from XML.
		 * 
		 * @see com.elad.framework.autosuggest.IAutoSuggest
		 * 
		 */		
		public function convertXMLToArray( xml : XML ) : Array
		{
			var array : Array = new Array();
			var n:int =  xml.*.length();
			
			for (var i : int = 0; i < n; i++)
			{
				array[i] = String(xml.*[i]);
			}

			return array;			
		}

		/**
		 * Method to get the list of keyword after the list was sorted.
		 * 
		 * @return An array with the list of words.
		 * 
		 * @see com.elad.framework.autosuggest.IAutoSuggest
		 * 
		 */		
		public function getKeywordsList() : Array
		{
			return sortedKeywordsList;
		}

		/**
		 * Method to feed the list of keywords.
		 * 
		 * @param	xml	The XML which will be used as original list to sort from.
		 * 
		 * @see com.elad.framework.autosuggest.IAutoSuggest
		 * 
		 */		
		public function setKeywordsList( xml : XML ) : void
		{
			keywordsList = convertXMLToArray( xml );
		}

		/**
		 * method to sort the list of keywords for specific letter/s or word/s.
		 * 
		 * @param	text	the text string that will be used to sort the list.
		 * 
		 * @return An array with the sorted list of words.
		 * 
		 * @see com.elad.framework.autosuggest.IAutoSuggest
		 * 
		 */		
		public function sortList( text : String ) : Array
		{
			var resultKeywordsList : Array = new Array();
			var words : Array = new Array();
			var wordsLen : int;
			
			words = removePunctuationAndSplitWords( text );
			wordsLen = words.length;

			for ( var i : int; i < wordsLen; i++ )
			{
				trace(i+" Check "+words[i]);
				resultKeywordsList = searchForTextInList( keywordsList, words[i] );				
			}
	
			return resultKeywordsList;			
		}
		
		/**
		 * Search a list of words for a specific text. 
		 * 
		 * @param list	Lists of words.
		 * @param	text	Text to search for.
		 * 
		 * @return	An array of the list of words that the method found. 
		 * 
		 */		
		protected function searchForTextInList( list : Array, text : String ) : Array
		{
			var counter : int = -1;
			var resultKeywordsList : Array = new Array();
			var listLen : int = list.length;
			
			for ( var i : int; i < listLen; i++ )
			{
			   if ( (substringBeginsWithString( list[i], text )) || (stringContainsSubstringCheck( list[i], text )) )
			   {
					//trace( keywordsList[i] );
					resultKeywordsList[++counter] = keywordsList[i];			   	
			   }
			}
			
			return resultKeywordsList;			
		}

		/**
		 * Method to check for a letter/s whithin any part of the keyword.
		 * 
		 * @param	keyword	The keyword that need to be searched.
		 * @param	text	The text that need to be searched for.
		 * 
		 * @return	A value of <code>true</code> means the text was found in the keyword. 
		 * <code>false</code> means that the text was not found in the keyword.
		 * 
		 */		
		protected function stringContainsSubstringCheck( keyword : String, text : String ) : Boolean 
		{	
			var returnValue : Boolean = false;
			
			if ( (keyword.indexOf( text.toLowerCase() ) != -1) && (text.toLowerCase().length > 1) )
			{
				returnValue = true
			}
			
			return  returnValue;
		}

		/**
		 * Method to check for a letter/s whithin the beginning of the keyword.
		 * 
		 * @param	keyword	The keyword that need to be searched.
		 * @param	text	The text that need to be searched for.
		 * 
		 */		
		protected function substringBeginsWithString( keyword : String, text : String) : Boolean 
		{	
			var returnValue:Boolean = false;
			
			if ( keyword.toLowerCase().substring(0, text.length) == text.toLowerCase() )
			{
				returnValue = true
			}
			return returnValue;
		}

		/**
		 * Remove punctuations and split words.
		 * 
		 * @param	text	keyword that need to check for punctuation.
		 * 
		 * @return	Return the list of words after it removes all the punctuations.
		 */			
		protected function removePunctuationAndSplitWords( text : String ) : Array {
			
			var words : Array = new Array();
			var wordsWithPunctuation : Array;
			var counter : int = -1;
			
			wordsWithPunctuation = text.split( /[^a-zA-Z0-9]+/ );
			
			for ( var i: int; i < wordsWithPunctuation.length; i++ )
			{
				if ( wordsWithPunctuation[i] != "" )
				{
					words[++counter] = wordsWithPunctuation[i];					
				}
			}
			return words;
		}	
	}
}