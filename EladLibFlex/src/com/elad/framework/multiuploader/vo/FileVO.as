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
package com.elad.framework.multiuploader.vo
{
	import flash.utils.ByteArray;
	
	[Bindable]
	public class FileVO
	{
		public var postVarsCollection:PostVarsCollectionVO = new PostVarsCollectionVO();
		public var fileName:String;
		public var fileType:Array;
		public var fileContent:ByteArray;
		public var dataField:String;
		public var uploadUrl:String;
		public var isFileSelected:Boolean;
		public var isFileUploading:Boolean;
		public var byteLoaded:uint;
		public var byteTotal:uint;		
		
		public function FileVO( postVarsCollection:PostVarsCollectionVO, fileName:String = "", fileType:Array = null, 
							   fileContent:ByteArray = null, dataField:String = "", uploadUrl:String = "", isFileSelected:Boolean = false, 
							   isFileUploading:Boolean = false, byteLoaded:uint = 0, byteTotal:uint = 0)
		{
			this.fileType = fileType;
			this.postVarsCollection = postVarsCollection;
			this.fileName = fileName;
			this.fileContent = fileContent;
			this.dataField = dataField;
			this.uploadUrl = uploadUrl;
			this.isFileSelected = isFileSelected;
			
			// variable for uploading the file
			this.isFileUploading = isFileUploading;
			this.byteLoaded = byteLoaded;
			this.byteTotal = byteTotal;
		}
	}
}