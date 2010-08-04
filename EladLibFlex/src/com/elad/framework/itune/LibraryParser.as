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

*/
package com.elad.framework.itune
{
	import com.adobe.utils.PseudoThread;
	import com.elad.framework.multiuploader.LocalFileHelper;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import mx.core.FlexGlobals;
	
	/**
	 *  Utility class of parsing iTune xml library into a readable collection that can be used.
	 * 
     * @example The following example create a basic music player:
     * <listing version="3.0">
	 *	<Script>
	 *			private var localFileHelper:LocalFileHelper;
	 *			
	 *			public function browse_clickHandler(event:MouseEvent=null):void 
	 *			{
	 *				localFileHelper = new LocalFileHelper( FileTypeFormat.FILE_FILTER_XML_TYPE );
	 *				
	 *				localFileHelper.addEventListener(LocalFileEvent.FILE_LOAD_BROWSE, onFileSelect);
	 *				localFileHelper.addEventListener(LocalFileEvent.FILE_CANCEL, function():void { Alert.show("Cancel"); } );
	 *				localFileHelper.addEventListener(LocalFileErrorEvent.FILE_ERROR, function():void { trace("file error") } );
	 *				
	 *				localFileHelper.browse();
	 *			}
	 *			
	 *			private function onFileSelect(event:LocalFileEvent):void
	 *			{
	 *				localFileHelper.addEventListener(LocalFileLoadedEvent.DATA_LOADED, onDataLoaded );
	 *				localFileHelper.load();
	 *			}
	 *			
	 *			private function onDataLoaded(event:LocalFileLoadedEvent):void
	 *			{
	 *				try {
	 *					var libraryParser:LibraryParser = new LibraryParser();
	 *					libraryParser.parsePlaylistsFromItunesLibrary(event.byteLoaded, parserProgressCallback, onParserCompleteCallback);
	 *				} catch(er:Error){
	 *					showError();
	 *					return;
	 *				}				
	 *			}
	 *			
	 *			private function parserProgressCallback(value:String):void
	 *			{
	 *				trace(value);
	 *			}
	 *			
	 *			public function onParserCompleteCallback(playlists:Array):void
	 *			{
	 *				Alert.show("Completed");
	 *				
	 *				dg.dataProvider = playlists;
	 *			}
	 *			
	 *			protected function showError(error:String="", closeFunc:Function=null):void 
	 *			{
	 *				if (!error) error = "Valid iTunes library file not found. Please select a valid 'iTunes Music Library.xml' file.";
	 *				Alert.show(error, "iTunes Import Error", 4, null, closeFunc);
	 *			}
	 *	</Script>
	 * 
	 */	
	public class LibraryParser extends EventDispatcher
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		public var playlists:Array = [];
		
		private var thread:PseudoThread;
		private var allSongsXML:XMLList;
		private var allSongIdToElementHash:Object = {};
		private var totalTracks:int = 0;
		private var libraryBA:ByteArray;
		private var libraryXML:XML;
		private var libraryPlaylistsXML:XMLList;
		private var currentLibraryPlaylist:XML;
		private var parserProgressCallback:Function;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * <p>We are using a psudo thread to chunk this parsing so it doesn't freeze the display on large lists.
		 * the thread will run the thread func as many times as it thinks it can get away with per frame interval 
		 * and the display will have a chance to catch up.</p>
		 *  
		 * @param library
		 * @param parserProgressCallback
		 * @param onParserCompleteCallback
		 * 
		 */		
		public function parsePlaylistsFromItunesLibrary(library:ByteArray, parserProgressCallback:Function=null, 
														onParserCompleteCallback:Function=null):void
		{
			libraryBA = library;
			this.parserProgressCallback = parserProgressCallback;
			if (parserProgressCallback!=null) parserProgressCallback("Parsing ITunes XML");
			
			//wait two milliseconds so the last preloader update can render
			setTimeout(function():void 
			{
				thread = new PseudoThread(FlexGlobals.topLevelApplication.systemManager, doPlaylistParseChunk, {});
				
				thread.addEventListener("threadComplete", function(event:Event):void 
				{
					event.currentTarget.removeEventListener(event.type, arguments.callee); 
					if (onParserCompleteCallback!=null)
						onParserCompleteCallback(playlists);
				});
				
			}, 200);
		}
		
		/**
		 * Method to convert the byte array into XML and than parse it in chunks 
		 *  
		 * @param data
		 * @return 
		 * 
		 */		
		private function doPlaylistParseChunk(data:Object):Boolean
		{
			if (!libraryXML)
			{
				//NOTE: this conversion can take a few seconds and may be better to be factored into 
				// the preloading process
				trace("onItunesLibraryFileLoadComplete, converting byte array to text: " +getTimer()/1000);
				libraryXML = LocalFileHelper.convertByteArrayToXML( libraryBA );
				
				return true;
			}
			
			if (!allSongsXML)
			{
				if (parserProgressCallback!=null) parserProgressCallback("Parsing Songs");	
				allSongsXML = libraryXML.dict.dict.dict;
				
				return true;
			}
			
			if (!totalTracks)
			{
				if (parserProgressCallback!=null) parserProgressCallback("Building Song Bank");	
				trace("start indexing itunes songs: "+getTimer()/1000);
				
				for each (var songDict:XML in allSongsXML)
				{
					totalTracks++;
					allSongIdToElementHash[songDict.integer[0].text().toString()] = songDict;
				}
				
				return true;
			} 
			
			if (!libraryPlaylistsXML)
			{
				trace("start building playlists: "+getTimer()/1000);
				libraryPlaylistsXML = libraryXML.dict.array.dict;
				currentLibraryPlaylist = libraryPlaylistsXML[0];
			} 
			else 
			{
				if (currentLibraryPlaylist) 
					currentLibraryPlaylist = libraryPlaylistsXML[currentLibraryPlaylist.childIndex()+1];
			}
			
			if (currentLibraryPlaylist)
			{
				//filter out master library - stored under playlist
				if (XMLList(currentLibraryPlaylist.key.(text()=="Master")).length()) 
					return true;
				
				//filter out "smart playlists" like Library, Music, Movies, My Most Played, My Top Rated, Recently Added
				if (XMLList(currentLibraryPlaylist.key.(text()=="Smart Info")).length()) 
					return true;
				
				//filter out playlists with "Distinguished Kind" key: Podcasts, Purchased, Genius, iTunes DJ
				if (XMLList(currentLibraryPlaylist.key.(text()=="Distinguished Kind")).length()) 
					return true;
				
				trace("building playlist: '"+currentLibraryPlaylist.string[0]+"': "+getTimer()/1000);
				
				if (parserProgressCallback!=null) 
					parserProgressCallback("Building Playlist: "+currentLibraryPlaylist.string[0]);
				
				var playlist:ITunesPlaylistVO = new ITunesPlaylistVO(currentLibraryPlaylist.integer[0], currentLibraryPlaylist.string[0]);
				
				for each(var songID:XML in currentLibraryPlaylist.array.dict.integer)
				{
					var songDict2:XML = allSongIdToElementHash[songID.text().toString()];
					playlist.songs.push(new ITunesTrackVO(songDict2));
				}
				
				if (playlist.songs.length) playlists.push(playlist);
					return true;
			}
			
			//cleanup
			allSongsXML = null;
			allSongIdToElementHash = null;
			libraryBA = null;
			libraryXML = null;
			libraryPlaylistsXML = null;
			currentLibraryPlaylist = null;
			thread = null;
			
			return false;
		}
	}
}