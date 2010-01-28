package com.elad.youtube.events
{
	import flash.events.Event;
	
	public class FlvExtractedEvent extends Event 
	{
	    /**
	     *  Holds the event string name
	     */			
	    public static var FLV_URL_EXTRACTED:String = "flvURLExtracted";
		
		/**
		 * Holds the flv video URL from YouTube 
		 */		
		public var flvURL:String;
		
		/**
		 * Default constructor
		 *  
		 * @param type
		 * @param flvURL
		 * 
		 */		
		public function FlvExtractedEvent(type:String, flvURL:String)
		{
			super(type);
			this.flvURL = flvURL;
		}
	}
}