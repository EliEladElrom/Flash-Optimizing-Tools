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
    [Bindable]
    /**
     *
     * Defines the <code>ITuneTrackVO<code> Value Object implementation
	 * 
     *  example xml:
	 * 
     *		<key>Track ID</key><integer>10342</integer>
     *		<key>Name</key><string>Lives</string>
     *		<key>Artist</key><string>Modest Mouse</string>
     *		<key>Album</key><string>The Moon &#38; Antarctica (Remastered)</string>
     *		<key>Genre</key><string>Indie Rock / Lo-Fi</string>
     *		<key>Kind</key><string>MPEG audio file</string>
     *		<key>Size</key><integer>5945086</integer>
     *		<key>Total Time</key><integer>198713</integer>
     *		<key>Disc Number</key><integer>1</integer>
     *		<key>Disc Count</key><integer>1</integer>
     *		<key>Track Number</key><integer>13</integer>
     *		<key>Track Count</key><integer>19</integer>
     *		<key>Year</key><integer>2004</integer>
     *		<key>Date Modified</key><date>2005-03-27T00:46:10Z</date>
     *		<key>Date Added</key><date>2007-05-23T15:37:39Z</date>
     *		<key>Bit Rate</key><integer>239</integer>
     *		<key>Sample Rate</key><integer>44100</integer>
     *		<key>Play Count</key><integer>1</integer>
     *		<key>Play Date</key><integer>3280848382</integer>
     *		<key>Play Date UTC</key><date>2007-12-18T23:46:22Z</date>
     *		<key>Rating</key><integer>40</integer>
     *		<key>Rating Computed</key><true/>
     *		<key>Album Rating</key><integer>40</integer>
     *		<key>Artwork Count</key><integer>1</integer>
     *		<key>Sort Album</key><string>Moon &#38; Antarctica (Remastered)</string>
     *		<key>Persistent ID</key><string>5F8D931D8A46DFE2</string>
     *		<key>Track Type</key><string>File</string>
     *		<key>Location</key><string>file://localhost/Users/markledford/Music/iTunes/iTunes%20Music/Modest%20Mouse/The%20Moon%20&#38;%20Antarctica%20(Remastered)/13%20Lives.mp3</string>
     *		<key>File Folder Count</key><integer>4</integer>
     *		<key>Library Folder Count</key><integer>1</integer>
	 * 
     * @see com.adobe.cairngorm.vo.IValueObject
     *
     */
	public class ITunesTrackVO
	{
		public var artistName:String;
		public var trackName:String;
		public var albumName:String;
		public var trackId:int;
		public var genre:String;
		public var songLength:int;
		public var year:int;
		public var location:String;
		public var bitRate:int;
		public var sampleRate:int;
		
		public function ITunesTrackVO(songDictXML:XML) 
		{
			var elements:XMLList = songDictXML.elements();
			
			this.artistName = elements[XML(songDictXML.key.(text()=="Artist")[0]).childIndex()+1];
			this.trackName =  elements[XML(songDictXML.key.(text()=="Name")[0]).childIndex()+1];
			this.albumName =  elements[XML(songDictXML.key.(text()=="Album")[0]).childIndex()+1];
			this.trackId =  elements[XML(songDictXML.key.(text()=="Track ID")[0]).childIndex()+1];
			this.genre =  elements[XML(songDictXML.key.(text()=="Genre")[0]).childIndex()+1];
			this.songLength =  elements[XML(songDictXML.key.(text()=="Total Time")[0]).childIndex()+1];
			this.year =  elements[XML(songDictXML.key.(text()=="Year")[0]).childIndex()+1];
			this.location =  elements[XML(songDictXML.key.(text()=="Location")[0]).childIndex()+1];
			this.bitRate =  elements[XML(songDictXML.key.(text()=="Bit Rate")[0]).childIndex()+1];
			this.sampleRate =  elements[XML(songDictXML.key.(text()=="Sample Rate")[0]).childIndex()+1];
		}
	}
}