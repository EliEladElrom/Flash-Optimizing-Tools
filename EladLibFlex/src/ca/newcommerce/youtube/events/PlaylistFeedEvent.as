/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import ca.newcommerce.youtube.feeds.PlaylistFeed;
	import flash.events.Event;

	public class PlaylistFeedEvent extends Event
	{
		public static const PLAYLIST_DATA_RECEIVED:String = "playlist_data_received";
		
		protected var _username:String;
		protected var _requestId:Number;
		protected var _feed:PlaylistFeed;
		
		public function PlaylistFeedEvent(type:String, requestId:Number, username:String, feed:PlaylistFeed)
		{
			super(type);
			_feed = feed;
			_requestId = requestId;
			_username = username;
		}
		
		public function get feed():PlaylistFeed
		{
			return _feed;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public function get username():String
		{
			return _username;
		}
	}
}