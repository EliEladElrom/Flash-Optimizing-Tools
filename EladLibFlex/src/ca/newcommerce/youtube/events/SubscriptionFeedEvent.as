/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import ca.newcommerce.youtube.feeds.SubscriptionFeed;
	import flash.events.Event;

	public class SubscriptionFeedEvent extends Event
	{
		public static const SUBSCRIPTION_DATA_RECEIVED:String = "subscription_data_received";
		
		protected var _feed:SubscriptionFeed;
		protected var _requestId:Number;
		
		public function SubscriptionFeedEvent(type:String, requestId:Number, feed:SubscriptionFeed)
		{
			super(type);
			_requestId = requestId;
			_feed = feed;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public function get feed():SubscriptionFeed
		{
			return _feed;
		}
	}
}