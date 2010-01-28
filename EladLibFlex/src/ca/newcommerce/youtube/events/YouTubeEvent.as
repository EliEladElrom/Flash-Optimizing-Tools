/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import flash.events.Event;

	public class YouTubeEvent extends Event
	{
		public static const RAW_URL_DATA_RECEIVED:String = "raw_url_data_received";
		public static const LOGIN_SUCCESSFULL:String = "login_successfull";
		public static const RATING_SUCCESSFULL:String = "rating_successfull";
		public static const LOGIN_CAPTCHA_REQUIRED:String = "login_captcha_required";
		public static const LOGIN_FAILED:String = "login_failed";
		public static const FAVORITE_SUCCESSFUL:String = "favorite_successful";
		public static const FAVORITE_FAILED:String = "favorite_failed";
		public static const UNFAVORITE_SUCCESSFUL:String = "unfavorite_successful";
		public static const UNFAVORITE_FAILED:String = "unfavorite_failed";
		public static const SUBSCRIPTION_FAILED:String = "subscription_failed";
		public static const CHANNEL_SUBSCRIPTION_SUCCESSFUL:String = "channel_subscription_successful";
		public static const FAVORITES_SUBSCRIPTION_SUCCESSFUL:String = "favorites_subscription_successful";
		public static const SEARCH_SUBSCRIPTION_SUCCESSFUL:String = "search_subscription_successful";
		public static const SUBSCRIPTION_DELETED:String = "subscription_deleted";
		public static const RATING_SUCCESSFUL:String = "rating_successful";
		
		protected var _requestId:Number = -1;
		protected var _requestWrapper:Object;
		
		public function YouTubeEvent(type:String, requestWrapper:Object)
		{
			super(type);
			_requestId = requestWrapper.id;
			_requestWrapper = requestWrapper;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public function get requestWrapper():Object
		{
			return _requestWrapper;
		}
	}
}