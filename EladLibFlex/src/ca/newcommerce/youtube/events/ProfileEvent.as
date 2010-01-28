/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import ca.newcommerce.youtube.data.ProfileData;
	import flash.events.Event;

	public class ProfileEvent extends Event
	{
		public static const PROFILE_DATA_RECEIVED:String = "profile_data_received";
		
		protected var _profile:ProfileData;
		protected var _requestId:Number;
		
		public function ProfileEvent(type:String, requestId:Number, profile:ProfileData)
		{
			super(type);
			_requestId = requestId;
			_profile = profile;
		}
		
		public function get profile():ProfileData
		{
			return _profile;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public override function toString():String
		{
			return "ca.newcommerce.youtube.events.ProfileEvent";
		}
	}
}
