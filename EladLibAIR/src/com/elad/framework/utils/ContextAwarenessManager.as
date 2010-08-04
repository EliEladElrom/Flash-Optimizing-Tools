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
	import air.net.*;
	
	import com.elad.framework.vo.ContextVO;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.StatusEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	import mx.core.Application;
	import mx.core.FlexGlobals;

	/**
	 * Context Awareness Manager is the platform to gather and track information
	 * regarding the system physical information as well as track changes in the 
	 * system.
	 *  
	 * The Context Awareness manager than can translate the information dispatch events
	 * and allow our application to react accordingly.
	 * 
	 * @author Elad Elrom
	 * 
	 */
	public class ContextAwarenessManager extends EventDispatcher implements IContextAwarenessManager 
	{
		//  VO holds all the information
		public var contextVO:ContextVO;
		
		// Singleton instance.
		protected static var instance:ContextAwarenessManager;
		
		protected var nativeApp:NativeApplication;
		protected var monitor:URLMonitor;
		protected var socketMonitor:SocketMonitor;
		
		// events strings
		public static const USER_IDLE:String = "userIdle";
		public static const USER_PRESENT:String = "userPresent";
		public static const NETWORK_CHANGE:String = "networkChange";
		public static const HTTP_CONNECTIVITY_TRUE:String = "HTTPConnectivityTrue";
		public static const HTTP_CONNECTIVITY_FALSE:String = "HTTPConnectivityFalse";
		public static const SOCKET_CONNECTIVITY_TRUE:String = "socketConnectivityTrue";
		public static const SOCKET_CONNECTIVITY_FALSE:String = "socketConnectivityFalse";
		public static const NATIVE_WINDOW_MOVED:String  = "nativeWindowMoved";
		
		// settings properties
		public var siteToTrack:String;
		public var idleThresholdTime:int;
		public var portToCheck:int;
		public var siteSocketMonitor:String;

		/**
		 * Method needs to enforce that class is only created once
		 *  
		 * @param enforcer
		 * 
		 */
		public function ContextAwarenessManager(enforcer:AccessRestriction) 
		{
			if (enforcer == null)
				throw new Error("Error enforcer input param is undefined" );
				
			initializeContextAwareness();	
		}
		
		/**
		 * Default constructor
		 * 
		 */				
		public function initializeContextAwareness():void
		{
			siteToTrack = "http://www.google.com";
			siteSocketMonitor = "www.adobe.com";
			idleThresholdTime = 5;
			portToCheck = 6667;
			
			contextVO = new ContextVO();
			nativeApp = NativeApplication.nativeApplication;			
		}
		
		/**
		 * Setting properties and start tracking changes 
		 * 
		 */		
		public function start():void
		{
			detectUserPresence();
			detectNetworkChanges();
			detectHTTPConnectivity();
			detectSocketConnectivity();
			setRuntimeInformation();
			setSystemSupportCapability();
			detectLocalDrivers();
			detectWindowedApplicationMovment();		
		}

		/**
		 * Stopping tracking events
		 * 
		 */			
		public function stop():void
		{
			nativeApp.removeEventListener(Event.USER_IDLE, onUserIdleHandler);
			nativeApp.removeEventListener(Event.USER_PRESENT, onUserPresentHandler);
			nativeApp.removeEventListener(Event.NETWORK_CHANGE, onNetworkStatusChange);
			monitor.removeEventListener(StatusEvent.STATUS, onHTTPConnectivityChange); 
			socketMonitor.removeEventListener(StatusEvent.STATUS, onSocketStatusChange); 
			
			monitor.stop();
			socketMonitor.stop();
		}
		
		/**
		 * AIR application can detect when a user is actively using the device. 
		 * There are two states: userPresent and idleThreshold.   
		 * Once user used their keyboard, mouse or touch-screen AIR NativeApplication 
		 * API will dispatch a userPresent event.  In the event the user is not using the input devices 
		 * an idleThreshold will be dispatch and we can find out how long since the user used 
		 * his input devices using timeSinceLastUserInput property. 
		 * 
		 * @see NativeApplication.nativeApplication.idleThreshold
		 * @see flash.events.Event
		 * 
		 */		
		private function detectUserPresence():void
		{
			nativeApp.idleThreshold = idleThresholdTime;
			nativeApp.addEventListener(Event.USER_IDLE, onUserIdleHandler);
			nativeApp.addEventListener(Event.USER_PRESENT, onUserPresentHandler);		
		}

		/**
		 * AIR application can run in environments with uncertain and changing network connectivity. 
		 * To help an application manage connections to online resources, 
		 * Adobe AIR sends a network change event whenever a network connection becomes available 
		 * or unavailable. The application’s NativeApplication object dispatches the network change event. 
		 * 
		 * @see flash.events.Event
		 * 
		 */			
		private function detectNetworkChanges():void
		{
			nativeApp.addEventListener(Event.NETWORK_CHANGE, onNetworkStatusChange);
		}

		/**
		 * The URLMonitor class determines if HTTP requests can be made to a specified address at port 80
		 *  (the typical port for HTTP communication). The following code uses an instance of the URLMonitor 
		 * class to detect connectivity changes.
		 * 
		 * @see flash.net.URLRequest
		 * @see air.net.URLMonitor
		 * 
		 */
		private function detectHTTPConnectivity():void
		{
			monitor = new URLMonitor(new URLRequest(siteToTrack)); 
			monitor.addEventListener(StatusEvent.STATUS, onHTTPConnectivityChange); 
			monitor.start(); 
		}
		
		/**
		 * Applications can also use socket connections for push-model connectivity. 
		 * Firewalls and network routers typically restrict network communication on 
		 * unauthorized ports for security reasons. 
		 * For this reason, developers must consider that users may not have the 
		 * capability of making socket connections.
		 * 
		 * @see air.net.SocketMonitor
		 * 
		 */		
		private function detectSocketConnectivity():void
		{
			socketMonitor = new SocketMonitor(siteSocketMonitor,portToCheck); 
			socketMonitor.addEventListener(StatusEvent.STATUS, onSocketStatusChange); 
			socketMonitor.start(); 
		} 
		
		/**
		 * the version of the runtime in which the application is running (a string, such as "1.0.5"). 
		 * The NativeApplication object also has a runtimePatchLevel property, which is the patch level 
		 * of the runtime (a number, such as 2960).
		 * 
		 * @see NativeApplication.nativeApplication.runtimeVersion
		 * @see NativeApplication.nativeApplication.runtimePatchLevel
		 * 
		 */		
		private function setRuntimeInformation():void
		{
			contextVO.getRuntimeVersion = nativeApp.runtimeVersion;
			contextVO.getRuntimePatchLevel = nativeApp.runtimePatchLevel;
		}
		
		/**
		 * Setting additional Capabilities 
		 * 
		 * @see NativeApplication.supportsDockIcon
		 * @see NativeApplication.supportsMenu
		 * @see NativeApplication.supportsSystemTrayIcon
		 * @see NativeWindow.supportsMenu
		 * @see NativeWindow.supportsNotification
		 * @see NativeWindow.supportsTransparency
		 * @see NativeWindow.systemMaxSize
		 * @see NativeWindow.systemMinSize
		 * 
		 */		
		private function setSystemSupportCapability():void
		{
			contextVO.supportsDockIcon = NativeApplication.supportsDockIcon;
			contextVO.supportsMenu = NativeApplication.supportsMenu;
			contextVO.supportsSystemTrayIcon = NativeApplication.supportsSystemTrayIcon;
			contextVO.supportsMenu = NativeWindow.supportsMenu;
			contextVO.supportsNotification = NativeWindow.supportsNotification;
			contextVO.supportsTransparency = NativeWindow.supportsTransparency;
			contextVO.systemMaxSize = NativeWindow.systemMaxSize;
			contextVO.systemMinSize = NativeWindow.systemMinSize;
		}
		
		/**
		 * Adobe AIR File function getDirectoryListing for Mac or getRootDirectories for PC 
		 * allow detecting local drives.
		 * 
		 * @see flash.filesystem.File.getDirectoryListing
		 * @see flash.filesystem.File.getRootDirectories
		 * 
		 */		
		private function detectLocalDrivers():void
		{
		     contextVO.currentAvaliableDrives = (contextVO.osName=="mac") ? 
		     	new File('/Volumes/').getDirectoryListing() : File.getRootDirectories() ;
		}
		
		/**
		 * Allow access to manual refresh of local drives 
		 * 
		 */		
		public function refreshLocalDrives():void
		{
			detectLocalDrivers();
		}
		
		/**
		 * Detecting WindowedApplication movement
		 * 
		 * information placed in <code>contextVO</code>, under the properties;
		 * <ul>
		 * 		<ui><code>windowPositionAfterBounds</code></ui>
		 * 		<ui><code>windowPositionBeforeBounds</code></ui>
		 * </ul>
		 * 
		 * @see flash.events.NativeWindowBoundsEvent
		 * 
		 */		
		private function detectWindowedApplicationMovment():void
		{
			FlexGlobals.topLevelApplication.addEventListener(NativeWindowBoundsEvent.MOVING, onWindowedApplicationMovment);
		}
		
		/* ----------------------------------------------
		  |             EVENT HANDLERS                  |
		  ----------------------------------------------
		*/		
		
		private function onUserIdleHandler(evt:Event):void
		{
			var lastUserInput:Number = NativeApplication.nativeApplication.timeSinceLastUserInput;
			var event:Event = new Event(USER_IDLE, true);
			
			contextVO.isUserPresent = false;
			contextVO.lastUserInput = lastUserInput;
			
			this.dispatchEvent(event);
		}
		
		private function onUserPresentHandler(evt:Event):void
		{
			var event:Event = new Event(USER_PRESENT, true);
			contextVO.isUserPresent = true;
			this.dispatchEvent(event);			
		}
		
		private function onNetworkStatusChange(evt:Event):void
		{
			var event:Event = new Event(NETWORK_CHANGE, true);
			contextVO.isNetworkChanged = true;
			this.dispatchEvent(event);	
		}
		
		private function onHTTPConnectivityChange(evt:StatusEvent):void 
		{ 
		    var event:Event;
		    contextVO.isHTTPAvaliable = monitor.available;
		    event = (monitor.available) ? new Event(HTTP_CONNECTIVITY_TRUE, true) : 
		    	new Event(HTTP_CONNECTIVITY_FALSE, true);
			
			this.dispatchEvent(event);	
		}
		
		private function onSocketStatusChange(evt:StatusEvent):void
		{
			var event:Event;
			contextVO.isSocketMonitorAvailable = socketMonitor.available;
			
			event = (socketMonitor.available) ? new Event(SOCKET_CONNECTIVITY_TRUE, true) : 
		    	new Event(SOCKET_CONNECTIVITY_FALSE, true);
			
			this.dispatchEvent(event);				
		}
		
		private function onWindowedApplicationMovment(evt:*):void
		{
			var event:Event = new Event(NATIVE_WINDOW_MOVED, true);
			
			contextVO.windowPositionAfterBounds = evt.afterBounds;
			contextVO.windowPositionBeforeBounds = evt.beforeBounds;
			
			this.dispatchEvent(event);
		}
		        
		/**
		 * Method function to retrieve instance of the class
		 *  
		 * @return The same instance of the class
		 * 
		 */
		public static function getInstance():ContextAwarenessManager
		{
			if( instance == null )
				instance = new  ContextAwarenessManager(new AccessRestriction());
			
			return instance;
		}
	}
}

class AccessRestriction {}