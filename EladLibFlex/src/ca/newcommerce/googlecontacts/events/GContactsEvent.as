package ca.newcommerce.googlecontacts.events 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author Martin Legris ( http://blog.martinlegris.com )
	*/
	public class GContactsEvent extends Event
	{
		public static const LOGIN_SUCCESS:String = "login_success";
		public static const LOGIN_FAILED:String = "login_failed";
		
		protected var _requestId:Number = -1;
		protected var _requestWrapper:Object;
		
		public function GContactsEvent(type:String, requestWrapper:Object)
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