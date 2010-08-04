/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import flash.events.Event;
	import ca.newcommerce.youtube.feeds.VideoFeed;

	public class VideoFeedEvent extends Event
	{
		public static const VIDEO_DATA_RECEIVED:String = "video_data_received";
		public static const VIDEO_PLAYLIST_DATA_RECEIVED:String = "video_playlist_data_received";
		public static const VIDEO_RESPONSE_DATA_RECEIVED:String = "video_response_data_received";
		public static const RELATED_VIDEOS_DATA_RECEIVED:String = "related_videos_data_received";
		public static const USER_FAVORITES_DATA_RECEIVED:String = "user_favorites_data_received";
		
		public static const VIDEO_FEED_READY:String = "video_feed_ready";
		
		protected var _feed:VideoFeed;
		protected var _requestId:Number;
		
		public function VideoFeedEvent(type:String, requestId:Number, feed:VideoFeed)
		{
			super(type);
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
		
		public override function toString():String
		{
			return "ca.newcommerce.youtube.events.VideoFeedEvent";
		}
	}
}