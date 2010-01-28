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
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;

	/**
	 * Helper to read a file from a server and save it on user's local
	 * machine.
	 *  
	 * @author Elad Elrom
	 * 
	 */
	public class DownloadManager extends EventDispatcher
	{
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;

	    private var stream:URLStream = new URLStream();
	    private var request:URLRequest; 
		private var fileStream:FileStream = new FileStream();
        
        public var bytesLoaded:Number = 0;
        public var bytesTotal:Number = 0;		
					
		public function DownloadManager()
		{
			super();
		}
		
		/**
		 * Method to download a file from a server. 
		 * 
		 * @param fileURL the server URL
		 * @param fileLocalLocation the location to be saved
		 * 
		 */		
		public function downloadFileFromServer(fileURL:String, fileLocalLocation:String):void
		{
			//var file:File = File.desktopDirectory.resolvePath(fileLocalLocation);
			var file:File = File.applicationStorageDirectory.resolvePath(fileLocalLocation);
			request = new URLRequest(fileURL);
	        fileStream.openAsync(file, FileMode.WRITE);
	        
	        stream.addEventListener(ProgressEvent.PROGRESS, onDownloadProgress);
	        stream.addEventListener(Event.COMPLETE, onDownloadComplete);
			
	        stream.load(request);
		}
		
        /**
         * Event handler to handle the async progress events.
         * 
         * @param event
         * 
         */		
        private function onDownloadProgress(event:ProgressEvent):void 
        {
            var byteArray:ByteArray = new ByteArray();
            var precent:Number = Math.round(bytesLoaded*100/bytesTotal);
            
            bytesLoaded = event.bytesLoaded;
            bytesTotal = event.bytesTotal;
                                        
            stream.readBytes(byteArray, 0, stream.bytesAvailable);
            fileStream.writeBytes(byteArray, 0, byteArray.length);
			
			var progressEvent:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
			progressEvent.bytesLoaded = bytesLoaded;
			progressEvent.bytesTotal = bytesTotal;
			
			this.dispatchEvent(progressEvent);
    	}
    	
    	/**
    	 * Event handler to handle the event complete.
    	 * 
    	 * @param event
    	 * 
    	 */    	
    	private function onDownloadComplete(event:Event):void
    	{
            fileStream.close();
            stream.close(); 
            
            stream.removeEventListener(ProgressEvent.PROGRESS, onDownloadProgress);
            stream.removeEventListener(Event.COMPLETE, onDownloadComplete);
            
			var completeEvent:Event = new Event(Event.COMPLETE);
			this.dispatchEvent(completeEvent);            
    	}		
	}
}