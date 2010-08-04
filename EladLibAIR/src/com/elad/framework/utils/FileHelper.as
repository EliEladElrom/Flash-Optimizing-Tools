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
package com.elad.framework.utils
{
	import flash.filesystem.File;

	/**
	 * Method to find files in directory. 
	 *  
	 * @author Elad Elrom
	 * 
	 */	
	public final class FileHelper
	{
		
		/**
		 * Method to find the files in the directoy.
		 *  
		 * @param fileLocalLocation	the URL of a local directory.
		 * @return an array containing the directory listings.
		 * 
		 */		
		public static function getDirectoryFiles(fileLocalLocation:String):Array
		{
			var fileCollection:Array = new Array();
			var checkFile:File;
			var file:File = File.desktopDirectory.resolvePath(fileLocalLocation);		
			
			fileCollection = file.getDirectoryListing();
			
			return fileCollection;
		}
		
		public static function isFileExists(fileCollection:Array, compareName:String):Boolean
		{
			var len:int = fileCollection.length;
			var file:File;
			var retVal:Boolean = false;
			var fileName:String;
			
			for (var i:int; i<len; i++)
			{
				file = fileCollection[i] as File;
				fileName = FileHelper.getFileName(file);
				
				if (fileName == compareName)
				{
					retVal = true;
				}				
			}
			
			return retVal;
		}
		
		public static function getFileName(file:File):String
		{
			var fileSplit:Array;
			var fileName:String;
			
			fileSplit = file.nativePath.split("/");
			fileName = fileSplit[fileSplit.length-1] as String;	
			
			return fileName;		
		}
	}
}