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
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	/**
	 * This class is the blueprint for the music player, it describes the rules by which player behave.
	 * 
	 */	
	public class AbstractPlayer extends EventDispatcher 
	{
	    
	    //--------------------------------------------------------------------------
	    //
	    //  Variables
	    //
	    //--------------------------------------------------------------------------
	    
        protected var sound:Sound;
        protected var channel:SoundChannel;
        protected var soundPosition:Timer;
        protected var fileBytesTotal:Number;
		
		/**
		 * Holds the pause position 
		 */		
		protected var pausePosition:Number;
		
		/**
		 * Flag indicating weather the track is in pause mode 
		 */		
		protected var isPause:Boolean = false;
		
		/**
		 * Flag to indicate weather the track is currently playing 
		 */		
		protected var isPlaying:Boolean = false;         
        
        /**
         * Play position in seconds 
         */        
        private var _songPosition:Number;
        
        /**
         * Total song length in seconds 
         */        
        private var _songLength:Number;
        
        /**
         * Song URL 
         */        
        private var _songURL:String;
        
	    //--------------------------------------------------------------------------
	    //
	    //  Getters and setters
	    //
	    //--------------------------------------------------------------------------
	    
	    public function get songPosition():Number
	    {
	    	return _songPosition;
	    }
	    
	    public function set songPosition(val:Number):void
	    {
	    	_songPosition = val;
	    }
	    
	    public function get songLength():Number
	    {
	    	return _songLength;
	    }
	    
	    public function set songLength(val:Number):void
	    {
	    	_songLength = val;
	    }
	    
	    public function get songURL():String
	    {
	    	return _songURL;
	    }
	    
	    public function set songURL(val:String):void
	    {
	    	_songURL = val;
	    }

	    //--------------------------------------------------------------------------
	    //
	    //  Constructor
	    //
	    //--------------------------------------------------------------------------
	    	    		
		public function AbstractPlayer()
		{
		}
		
        /**
         * Method to play track, based on url.  The method handles cases where the user clicked on play after it is already playing and for 
         * cases where the track was paused. Music file doesn't provide the lenght of the song right away, but it's changing during the progress 
         * of the music file, so you can pass the lenght of the song, if you know it, other wise you can take if from the <code>PlayProgressEvent</code>
         *  
         * @param songUrl song url is the location of the music file.
         * @param songLenght downloading music file doesn't provide the lenght of the song right away, but after portion of the song downloaded
         * 
         */	    
        public function playTrack(songUrl:String, songLenght:Number=0):void
        {
        	// needs to implement
        }  
              
        /**
         * Method to pause a track. 
         * 
         */        
        public function pauseTrack():void
        {
        	soundPosition.stop();
        	channel.stop();
			
			isPause = true;        	
        	pausePosition = channel.position;
        }
        
        /**
         * Stop track method 
         * 
         */        
        public function stopTrack():void
        {
        	soundPosition.stop();
        	channel.stop();
        	resetPlayer();
        }
        
        /**
         * Method to change the position of the track 
         * @param newPosition position is provided in milliseconds
         * 
         */        
        public function setTrackPosition(newPosition:Number):void
        {
        	soundPosition.stop();
        	channel.stop();
        	
        	var currentPosition:Number = channel.position/1000;
        	var position:Number
        	
        	if (newPosition<currentPosition)
        	{
        		position = newPosition*1000;
        	}
        	else
        	{
        		position = Math.min(sound.length, newPosition*1000);
        	}
        		
        	channel = sound.play(position);
        	soundPosition.start();
        }
        
        /**
         * Method to remove all listener and empty objecs once track stoped. 
         * 
         */        
        protected function resetPlayer():void
        {
        	// needs to implement
        }        
        
        /**
         * Method to fast forward a track
         * @param timeInSeconds time to fast forward, default is 2 seconds
         * 
         */        
        public function fastforward(timeInSeconds:Number=2):void
        {
        	var currentPosition:Number = channel.position/1000;
        	setTrackPosition(timeInSeconds+currentPosition);
        }
        
        /**
         * Method to rewind a track
         * @param timeInSeconds time to rewind, default is 2 seconds
         * 
         */        
        public function rewind(timeInSeconds:Number=2):void
        {
        	var currentPosition:Number = channel.position/1000;
        	setTrackPosition(currentPosition-timeInSeconds);     	
        }

        
        /**
         * Method to adjust sound volume 
         * @param vol volume in precentage between 0-1
         * 
         */        
        public function setVolume(vol:Number):void
        {
        	var transform:SoundTransform = new SoundTransform(vol);
        	channel.soundTransform = transform;
        }                 		
	}
}