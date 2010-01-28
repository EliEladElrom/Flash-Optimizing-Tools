/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */
package com.elad.framework.vo
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	[Bindable]
	public class ContextVO
	{
		public function ContextVO()
		{
			avHardwareDisable = Capabilities.avHardwareDisable;
			hasAccessibility = Capabilities.hasAccessibility;
			hasAudio = Capabilities.hasAudio;
			hasAudioEncoder  = Capabilities.hasAudioEncoder;
			hasEmbeddedVideo = Capabilities.hasEmbeddedVideo;
			hasMP3 = Capabilities.hasMP3;
			hasPrinting = Capabilities.hasPrinting;
			hasScreenBroadcast = Capabilities.hasScreenBroadcast;
			hasScreenPlayback = Capabilities.hasScreenPlayback;
			hasStreamingAudio = Capabilities.hasStreamingAudio;
			hasVideoEncoder = Capabilities.hasVideoEncoder;
			isDebugger = Capabilities.isDebugger;
			language = Capabilities.language;
			localFileReadDisable = Capabilities.localFileReadDisable;
			manufacturer = Capabilities.manufacturer;
			os = Capabilities.os;
			osName = Capabilities.os.substr(0, 3).toLowerCase();
			pixelAspectRatio = Capabilities.pixelAspectRatio;
			playerType = Capabilities.playerType;
			screenColor = Capabilities.screenColor;
			screenDPI = Capabilities.screenDPI;
			screenResolutionX = Capabilities.screenResolutionX;
			screenResolutionY = Capabilities.screenResolutionY;
			serverString = Capabilities.serverString;
			version = Capabilities.version;		
		}
		
		// track changes
		public var isHTTPAvaliable:Boolean = false;
		public var isNetworkChanged:Boolean = false;
		public var isUserPresent:Boolean = true;
		public var lastUserInput:Number = 0;
		public var isSocketMonitorAvailable:Boolean = false;
		public var windowPositionAfterBounds:Rectangle;
		public var windowPositionBeforeBounds:Rectangle;		
		
		// System Capabilities
		public var getRuntimeVersion:String;
		public var getRuntimePatchLevel:uint;
		public var avHardwareDisable:Boolean;
		public var hasAccessibility:Boolean;
		public var hasAudio:Boolean;
		public var hasAudioEncoder:Boolean;
		public var hasEmbeddedVideo:Boolean;
		public var hasMP3:Boolean;
		public var hasPrinting:Boolean;
		public var hasScreenBroadcast:Boolean;
		public var hasScreenPlayback:Boolean;
		public var hasStreamingAudio:Boolean;
		public var hasVideoEncoder:Boolean;
		public var isDebugger:Boolean;
		public var language:String;
		public var localFileReadDisable:Boolean;
		public var manufacturer:String;
		public var os:String;
		public var osName:String;
		public var pixelAspectRatio:Number;
		public var playerType:String;
		public var screenColor:String;
		public var screenDPI:Number;
		public var screenResolutionX:Number;
		public var screenResolutionY:Number;
		public var serverString:String;
		public var version:String;
		
		// System support
		public var supportsDockIcon:Boolean;
		public var supportsMenu:Boolean;
		public var supportsSystemTrayIcon:Boolean;
		public var supportsNotification:Boolean;
		public var supportsTransparency:Boolean;
		public var systemMaxSize:Point;
		public var systemMinSize:Point;
		
		// others
		public var currentAvaliableDrives:Array;
	}
}