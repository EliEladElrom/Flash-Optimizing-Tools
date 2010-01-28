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
package com.elad.framework.musicplayer
{
	import com.elad.framework.musicplayer.events.DownloadEvent;
	import com.elad.framework.musicplayer.events.Id3Event;
	import com.elad.framework.musicplayer.events.PlayProgressEvent;
	import com.elad.framework.musicplayer.events.PlayerEvent;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Timer;

	/**
	 *  Dispatched while downloading a music file in progress
	 *
	 *  @eventType com.elad.framework.musicplayer.events.DownloadEvent.DOWNLOAD_PROGRESS
	 */
	[Event(name="downloadProgress", type="com.elad.framework.musicplayer.events.DownloadEvent")]

	/**
	 *  Dispatched when music file was downloaded successfully
	 *
	 *  @eventType com.elad.framework.musicplayer.events.DownloadEvent.DOWNLOAD_COMPLETED
	 */
	[Event(name="downloadCompleted", type="com.elad.framework.musicplayer.events.DownloadEvent")]
	
	/**
	 *  Dispatched when track playing is completed
	 *
	 *  @eventType com.elad.framework.musicplayer.events.PlayerEvent.TRACK_COMPLETED
	 */
	[Event(name="playerError", type="com.elad.framework.musicplayer.events.PlayerEvent")]
	
	/**
	 *  Dispatched when there is an error playing a track
	 *
	 *  @eventType com.elad.framework.musicplayer.events.PlayerEvent.PLAYER_ERROR
	 */
	[Event(name="trackCompleted", type="com.elad.framework.musicplayer.events.PlayerEvent")]
	
	/**
	 *  Dispatched while track progress playing
	 *
	 *  @eventType com.elad.framework.musicplayer.events.PlayProgressEvent.PLAYER_PROGRESS
	 */
	[Event(name="playerProgress", type="com.elad.framework.musicplayer.events.PlayProgressEvent")]
	
	/**
	 *  Dispatched when data information is avaliable regarding a track
	 *
	 *  @eventType com.elad.framework.musicplayer.events.ID3
	 */
	[Event(name="id3", type="com.elad.framework.musicplayer.events.Id3Event")]
						
	/**
	 * This class is the foundation for creating an audio music player.  The class includes all the methods needed such as 
	 * play, stop, pause as well as lunch event as the track is playing, downloading and catching track information.
     * 
     * @example The following example create a basic music player:
     * <listing version="3.0">
	 *	<Script>
	 *			import com.elad.framework.musicplayer.events.Id3Event;
	 *			import com.elad.framework.musicplayer.events.PlayerEvent;
	 *			import com.elad.framework.musicplayer.Player;
	 *			import mx.events.SliderEvent;
	 *			import com.elad.framework.musicplayer.events.DownloadEvent;
	 *			import com.elad.framework.musicplayer.events.PlayProgressEvent;
	 *			
	 *			private var player:Player = new Player();
	 *			private var songUrl:String;
	 *		
	 *			private function playSong():void
	 *			{
	 *				player.addEventListener(PlayProgressEvent.PLAYER_PROGRESS, onPlayerProgress);
	 *				player.addEventListener(DownloadEvent.DOWNLOAD_PROGRESS, onDownloadProgress);
	 *				player.addEventListener(PlayerEvent.PLAYER_ERROR, onPlayerError);
	 *				player.addEventListener(Id3Event.ID3, onTrackDataInformation);
	 *				player.playTrack(songUrl);  // songLenght
	 *			}
	 *			
	 *			private function onTrackDataInformation(event:Id3Event):void
	 *			{
	 *				songInfoText.text = event.id3.artist+" - "+event.id3.album;
	 *			}
	 *			
	 *			private function onPlayerProgress(event:PlayProgressEvent):void
	 *			{
	 *				songSlider.value = event.playPosition;
	 *				currentTimeText.text = Player.formatTimeInSecondsToString(event.playPosition);
	 *				totalTimeText.text = Player.formatTimeInSecondsToString(event.total);
	 *				songSlider.maximum = event.total;
	 *			}
	 *			
	 *			private function onPlayerError(event:PlayerEvent):void
	 *			{
	 *				throw new Error(event.message);
	 *			}
	 *			
	 *			protected function dragStartHandler(event:SliderEvent):void
	 *			{
	 *				player.removeEventListener(PlayProgressEvent.PLAYER_PROGRESS, onPlayerProgress);
	 *			}
	 *			
	 *			private function onDownloadProgress(event:DownloadEvent):void
	 *			{
	 *				progressBar.setProgress(event.bytesLoaded, event.bytesTotal);
	 *			}
	 *
	 *			protected function dragDropHandler(event:SliderEvent):void
	 *			{
	 *				player.setTrackPosition(songSlider.value);
	 *				player.addEventListener(PlayProgressEvent.PLAYER_PROGRESS, onPlayerProgress);
	 *			}		
	 *	</Script>
	 *	
	 *	<Text id="songInfoText" x="10" y="5" text="Artist - song name" />
	 *	
	 *	<HSlider id="songSlider" y="25" x="10" width="400" minimum="0" showTrackHighlight="true" liveDragging="true" 
	 *		thumbDrag="dragStartHandler(event)" thumbRelease="dragDropHandler(event)"/>
	 *	<ProgressBar id="progressBar" y="45" x="15" width="390" height="1" minimum="0" maximum="100" labelWidth="0"
	 *		direction="right" mode="manual"  />
	 *		
	 *	<Text y="45" x="420" text="Track Loader"/>
	 *	
	 *	<HBox y="30" x="420" horizontalGap="0">
	 *		<Text id="currentTimeText" text="00:00"/>
	 *		<Text text="/"/>
	 *		<Text id="totalTimeText" text="00:00"/>		
	 *	</HBox>
	 *	
	 *	<HBox y="60" x="10" horizontalGap="12">
	 *		<Button id="playButton" label="play" click="playSong();" enabled="false" />
	 *		<Button label="pause" click="player.pauseTrack()" />
	 *		<Button label="stop" click="songSlider.value=0; currentTimeText.text = '00:00'; player.stopTrack()" />
	 *		<Button label="fastforward" click="player.fastforward();" />
	 *		<Button label="rewind" click="player.rewind();" />		
	 *	</HBox>	
	 *	
	 *	<FormItem y="90">
	 *		<FormItem label="Music Url:" />
	 *		<HBox>
	 *			<TextInput id="textInput" width="200" height="20" text="http://www.YourServer.com"/>
	 *			<Button label="Submit" click="this.songUrl=textInput.text; playSong(); playButton.enabled=true" />			
	 *		</HBox>
	 *	</FormItem>
     * </listing>
     * 
     * @see flash.media.Sound
     * @see flash.net.URLRequest
     * @see flash.utils.Timer
     * @see com.elad.framework.musicplayer.IPlayer
     * @see com.elad.framework.musicplayer.AbstractPlayer
	 *  
	 */		
	public class Player extends AbstractPlayer implements IPlayer 
	{

	    //--------------------------------------------------------------------------
	    //
	    //  Constructor
	    //
	    //--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 */			
		public function Player()
		{
		}

	    //--------------------------------------------------------------------------
	    //
	    //  Class methods
	    //
	    //--------------------------------------------------------------------------
	    
        /**
         * Method to play track, based on url.  The method handles cases where the user clicked on play after it is already playing and for 
         * cases where the track was paused. Music file doesn't provide the lenght of the song right away, but it's changing during the progress 
         * of the music file, so you can pass the lenght of the song, if you know it, other wise you can take if from the <code>PlayProgressEvent</code>
         *  
         * @param songUrl song url is the location of the music file.
         * @param songLenght downloading music file doesn't provide the lenght of the song right away, but after portion of the song downloaded
         * 
         */	    
        override public function playTrack(songUrl:String, songLenght:Number=0):void
        {
        	if (isPause)
        	{
        		replay();
        		return;
        	}
        	
        	if (isPlaying)
        	{
        		return;
        	}
        	
        	songURL = songUrl;
        	songLength = Number((songLenght/1000).toFixed(2));
        	
            var request:URLRequest = new URLRequest(songUrl);
            sound = new Sound();
            
            sound.addEventListener(Event.COMPLETE, downloadCompleteHandler);
            sound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            sound.addEventListener(ProgressEvent.PROGRESS, downloadProgressHandler);
            sound.load(request);

            channel = sound.play();
            channel.addEventListener(Event.SOUND_COMPLETE, trackCompleteHandler);

            soundPosition = new Timer(50);
            soundPosition.addEventListener(TimerEvent.TIMER, positionTimerHandler);
            soundPosition.start();
            isPlaying = true;
        }

        
        /**
         * Method to remove all listener and empty objecs once track stoped. 
         * 
         */        
        override protected function resetPlayer():void
        {
            this.isPause = false;
            this.isPlaying = false;
            
            sound.removeEventListener(Event.COMPLETE, downloadCompleteHandler);
            sound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            sound.removeEventListener(ProgressEvent.PROGRESS, downloadProgressHandler);
            channel.removeEventListener(Event.SOUND_COMPLETE, trackCompleteHandler);
            soundPosition.removeEventListener(TimerEvent.TIMER, positionTimerHandler);

            sound = null;
			channel = null;
            soundPosition = null;            
        }
        
        /**
         * Replay method used internally. 
         * 
         */        
        private function replay():void
        {
        	channel = sound.play(pausePosition);
        	soundPosition.start();
        	
        	isPause = false;
        }
        
        /**
         * Static method used to convert a time in seconds to the following format '0:00'. 
         *  
         * @param time time in seconds
         * 
         */        
        public static function formatTimeInSecondsToString(time:Number):String
        {
        	var retVal:String = "";
        	
        	var timeString:String = (time/60).toFixed(2);
        	var timeArray:Array = timeString.split(".");
        	
        	if (timeArray[1] == 60)
        	{
        		timeArray[0] += 1;
        		timeArray[1] -= 60;
        	}
        	
        	var minutes:String = (timeArray[0].toString().length < 2) ? "0"+timeArray[0].toString() : timeArray[0].toString();
        	var seconds:String = (timeArray[1].toString().length < 2) ? "0"+timeArray[1].toString() : timeArray[1].toString();
        	
        	retVal = minutes+":"+seconds;
        	
        	return retVal;
        }     
        
	    //--------------------------------------------------------------------------
	    //
	    //  Event handlers
	    //
	    //--------------------------------------------------------------------------
	    
        /**
         * Sends an event once the track position changed.  
         * @param event
         * 
         */	    
        private function positionTimerHandler(event:TimerEvent):void 
        {
            songPosition = Number((channel.position/1000).toFixed(2));
            var totalPosition:Number = Number((this.sound.length/1000).toFixed(2));
            
            if (songLength < totalPosition)
            {
            	songLength = totalPosition;
            }
            
            if (songLength > 0 && songPosition > 0)
            {
            	this.dispatchEvent( new PlayProgressEvent(songPosition, songLength) );
            }
        }
		
        /**
         * Download complete handler
         * @param event
         * 
         */		
        private function downloadCompleteHandler(event:Event):void 
        {
        	sound.removeEventListener(Event.COMPLETE, downloadCompleteHandler);
        	sound.removeEventListener(ProgressEvent.PROGRESS, downloadProgressHandler);
        	
            this.dispatchEvent(new DownloadEvent(DownloadEvent.DOWNLOAD_COMPLETED, fileBytesTotal, fileBytesTotal));
        }
		
        /**
         * ID3 information 
         * @param event
         * 
         */		
        private function id3Handler(event:Id3Event):void 
        {
            this.dispatchEvent(event);
        }
		
        /**
         * Method to handle io errors. 
         * @param event
         * 
         */		
        private function ioErrorHandler(event:Event):void 
        {
        	sound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYER_ERROR, "Error loading music file, please check cross domain policy and that file exists."+event.toString()));
            resetPlayer();
        }

        /**
         * Progress handler
         *  
         * @param event
         * 
         */
        private function downloadProgressHandler(event:ProgressEvent):void 
        {
            this.dispatchEvent(new DownloadEvent(DownloadEvent.DOWNLOAD_PROGRESS, event.bytesLoaded, event.bytesTotal));
            fileBytesTotal = event.bytesTotal;
            
            // check if ID3 information is avaliable, needed since id3 event doesn't always work correctly.
            if (this.sound.id3.album != null || this.sound.id3.artist != null || this.sound.id3.songName != null || this.sound.id3.genere != null)
            {
            	var evt:Id3Event = new Id3Event(this.sound.id3);
            	id3Handler(evt);
            }
        }
		
        /**
         * Track complete handler
         * @param event
         * 
         */		
        private function trackCompleteHandler(event:Event):void 
        {
        	channel.removeEventListener(Event.SOUND_COMPLETE, trackCompleteHandler);
            resetPlayer();
            this.dispatchEvent(new PlayerEvent(PlayerEvent.TRACK_COMPLETED));
        }
		
	}
}