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
package com.elad.optimize.framerate
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	/**
	 * <p>API to help optimize memory usage by switching the swf framerate per seconds (fps) based on weather the user have 
	 * left the screen or not.  The API is lightweight and can be used on an a pure AS3 projects as well as Flex projects. </p>
	 * 
	 * @Example	Here is an example for pure AS3 project.
	 * 
	 * <listing version="3.0">
	 * 		var framerateManager:FrameRateOptimizer = new FrameRateOptimizer( this, true );
	 * </listing>
	 * 
	 * @Example	Example using the Flex 4 framework.
	 * 
	 * <listing version="3.0">
	 * 		var framerateManager:FrameRateOptimizer = new FrameRateOptimizer( FlexGlobals.topLevelApplication, true );
	 * </listing>
	 * 
	 * @Example	AIR example:
	 * 
	 * <listing version="3.0">
	 * 		var framerateManager:FrameRateOptimizer = new FrameRateOptimizer( this, true, true );
	 * </listing>
	 * 
	 * @author Elad Elrom
	 * 
	 */	
	public class FrameRateControl
	{
		/**
		 * Holds the main container 
		 */		
		private var main:*;
		
		/**
		 * Weather this is an AIR project or not 
		 */		
		private var isAIR:Boolean;
		
		/**
		 * Holds the sleep mode callback function
		 */		
		public var sleepModeCallback:Function;
		
		/**
		 * Holds the active mode callback function
		 */		
		public var activeModeCallback:Function; 
		
		/**
		 * Holds the value of the sleep mode frame rate
		 * this value is not recommended to be less than 3 fps
		 */		
		public static var SLEEP_MODE_FRAME_RATE:int;
		
		/**
		 * Holds the value for the active mode frame rate
		 */		
		public static var ACTIVE_MODE_FRAME_RATE:int;
		
		/**
		 * Holds the framerate value when there is animation 
		 */		
		public static var ANIMATION_FRAME_RATE:int;
		
		/**
		 * Holds weather the API is in debug mode and should show messages
		 */		
		private var isDebugMode:Boolean;
		
		/**
		 * Holds weather the app is in sleep mode or not
		 */		
		private var _isSleepMode:Boolean = false;
		public function get isSleepMode():Boolean
		{
			return _isSleepMode;
		}
		public function set isSleepMode(value:Boolean):void
		{
			_isSleepMode = value;
		}
		
		/**
		 * Holds a <code>Dictionary</code> of the animation's mapping
		 */		
		private var animationsNamesMap:Dictionary;		

		/**
		 * Default constructor allow passing the configuration params that will be used in the API. 
		 * 
		 * @param main	swf container
		 * @param isDebugMode	weather the app is in debug mode or not
		 * @param sleepFramerate	the fps for sleep mode
		 * @param activeFramerate	the fps for active mode
		 * @param sleepModeCallback	method that will be called once the user is going into sleep mode
		 * @param activeModeCallback	method that will be called once the user is active again
		 * 
		 */		
		public function FrameRateControl( main:*, isDebugMode:Boolean = false, 
											isAIR:Boolean = false, 
											sleepFramerate:int = 4, 
											activeFramerate:int = 25,
											animationFramerate:int = 50,
											sleepModeCallback:Function = null, 
											activeModeCallback:Function = null )
		{
			animationsNamesMap =  new Dictionary(true);
			
			this.main = main;
			this.isAIR = isAIR;
			
			SLEEP_MODE_FRAME_RATE = sleepFramerate;
			ACTIVE_MODE_FRAME_RATE = activeFramerate;
			ANIMATION_FRAME_RATE = animationFramerate;
			
			this.sleepModeCallback = sleepModeCallback;
			this.activeModeCallback = activeModeCallback;
			
			this.isDebugMode = isDebugMode;
			
			if ( isAIR )
			{
				main.addEventListener( Event.DEACTIVATE, sleepModeHandler, false, 0, true );
				main.addEventListener( Event.ACTIVATE, activeModeHandler, false, 0, true );
			}
			else
			{
				main.addEventListener( MouseEvent.MOUSE_OUT, sleepModeHandler, false, 0, true );
			}
		}
		
		/**
		 * Method to set the frame rate
		 * 
		 * @param framerate
		 * 
		 */		
		public function setFrameRate(framerate:int):void
		{
			main.stage.frameRate = framerate;
			
			if ( isDebugMode )
				trace("info :: new framerate was set: " + framerate );
		}
		
		/**
		 * handles out of screen mouse event
		 * 
		 * @param event
		 * 
		 */		
		private function sleepModeHandler(event:*):void
		{
			if ( (event as Object).hasOwnProperty("relatedObject") 
			 && event.relatedObject != null)
				return;
			
			if ( isAIR )
			{
				main.removeEventListener( Event.DEACTIVATE, sleepModeHandler );
				main.addEventListener( Event.ACTIVATE, activeModeHandler, false, 0, true );
			}
			else
			{
				main.removeEventListener( MouseEvent.MOUSE_OUT, sleepModeHandler );
				main.addEventListener( MouseEvent.MOUSE_MOVE, activeModeHandler, false, 0, true );
			}

			isSleepMode = true;
			setFrameRate( SLEEP_MODE_FRAME_RATE );
			
			if ( sleepModeCallback != null )
				sleepModeCallback();
		}
		
		/**
		 * handles mouse move event
		 * 
		 * @param event
		 * 
		 */		
		private function activeModeHandler(event:*):void
		{
			if ( isAIR )
			{
				main.addEventListener( Event.DEACTIVATE, sleepModeHandler );
				main.removeEventListener( Event.ACTIVATE, activeModeHandler );
			}
			else
			{
				main.addEventListener( MouseEvent.MOUSE_OUT, sleepModeHandler );
				main.removeEventListener( MouseEvent.MOUSE_MOVE, activeModeHandler );
			}
			
			isSleepMode = false;
			setFrameRate( ACTIVE_MODE_FRAME_RATE );
			
			if ( activeModeCallback != null )
				activeModeCallback();			
		}
		
		/**
		 * Move fps to animation mode with higher fps
		 *  
		 * @param animationNameKey	register the animation key so it will be possible to keep track of animations
		 * 
		 */		
		public function animate( animationNameKey:String ):void
		{
			animationsNamesMap[animationNameKey] = animationNameKey;
			
			setFrameRate( ANIMATION_FRAME_RATE );
		}
		
		/**
		 * Method to clean an animation 
		 *  
		 * @param animationNameKey
		 * 
		 */		
		public function clearAnimation( animationNameKey:String ):void
		{
			delete animationsNamesMap[animationNameKey];
			
			for (var key:* in animationsNamesMap)
			{
				return;
			}
			
			setFrameRate( ACTIVE_MODE_FRAME_RATE );
		}
		
		/**
		 * Method to remove all animations names from the map
		 *  
		 * @param useWeakReference
		 * 
		 */		
		public function clearAllAnimationKeys( useWeakReference:Boolean = true ):void
		{
			animationsNamesMap = new Dictionary( useWeakReference );
		}
		
		/**
		 * Method to show the current frameRate
		 * 
		 * @return 
		 * 
		 */		
		public function get frameRate():int
		{
			return main.stage.frameRate;
		}
	}
}