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
package com.elad.framework.utils.enum
{
	import flash.net.FileFilter;

	public final class FileTypeFormat
	{
		
	    //--------------------------------------------------------------------------
	    //
	    //  Enum
	    //
	    //--------------------------------------------------------------------------
	    		
		public static const FILE_FILTER_TEXT_TYPE:Array = [new FileFilter("Text File Format", "*.txt;*.text")];
		public static const FILE_FILTER_VIDEO_TYPE:Array = [new FileFilter("Video File Format", "*.flv;*.mp3")];
		public static const FILE_FILTER_ALL_FILES_TYPE:Array = [new FileFilter("All files", "*.*")];
	}
}