/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import flash.events.Event;
	import ca.newcommerce.youtube.feeds.ContactFeed;

	public class ContactFeedEvent extends Event
	{
		public static const USER_DATA_RECEIVED:String = "user_data_received";
		public static const USER_FEED_READY:String = "user_feed_ready";
		
		protected var _feed:ContactFeed;
		protected var _requestId:Number;
		
		public function ContactFeedEvent(type:String, requestId:Number, feed:ContactFeed)
		{
			super(type);
			_feed = feed;
			_requestId = requestId;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public function get feed():ContactFeed
		{
			return _feed;
		}
	}
}
