/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import ca.newcommerce.youtube.feeds.VideoFeed;
	import flash.events.Event;

	public class ResponseFeedEvent extends Event
	{
		public static const RESPONSES_DATA_RECEIVED:String = "responses_data_received";
		
		protected var _requestId:Number;
		protected var _videoId:String;
		protected var _feed:VideoFeed;

		public function ResponseFeedEvent(type:String, requestId:Number, videoId:String, feed:VideoFeed)
		{
			super(type);
			_requestId = requestId;
			_videoId = videoId;
			_feed = feed;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public function get feed():VideoFeed
		{
			return _feed;
		}
		
		public function get videoId():String
		{
			return _videoId;
		}
	}
}