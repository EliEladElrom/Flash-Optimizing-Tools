package com.elad.youtube.utills
{
	import com.elad.youtube.events.FlvExtractedEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class ExtractFlvFromYouTube extends EventDispatcher
	{
		/**
		 *  Holds an instance of the <code>HTTPService</code> class
		 */		
		private var service:HTTPService;
		
		/**
		 * Default constructor
		 * 
		 * @param target
		 * 
		 */		
		public function ExtractFlvFromYouTube(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * Method to get the FLV video URL based on a given id
		 *  
		 * @param value each YouTube video has a video ID
		 * 
		 */		
		public function getFLVURL(value:String):void
		{
			service = new HTTPService();
			service.method = "GET";
			service.url = "http://elromdesign.com/temp1/getVideoId.php?url=http://www.youtube.com/watch?v="+value;
			service.resultFormat="e4x";
			service.showBusyCursor=true;
			service.addEventListener(ResultEvent.RESULT, resultHandler);
			service.addEventListener(FaultEvent.FAULT, faultHandler);
			service.send();				
		}
		
		/**
		 * Method to create the FLV url based on results.
		 *  
		 * @param event
		 * 
		 */		
		private function resultHandler(event:ResultEvent):void
		{
			var id:String = event.result.id;
			var t:String = event.result.t;
			var flvURL:String = "http://www.youtube.com/get_video?video_id="+id+"&t="+t;
			
			removeEventsListeners();
			dispatchFlvExtractedEvent(flvURL);
		}
		
		/**
		 * Fault Handler
		 *  
		 * @param event
		 * 
		 */		
		private function faultHandler(event:FaultEvent):void
		{
			Alert.show("Couldn't connect to youtube!");
			removeEventsListeners();	
		}
		
		/**
		 *  Method to clean up the event listners. 
		 * 
		 */		
		private function removeEventsListeners():void
		{
			service.removeEventListener(ResultEvent.RESULT, resultHandler);
			service.removeEventListener(FaultEvent.FAULT, faultHandler);			
		}
		
		/**
		 * Method to dispatch an event to notify the view that the URL was retrieved.
		 *  
		 * @param flvURL
		 * 
		 */				
		private function dispatchFlvExtractedEvent(flvURL:String):void
		{
			this.dispatchEvent(new FlvExtractedEvent(FlvExtractedEvent.FLV_URL_EXTRACTED, flvURL));			
		}	
	}
}