package com.elad.youtube.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class VideoListRetrievedEvent extends Event 
	{
	    /**
	     *  Holds the event string name
	     */		
	    public static var LIST_RETRIEVED:String = "ListRetrieved";
		
		/**
		 * Holds the video list collection from YouTube 
		 */			
		public var videoList:ArrayCollection;
		
		/**
		 * Default constructor
		 *  
		 * @param type	event name
		 * @param videoList	video list collection
		 * 
		 */			
		public function VideoListRetrievedEvent(type:String, videoList:ArrayCollection)
		{
			super(type);
			this.videoList = videoList;
		}
	}
}