/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import ca.newcommerce.youtube.feeds.CommentFeed;
	import flash.events.Event;

	public class CommentFeedEvent extends Event
	{
		public static const COMMENT_DATA_RECEIVED:String = "comments_data_received";
		
		protected var _requestId:Number;		
		protected var _feed:CommentFeed;
		
		public function CommentFeedEvent(type:String, requestId:Number, feed:CommentFeed)
		{
			super(type);
			_requestId = requestId;
			_feed = feed;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public function get feed():CommentFeed
		{
			return _feed;
		}
	}
}