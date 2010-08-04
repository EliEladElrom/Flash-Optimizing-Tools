/* 

////////////////////////////////////////////////////////////////////////////////
//
//  Elad Elrom (elad@elromdesign.com)
//  Copyright 2009 Elorm LLC,
//  All Rights Reserved.
//
//  NOTICE: Elad Elrom permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

*/
package com.elad.framework.utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;

	/**
	 * 
	 * Utility class to check weather a file exists or not.  Once the file starts to load the utility will stop loading and return the result.
	 * 
	 * <p>
	 * Example shows how the <code>FileExistsUtil</code>
	 * </p>
	 *
	 * @example
	 * <listing version="3.0">
	 * 
	 * var fileExists:FileExistsUtil = new FileExistsUtil();
	 * fileExists.checkFile("file.jpg", 
	 * function(eventType:String):void
	 * {
	 * 	trace(eventType);
	 * }, 
	 * function(errorType:String, text:String):void
	 * {
	 * 	trace(errorType+": "+text);
	 * });
	 *  
	 * </listing>
	 * 
	 * @see mx.events.CollectionEvent
	 * @see flash.display.Loader;
	 * @see flash.events.Event;
	 * @see flash.events.IOErrorEvent;
	 * @see flash.events.ProgressEvent;
	 * @see flash.events.SecurityErrorEvent;
	 * @see flash.net.URLRequest;
	 *
	 */	
	public class FileExistsUtil
	{
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		
		private var loader:Loader;
		private var request:URLRequest;
		private var successCallback:Function;
		private var errorCallback:Function;
		
		/**
		 *  Default constructor
		 * 
		 */		
		public function FileExistsUtil()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------------		
		
		/**
		 * Method to start the process of checking weather file exists
		 *  
		 * @param url	pass a valid or broken URL
		 * @param successCallback	pass a callback to handle cases where the file exists
		 * @param errorCallback	pass a callback to handle cases where the file cant be loaded
		 * 
		 */		
		public function checkFile(url:String, successCallback:Function, errorCallback:Function):void
		{
			loader = new Loader();
			request = new URLRequest(url);
			this.successCallback = successCallback;
			this.errorCallback = errorCallback;
			
			loader.contentLoaderInfo.addEventListener(Event.INIT, function(event:Event):void {
				
				event.currentTarget.removeEventListener(event.type, arguments.callee);
				
				successCallback(Event.INIT);
				cleanup();
			});

			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void
			{
				event.currentTarget.removeEventListener(event.type, arguments.callee);
				
				errors(IOErrorEvent.IO_ERROR, event.text);
				cleanup();
			} , false, 0, true);
			
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(event:SecurityErrorEvent):void
			{
				event.currentTarget.removeEventListener(event.type, arguments.callee);
				
				errors(SecurityErrorEvent.SECURITY_ERROR, event.text);
				cleanup();
			} , false, 0, true);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete , false, 0, true);			
			
			loader.load( request );
		}
		
		/**
		 * Handle error by calling the callback method
		 *  
		 * @param errorType
		 * @param text
		 * 
		 */		
		private function errors(errorType:String, text:String):void
		{
			errorCallback(errorType, text);
		}

		/**
		 * Method to cleanup and remove listeners 
		 * 
		 */		
		private function cleanup():void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);	
			
			request = null;
			loader = null;
			successCallback = null;
			errorCallback = null;
		}
		
		//--------------------------------------------------------------------------
		//
		// Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Complete event handler
		 *  
		 * @param event
		 * 
		 */		
		private function onComplete(event:Event):void
		{
			successCallback(Event.COMPLETE);
			cleanup();
		}	
	}
}