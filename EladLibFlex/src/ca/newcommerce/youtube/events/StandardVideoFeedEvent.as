/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import ca.newcommerce.youtube.feeds.VideoFeed;
	import flash.events.Event;

	public class StandardVideoFeedEvent extends Event
	{
		public static const STANDARD_VIDEO_DATA_RECEIVED:String = "standard_video_data_received";
		
		protected var _requestId:Number;
		protected var _feedType:String;
		protected var _feed:VideoFeed;
		
		public function StandardVideoFeedEvent(type:String, requestId:Number, feedType:String, feed:VideoFeed)
		{
			super(type);
			_feedType = feedType;
			_feed = feed;
			_requestId = requestId;
		}
		
		public function get feed():VideoFeed
		{
			return _feed;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public function get feedType():String
		{
			return _feedType;
		}
	}
}