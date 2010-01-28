/*
 
     Copyright (c) 2009 Elad Elrom.  Elrom LLC. All rights reserved. 
    
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
     @contact elad.ny at gmail.com

 */
package com.elad.framework.multiuploader.enum
{
	import flash.net.FileFilter;

	public final class FileTypeFormat
	{
		
	    //--------------------------------------------------------------------------
	    //
	    //  Enum
	    //
	    //--------------------------------------------------------------------------
	    
		/**
		 * Media types 
		 */		
		public static const FILE_FILTER_TEXT_TYPE:Array = [new FileFilter("Text File Format", ";*.txt;*.text")];
		public static const FILE_FILTER_VIDEO_TYPE:Array = [new FileFilter("Video File Format", ";*.flv")];
		public static const FILE_FILTER_IMAGE_TYPE:Array = [new FileFilter("Image File Format", ";*.jpeg;*.jpg;*.png;*.gif")];
		public static const FILE_FILTER_AUDIO_TYPE:Array = [new FileFilter("Music File Format", ";*.mp3")];
		public static const FILE_FILTER_XML_TYPE:Array = [new FileFilter("XML File Format", ";*.xml")];
		
		/**
		 * All files 
		 */		
		public static const FILE_FILTER_ALL_FILES_TYPE:Array = [new FileFilter("All files", "*.*")];
		
		/**
		 * Static method to return all media types avaliable based on the ones set in this class 
		 * @return 
		 * 
		 */		
		public static function allMediaTypes():Array
		{
			var retArray:Array = new Array();
			var str:String = (FILE_FILTER_TEXT_TYPE[0] as FileFilter).extension + (FILE_FILTER_VIDEO_TYPE[0] as FileFilter).extension  + 
				(FILE_FILTER_IMAGE_TYPE[0] as FileFilter).extension + (FILE_FILTER_AUDIO_TYPE[0] as FileFilter).extension + 
				(FILE_FILTER_AUDIO_TYPE[0] as FileFilter).extension;			
			
			retArray = [new FileFilter("All Media Formats", str )];
			
			return retArray;
		}
	}
}