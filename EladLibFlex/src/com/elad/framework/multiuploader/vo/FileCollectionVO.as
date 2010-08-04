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
	import flash.net.FileReference;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/**
	 *
	 * Defines the <code>AssetCollectionVO<code> Value Object implementation
	 *
	 */
	public class FileCollectionVO
	{	
		
		/**
		 * Flag to indicate weather we are uploading files or not 
		 */		
		public var isFilesUploading:Boolean = false;
		
		/**
		 *  Holds the total bytes loaded 
		 */		
		public var bytesLoaded:uint = 0;
		
		/**
		 * Holds the collection of files 
		 */		
		private var _collection:ArrayCollection;
		
		/**
		 * Holds the files reference list
		 */		
		private var filesReference:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function FileCollectionVO(collection:ArrayCollection = null) 
		{
			if (collection == null)
			{
				_collection = new ArrayCollection();
			}
			else
			{
				_collection = collection;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------		
		
		public function addItem(item:FileVO):void
		{
			_collection.addItem(item);
		}
		
		public function getItem(index:int):FileVO
		{
			return _collection.getItemAt(index) as FileVO;
		}
		
		public function get length():Number
		{
			return _collection.length;
		}
		
		public function get collection():ArrayCollection
		{
			return _collection;
		}
		
		/**
		 * Find item by file name
		 *  
		 * @param fileName
		 * @return the item found
		 * 
		 */				
		public function getItemByName(fileName:String):FileVO
		{
			var retFile:FileVO = null;
			
			for (var i:int=0; i<this.length; i++)
			{
				if (this.getItem(i).fileName == fileName)
				{
					retFile =  this.getItem( i );
					break;
				}
			}
			
			return retFile;
		}
		
		public function removeItemAt(index:int):void
		{
			this._collection.removeItemAt( index );
			this.filesReference.splice( index, 1);
		}
		
		/**
		 * Find item index in collection based on file name 
		 * 
		 * @param fileName
		 * @return 
		 * 
		 */		
		public function getIndexByFileName( fileName:String ):int
		{
			var index:int = 0;
			
			for (var i:int=0; i<this.length; i++)
			{
				if (this.getItem(i).fileName == fileName)
				{
					index =  i;
					break;
				}
			}
			
			return index;
		}
		
		/**
		 * Utility method to take all the selected files from a list component and 
		 * find a file based on name and set it to selected. 
		 *  
		 * @param fileName
		 * 
		 */		
		public function setSelectedFiles(selectedItems:Vector.<Object>):void
		{
			var len:int = selectedItems.length;
			var file:FileVO;
			var index:int;
			
			setAllSelectedItemStatus(false);
			
			for (var i:int = 0; i<len; i++)
			{
				file = this.getItemByName( selectedItems[i].fileName );
				file.isFileSelected = true;
			}
		}
		
		/**
		 * Method to set all items in the collection to selected or un-selected
		 * 
		 */		
		public function setAllSelectedItemStatus(status:Boolean):void
		{
			var file:FileVO;
			
			for (var i:int = 0; i<this.length; i++)
			{
				file = _collection.getItemAt(i) as FileVO;
				file.isFileSelected = status;
			}
		}
		
		/**
		 * Method to find how many bytes are selected
		 *  
		 * @return total bytes selected 
		 * 
		 */		
		public function getTotalBytesSelected():int
		{
			var file:FileVO;
			var totalBytes:int = 0;
			
			for (var i:int = 0; i<this.length; i++)
			{
				file = _collection.getItemAt(i) as FileVO;
				
				if ( file.isFileSelected )
				{
					totalBytes += file.fileContent.bytesAvailable;
				}
			}
			
			return totalBytes;
		}
		
		/**
		 * Method to calculate the current bytes loaded
		 *  
		 * @return 
		 * 
		 */		
		public function setTotalBytesLoaded():void
		{
			var file:FileVO;
			var totalBytesLoaded:int = 0;
			
			for (var i:int = 0; i<this.length; i++)
			{
				file = _collection.getItemAt(i) as FileVO;
				totalBytesLoaded += file.byteLoaded;
			}
			
			this.bytesLoaded = totalBytesLoaded;			
		}
		
		/**
		 * Method to find out weather there are any files that are currently being uploaded
		 *  
		 * @return 
		 * 
		 */		
		public function isFilesUploadingCheck():Boolean
		{
			var retVal:Boolean = false;
			var file:FileVO;
			
			for (var i:int = 0; i<this.length; i++)
			{
				file = _collection.getItemAt(i) as FileVO;
				
				if (file.isFileUploading)
				{
					retVal = true;
					break;
				}
			}
			
			return retVal;
		}
		
		/**
		 * List of file references.  There are two cases user upload the list the first time or the
		 * list is uploaded already.
		 * 
		 * @param array
		 * 
		 */		
		public function setFilesReferences(array:Array):void
		{
			if ( this.filesReference == null ) // 1st time
			{
				this.filesReference = array;
			}
			else  // any time after
			{
				var len:int = array.length;
				
				for (var i:int = 0; i<len; i++)
				{
					this.filesReference.push( array[i] );
				}				
			}
		}
		
		/**
		 * Allow getting a file reference from the list
		 * 
		 * @param index
		 * @return 
		 * 
		 */		
		public function getFileReference(index:int):FileReference
		{
			if ( filesReference.length-1 < index )
			{
				new Error("File Reference with index " + index + " dosen't exist.");
			}
			
			return filesReference[index] as FileReference;
		}
		
		/**
		 * Add item to file reference list
		 *  
		 * @param fileReference
		 * 
		 */		
		public function addItemToFileRefences( fileReference:FileReference ):void
		{
			filesReference[0] = fileReference;
		}
		
		/**
		 * Method to retrieve the length of the list of files references 
		 * @return
		 * 
		 */		
		public function getFilesReferencelength():int
		{
			return filesReference.length;
		}
	}
}