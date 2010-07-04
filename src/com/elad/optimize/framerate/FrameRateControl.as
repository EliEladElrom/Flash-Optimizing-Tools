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
	 * <p>One of the most effective and easy ways to optimize your Flash application is controlling the player's 
	 * frame rate per second (fps)</p>
	 * 
	 * <p>Consider the following.  A user has a browser open with 5-10 tabs and each tab has about 2-3 swfs.  
	 * Ideally, when you don't use a swf it will reduce the memory footprint.  How about few AIR apps and web 
	 * browsers all running at the same time?</p>
	 * 
	 * The idea is to have one utility class to help you control and adjust your fps and take into account 
	 * the following:
	 * 
	 * <ul>
	 * 		<li>Reducing fps when your app is inactive</li>
	 * 		<li>Increase the fps once the app is active again</li>
	 * 		<li>Increase fps while animation is playing to create a more smooth experience and keeping a stack of all the animations being played to know when we can drop the fps.</li>
	 * 		<li>Provide a cross platform API  (Pure AS3, Flex, AIR)</li>
 	 * </ul>
 	 * 
	 * For more information visit: http://elromdesign.com/blog
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
		 * whether this is an AIR project or not 
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
		 * Holds whether the API is in debug mode and should show messages
		 */		
		private var isDebugMode:Boolean;
		
		/**
		 * Holds whether the app is in sleep mode or not
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
		 * <p>Default constructor allows passing the configuration params that will be used in the API.  For instance, 
		 * setting whether it is debug mode and we will have trace statements indicating the fps, 
		 * flag whether it's an AIR app, the active, animation and sleep fps and call back method.</p> 
		 * 
		 * <p>Notice that the main application is being passed instead since Flex, AIR and pure AS 3 holds 
		 * the main application differently.  
		 * 
		 * <ul>
		 * 		<li>Flex 4 holds the main app here: <code>FlexGlobals.topLevelApplication</code></li>
		 * 		<li>Pure AS 3 holds the main app as the Sprite so it's <code>this</code></li>
		 * 		<li>AIR holds the main app here: <code>this</code> when called from the main window.</li>
		 * </ul>
		 * 
		 * </p>
		 * 
		 * @param main	swf container
		 * @param isDebugMode	whether the app is in debug mode or not
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
		 * <p>The setFrameRate method sets the frame rate on the main window.  
		 * In case the user is in debug mode we want to displace trace statement in 
		 * the console to show the change.</p>
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
		 * Once the app goes into sleep mode the <code>sleepModeHandler</code> method is called and allows us to 
		 * handle a few cases.  In case this is a Flex/Pure AS app, the sleep mode gets dispatched 
		 * from mouse event so we want to check whether there is a related object assign.  
		 * In case there isn't any related object assign, we know that the user has left the stage.
		 * 
		 * We then want to set an event to listen to when the user is back.  
		 * AIR needs the <code>ACTIVATE</code> event constant name, while Flex/AS3 needs the <code>MOUSE_MOVE</code>
		 * constant. 
		 * 
		 * @param event wild card since the event may be <code>MouseEvent</code> or <code>Event</code>
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
		 * <p>Once the app is in sleep mode it will wait for the event that indicates that the app is active 
		 * again and will call <code>activeModeHandler</code>.  In case this is an AIR app it will wait for the app 
		 * to go into sleep mode again using Event.DEACTIVATE constant otherwise we will be using 
		 * the <code>MouseEvent.MOUSE_OUT</code> event constant.  We are also going to dispatch the call back 
		 * function in case it was set.</p>
		 * 
		 * @param event	wild card since the event may be <code>MouseEvent</code> or <code>Event</code>
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
		 * <p>Once we are running an animation we may want to run it in a higher fps for a better user experience.  
		 * The API by default set the fps for animation at 50 fps, but you can specify that when you set the constructer.  
		 * Notice that we are using a dictionary to hold the key names for easy access.</p>
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
		 * <p>Method to clean an animation.  Once an animation is complete, we will delete the key from the 
		 * dictionary and in case there isn't any keys (meaning no more animation to consider) 
		 * we will set the stage frame rate to active mode. </p>
		 *  
		 * @param animationNameKey
		 * 
		 */		
		public function clearAnimation( animationNameKey:String ):void
		{
			delete animationsNamesMap[animationNameKey];
			
			for (var key:* in animationsNamesMap)
				return;
			
			setFrameRate( ACTIVE_MODE_FRAME_RATE );
		}
		
		/**
		 * <p><code>clearAllAnimationKeys</code> method is used to remove all animation names from the dictionary. 
		 * So in case we want to start over or ensure the collection 
		 * of names is empty we can use this method.</p>
		 *  
		 * @param useWeakReference
		 * 
		 */		
		public function clearAllAnimationKeys( useWeakReference:Boolean = true ):void
		{
			animationsNamesMap = new Dictionary( useWeakReference );
		}
		
		/**
		 * The frameRate getter allows us to get the current fps in our application.
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