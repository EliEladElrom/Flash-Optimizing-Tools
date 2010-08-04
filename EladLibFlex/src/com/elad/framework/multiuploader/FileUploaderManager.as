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
package com.elad.framework.multiuploader
{
	import com.elad.framework.multiuploader.events.FileUploaderManagerErrorEvent;
	import com.elad.framework.multiuploader.events.FileUploaderManagerFileLoadedEvent;
	import com.elad.framework.multiuploader.events.LocalFileErrorEvent;
	import com.elad.framework.multiuploader.events.LocalFileLoadedEvent;
	import com.elad.framework.multiuploader.vo.FileCollectionVO;
	import com.elad.framework.multiuploader.vo.FileVO;
	import com.elad.framework.multiuploader.vo.PostVarsCollectionVO;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 *  Dispatched when a file is selected by the user
	 *
	 *  @eventType com.elad.framework.utils.events.FILE_LOADED
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Event(name="fileLoaded", type="com.elad.framework.utils.events.FileUploaderManagerFileLoadedEvent")]
	
	/**
	 *  Dispatched when an error occour 
	 *
	 *  @eventType com.elad.framework.utils.events.UPLOAD_MANAGER_ERROR
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Event(name="uploadManagerError", type="com.elad.framework.utils.events.FileUploaderManagerErrorEvent")]
	
	
	public class FileUploaderManager extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		// Singleton instance.
		protected static var instance:FileUploaderManager;
		
		/**
		 * Headers to append to each file loaded request 
		 */		
		private var requestHeaders:Array = [];
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		private var _fileCollection:FileCollectionVO = new FileCollectionVO();
		public function get fileCollection():FileCollectionVO
		{
			return _fileCollection;
		}
		
		public function set fileCollection(value:FileCollectionVO):void
		{
			_fileCollection = value;
		}
		
		private var localFileHelper:LocalFileHelper;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------		
		
		public function FileUploaderManager( enforcer:AccessRestriction )
		{
			if (enforcer == null)
				throw new Error("Error enforcer input param is undefined" );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------		
		
		/**
		 * Add upload request header name values pair
		 *  
		 * @param name
		 * @param value
		 * 
		 */		
		public function addURLRequestHeaderItem( name:String, value:String ):void 
		{
			requestHeaders.push(new URLRequestHeader(name, value));
		}		
		
		/**
		 * Add all the files the user selected during the browse process and set the collection.
		 *  
		 * @param postVarsCollection
		 * @param fileReference
		 * @param fileType
		 * @param dataField
		 * @param uploadUrl
		 * 
		 */		
		public function add( postVarsCollection:PostVarsCollectionVO, fileReference:*, 
								 fileType:Array, dataField:String, uploadUrl:String ):void
		{
			
			var file:FileVO;
			
			// find out if it's multiple file list
			if ( (fileReference as Object).hasOwnProperty("fileList") )
			{
				// multifile
				this.fileCollection.setFilesReferences( fileReference.fileList );
			}
			else
			{
				this.fileCollection.setFilesReferences( new Array() );
				this.fileCollection.addItemToFileRefences( fileReference );
			}
			
			var len:int = fileCollection.getFilesReferencelength();
			
			for ( var i:int = 0; i<len; i++ )
			{
				if (this.fileCollection.length > 0)
				{
					file = this.fileCollection.getItemByName( fileCollection.getFileReference(i).name );
				}
				
				if ( file == null )
				{
					file = new FileVO( postVarsCollection );
					fileCollection.addItem( file );
					file.fileType = fileType;
					file.dataField = dataField;
					file.uploadUrl = uploadUrl;
					file.fileName = fileCollection.getFileReference(i).name;
					
					localFileHelper = new LocalFileHelper( fileType );
					localFileHelper.addEventListener(LocalFileLoadedEvent.DATA_LOADED, onDataLoaded );
					localFileHelper.addEventListener(LocalFileErrorEvent.FILE_ERROR, function(evt:LocalFileErrorEvent):void {
						dispatchedErrorMessage(evt.description);
					} );					
					
					localFileHelper.load( fileCollection.getFileReference(i) );
				}
			}
		}
		
		/**
		 * Method to remove file item based on name
		 *  
		 * @param fileName
		 * 
		 */		
		public function removeItemByName(fileName:String):void
		{
			var file:FileVO;
			
			for ( var i:int = 0; i<fileCollection.length; i++ )
			{
				file = fileCollection.getItem( i );
				
				if ( file.fileName == fileName )
				{
					this.fileCollection.removeItemAt( i );
				}
			}
		}
		
		/**
		 * Method to upload all selected item/s to a proxy server side script. 
		 * 
		 */		
		public function uploadAllFiles():void
		{
			var file:FileVO;
				
			for ( var i:int = 0; i<fileCollection.length; i++ )
			{
				file = fileCollection.getItem( i );
				
				if ( file.isFileSelected )
				{
					uploadFile( file );
				}
			}
		}
		
		/**
		 * Method to upload one file at a time
		 * 
		 * @param file
		 * 
		 */		
		public function uploadFile( file:FileVO ):void
		{
			var urlRequest:URLRequest;
			var index:int;
			
			index = this.fileCollection.getIndexByFileName( file.fileName );
			urlRequest = getUrlRequest( file );
			
			this.localFileHelper.upload( this.fileCollection.getFileReference( index ), urlRequest, file.dataField, true, 
				function(event:ProgressEvent):void 
				{
					// onProgressCallback
					var file:FileVO = fileCollection.getItemByName( event.target.name );
					
					file.byteLoaded = event.bytesLoaded;
					file.byteTotal = event.bytesTotal;
					
					// set the global bytes loaded var
					fileCollection.setTotalBytesLoaded();
				}, 
				function(event:Event):void 
				{
					// onCompleteCallback
					var file:FileVO = fileCollection.getItemByName( event.target.name );
					
					file.byteLoaded = event.target.data.bytesAvailable;
					file.byteTotal = event.target.data.bytesAvailable;
					file.isFileUploading = false;
					
					// find out weather the upload of all files is completed
					if ( !fileCollection.isFilesUploadingCheck() )
					{
						fileCollection.isFilesUploading = false;
					}
				},
				function(event:DataEvent):void 
				{
					// onDataCallBack
					var file:FileVO = fileCollection.getItemByName( event.target.name );
				},
				function(event:Event):void
				{
					// onStartedCallBack
					var file:FileVO = fileCollection.getItemByName( event.target.name );
					file.isFileUploading = true;
					
					fileCollection.isFilesUploading = true;
				}						
			);			
		}		
		
		/**
		 * Method to load an individual file 
		 * 
		 * @param file
		 * 
		 */		
		private function getUrlRequest( file:FileVO ):URLRequest
		{
			var urlVariables:URLVariables = new URLVariables();
			var len:int = file.postVarsCollection.length;
			var name:String;
			var value:String;
			
			// add variables
			for (var i:int; i<len; i++)
			{
				name = file.postVarsCollection.getItem( i ).name;
				value = file.postVarsCollection.getItem( i ).value;
				
				urlVariables[name] = value;
			}
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = file.uploadUrl;
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = urlVariables;
			
			if ( requestHeaders.length && requestHeaders != null )
			{
				urlRequest.requestHeaders = requestHeaders.concat();
			}
			
			return urlRequest;
		}
		
		/**
		 * Method to dispatch an error message
		 *  
		 * @param message
		 * 
		 */		
		private function dispatchedErrorMessage(message:String):void
		{
			var evt:FileUploaderManagerErrorEvent = new FileUploaderManagerErrorEvent(message);
			this.dispatchEvent( evt );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------		
		
		/**
		 * Handler that get called once file uploaded to the flash player
		 *  
		 * @param event
		 * 
		 */		
		private function onDataLoaded(event:LocalFileLoadedEvent):void
		{
			var file:FileVO = fileCollection.getItemByName(event.fileName);
			
			// avoid memory leaks
			var index:int = fileCollection.getIndexByFileName( file.fileName );
			var len:int = fileCollection.length -1;
			
			if (index == len)
			{
				localFileHelper.removeEventListener(LocalFileLoadedEvent.DATA_LOADED, onDataLoaded );
			}
			
			// set the content byte total & file name
			file.fileContent = event.byteLoaded;
			file.fileName = event.fileName;
			
			this.dispatchEvent( new FileUploaderManagerFileLoadedEvent( file ) );
		}
		
		/**
		 * Method function to retrieve instance of the class
		 *  
		 * @return The same instance of the class
		 * 
		 */
		public static function getInstance():FileUploaderManager
		{
			if( instance == null )
				instance = new  FileUploaderManager( new AccessRestriction() );
			
			return instance;
		}
	}
}

class AccessRestriction {}