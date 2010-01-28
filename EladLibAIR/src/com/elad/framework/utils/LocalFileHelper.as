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
	import com.elad.framework.utils.enum.FileTypeFormat;
	import com.elad.framework.utils.enum.InteractionStates;
	import com.elad.framework.utils.events.LocalFileErrorEvent;
	import com.elad.framework.utils.events.LocalFileEvent;
	import com.elad.framework.utils.events.LocalFileLoadedEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	/**
	 *  Dispatched when a file is selected by the user
	 *
	 *  @eventType com.elad.framework.utils.events.FILE_LOAD_BROWSE
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Event(name="fileLoadBrowse", type="com.elad.framework.utils.events.LocalFileEvent")]

	/**
	 *  Dispatched when a file is selected when the use is saving the file
	 *
	 *  @eventType com.elad.framework.utils.events.FILE_SAVE_BROWSE
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Event(name="fileSaveBrowse", type="com.elad.framework.utils.events.LocalFileEvent")]
		
	/**
	 *  Dispatched when a file is canceled by the user
	 *
	 *  @eventType com.elad.framework.utils.events.FILE_CANCEL
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Event(name="fileCancel", type="com.elad.framework.utils.events.LocalFileEvent")]	

	/**
	 *  Dispatched when a file was saved successfully
	 *
	 *  @eventType com.elad.framework.utils.events.FILE_SAVE_SUCCESSFULLY
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Event(name="fileSaveSuccessfully", type="com.elad.framework.utils.events.LocalFileEvent")]	
	
	/**
	 *  Dispatched when a file data is loaded
	 *
	 *  @eventType com.elad.framework.utils.events.DATA_LOADED
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Event(name="dataLoaded", type="com.elad.framework.utils.events.LocalFileLoadedEvent")]
	
	/**
	 *  Dispatched when a file browse produce an error or any other type of errors
	 *
	 *  @eventType com.elad.framework.utils.events.FILE_ERROR
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Event(name="fileError", type="com.elad.framework.utils.events.LocalFileErrorEvent")]	

	/**
	 * <p>Utility class to read and write local files</p>
	 * 
	 * <p>Before the release of Flash 10 we needed to use some sort of a server side proxy 
	 * or Javascript in order to read or write file in the user’s system.  
	 * We would send the request to a proxy, which will handle the request and send it back
	 *  to Flash once completed.  Flash Player 10 has exposed two new methods 
	 * in FileReference: load and save.  The new methods allow you to read and write data
	 *  right into the user’s local system.  You get information about the files
	 *  such as modify date, creator, size and other properties, however unlike AIR’s FileStream
	 *  API the location of the files will not be visible to us and we can only do asynchronous calls.</p>
	 * 
	 * <p>Recently, Adobe have closed a gap and forced the load and save methods to be used follow user 
	 * interaction, such as clicking a button, so the user will be aware of being asked to save or load and not see a browse window comes out of nowhere.</p>
	 * 
	 * @example
	 * <listing>
	 *    <Script>
	 *     <![CDATA[
	 *   		import com.elad.framework.utils.events.LocalFileErrorEvent;
	 *    		import com.elad.framework.utils.events.LocalFileLoadedEvent;
	 *    		import mx.controls.Alert;
	 *    		import com.elad.framework.utils.events.LocalFileEvent;
	 *   		import com.elad.framework.utils.enum.FileTypeFormat;
	 *    		import com.elad.framework.utils.LocalFileHelper;
	 *   		import mx.events.FlexEvent;
	 *    		
	 *    		private var localFileHelper:LocalFileHelper;
	 *
	 *    		protected function initializeHandler(event:FlexEvent):void
	 *    		{
	 *    			localFileHelper = new LocalFileHelper( FileTypeFormat.FILE_FILTER_TEXT_TYPE );
	 *    			
	 *    			localFileHelper.addEventListener(LocalFileEvent.FILE_LOAD_BROWSE, onFileSelect);
	 *    			localFileHelper.addEventListener(LocalFileEvent.FILE_SAVE_BROWSE, function():void { trace("Save browse complete"); } );
	 *    			localFileHelper.addEventListener(LocalFileEvent.FILE_SAVE_SUCCESSFULLY, function():void { trace("Save complete!"); } );
	 *    			localFileHelper.addEventListener(LocalFileEvent.FILE_CANCEL, function():void { Alert.show("Cancel"); } );
	 *    			localFileHelper.addEventListener(LocalFileErrorEvent.FILE_ERROR, function():void { trace("file error") } );
	 *    		}
	 *    		
	 *    		private function loadFile():void
	 *    		{
	 *    			localFileHelper.browse();
	 *    		}
	 *			
	 *			private function onFileSelect(event:LocalFileEvent):void
	 *			{
	 *				localFileHelper.addEventListener(LocalFileLoadedEvent.DATA_LOADED, onDataLoaded );
	 *				localFileHelper.load();
	 *			}
	 *				     		
	 *			private function onDataLoaded(event:LocalFileLoadedEvent):void
	 *			{
	 *				output.text = LocalFileHelper.convertByteArrayToText( event.byteLoaded );
	 *			}
	 *			
	 *			private function saveFile():void
	 *			{
	 *				localFileHelper.save( output.text, "test.txt" );
	 *			} 		
	 *
	 *        ]]>
	 *	</Script>
	 *     
	 *  <FxButton label="Load" click="loadFile()" />
	 *  <FxButton label="Save" click="saveFile()"  x="84"/>
	 *  <TextArea id="output" y="37" width="397" height="327"/>
     * 
	 * </listing>
	 * 
	 * @see flash.net.FileReference
	 * @see com.elad.framework.utils.enum.InteractionStates
	 * @see com.elad.framework.utils.enum.FileTypeFormat
	 * 
	 * 
	 */
	public class LocalFileHelper extends EventDispatcher
	{

	    //--------------------------------------------------------------------------
	    //
	    //  Variables
	    //
	    //--------------------------------------------------------------------------
    	
		/**
		 * @private
		 *  
		 */    	
		private var fileType:Array;
		
		/**
		 * @private
		 *  
		 */  		
		private var fileReference:FileReference;
		
		/**
		 * @private
		 *  
		 */		
		private var interactionState:String;

	    //--------------------------------------------------------------------------
	    //
	    //  Constructor
	    //
	    //--------------------------------------------------------------------------
	    
		/**
		 * Default constructor, which call the <code>reset</code> method to set the file reference and type.
		 * 
		 * @param fileType	you can set the type of files you want to use.  The file types are listed in <code>FileTypeFormat</code>
		 * @see	com.elad.framework.utils.enum.FileTypeFormat
		 * 
		 */	    
		public function LocalFileHelper(fileType:Array=null)
		{
			reset(fileType);
		}
		
		/**
		 * Reset method will allow the implementation to reset the file reference and set again the file type filter.
		 * The default file type is <code>FileTypeFormat.FILE_FILTER_ALL_FILES_TYPE</code> which will allow selecting 
		 * any file type.
		 *  
		 * @param fileType	you can set the type of files you want to use.  The file types are listed in <code>FileTypeFormat</code>
		 * @see	com.elad.framework.utils.enum.FileTypeFormat
		 * 
		 */		
		public function reset(fileType:Array=null):void
		{
			if (fileType == null)
			{
				fileType = FileTypeFormat.FILE_FILTER_ALL_FILES_TYPE;	
			}
			
			this.fileType = fileType;
			fileReference = new FileReference();			
		}
		
		/**
		 * The browse method is useful when you need to load a file, you first browse for the file and than you load the file.
		 * When you browse for the file the file type that was selected is used. 
		 * 
		 */		
		public function browse():void
		{
			this.interactionState = InteractionStates.BROWSE;
			
			fileReference.addEventListener(Event.SELECT, onFileSelectEventHandler);
            fileReference.addEventListener(Event.CANCEL, onFileCancelEventHandler);

			fileReference.browse(fileType);	
		}
		
		/**
		 * Static method to convert the <code>ByteArray</code> data into a string.
		 * 
		 * @example
		 * <listing version="3.0">
		 * 	var text:String = LocalFileHelper.convertByteArrayToText( event.byteLoaded );
		 * </listing>  
		 *  
		 * @param data
		 * @return 
		 * 
		 */		
		public static function convertByteArrayToText(data:ByteArray):String
		{
			var retVal:String;
			retVal = data.readUTFBytes(data.bytesAvailable);
			
			return retVal;
		}
		
		/**
		 * Method to load a file.  The method add event listeners and use the <code>fileReference.load</code> 
		 * method to do the loading.  To load a file you must first call the <code>browse</code> method.
		 * 
		 */		
		public function load():void
		{
			if (this.interactionState != InteractionStates.BROWSE)
			{
				this.dispatchEvent( new LocalFileErrorEvent( "You must browse before trying to load a file!" ) );
			}
			
			this.interactionState = InteractionStates.LOAD_FILE;
			
            fileReference.addEventListener(Event.COMPLETE, onCompleteEventHandler);
            fileReference.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorEventHandler);

            fileReference.load();			
		}
		
		/**
		 * Save method can be used to save data into a file.  The method must follow a user interaction.
		 *  
		 * @param data	Any type of data
		 * @param fileName	You can set the file name, ie: "test.txt" 
		 * 
		 */		
		public function save(data:*, fileName:String):void
		{
			this.interactionState = InteractionStates.SAVE_FILE;
			
			fileReference.addEventListener(Event.COMPLETE, onCompleteEventHandler);
			fileReference.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorEventHandler);
			
			fileReference.addEventListener(Event.SELECT, onFileSelectEventHandler);
			fileReference.addEventListener(Event.CANCEL, onFileCancelEventHandler);
			
			fileReference.save(data, fileName);			
		}

	    //--------------------------------------------------------------------------
	    //
	    //  Event handlers
	    //
	    //--------------------------------------------------------------------------
		
		/**
		 * Method to handle the two cases where the browse gets calls:
		 * 
		 * <ul>
		 * 	<li>Once you browse to load a file</li>
		 * 	<li>Once browse is used when saving a file</li>
		 * </ul>
		 * 
		 * <p>The internal <code>InteractionStates</code> is used to know which case we are dealing with.
		 * 
		 * @param event
		 * 
		 */		
		private function onFileSelectEventHandler(event:Event):void
		{
			fileReference.removeEventListener(Event.SELECT, onFileSelectEventHandler);
			fileReference.removeEventListener(Event.CANCEL, onFileCancelEventHandler);
			
			if (this.interactionState == InteractionStates.BROWSE)
				this.dispatchEvent( new LocalFileEvent( LocalFileEvent.FILE_LOAD_BROWSE ) );
			else
				this.dispatchEvent( new LocalFileEvent( LocalFileEvent.FILE_SAVE_BROWSE ) );
		}
		
		/**
		 * Method to be called in case the used decide to cancel the option to save or load a file.
		 * The method is related to the browse window.
		 * 
		 * @param event
		 * 
		 */		
		private function onFileCancelEventHandler(event:Event):void
		{
			fileReference.removeEventListener(Event.SELECT, onFileSelectEventHandler);
			fileReference.removeEventListener(Event.CANCEL, onFileCancelEventHandler);
						
			this.dispatchEvent( new LocalFileEvent( LocalFileEvent.FILE_CANCEL ) );
		}
		
		/**
		 * In case an IOError gets called when trying to load or save a file this method will 
		 * be dispatched.
		 * 
		 * @param event
		 * 
		 */		
		private function onIOErrorEventHandler(event:Event):void
		{
			fileReference.removeEventListener(Event.COMPLETE, onCompleteEventHandler);
			fileReference.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorEventHandler);
						
			this.dispatchEvent( new LocalFileErrorEvent( "FileReference: IOErrorEvent.IO_ERROR received: "+event.toString() ) );
		}
		
		/**
		 * Method to handle the two cases where the complete gets calls:
		 * 
		 * <ul>
		 * 	<li>Once complete loading a file</li>
		 * 	<li>Once coomplete saving a file</li>
		 * </ul>
		 * 
		 * <p>The internal <code>InteractionStates</code> is used to know which case we are dealing with.
		 * 
		 * @param event
		 * 
		 */		
		private function onCompleteEventHandler(event:Event):void
		{
			fileReference.removeEventListener(Event.COMPLETE, onCompleteEventHandler);
			fileReference.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorEventHandler);
			
			if (this.interactionState == InteractionStates.LOAD_FILE)
				this.dispatchEvent( new LocalFileLoadedEvent( fileReference.data ) );
			else
				this.dispatchEvent( new LocalFileEvent( LocalFileEvent.FILE_SAVE_SUCCESSFULLY ) );
		}			
	}
}