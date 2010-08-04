package ca.newcommerce.googlecontacts 
{
	import ca.newcommerce.googlecontacts.events.GContactsEvent;
	import ca.newcommerce.googlecontacts.webservice.GContactsClient;
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Martin Legris ( http://blog.martinlegris.com )
	*/
	public class Test extends MovieClip
	{
		protected var _username:String = "username";
		protected var _password:String = "password";
		protected var _ws:GContactsClient;
		
		public function Test() 
		{
			_ws = GContactsClient.getInstance();
			_ws.login(_username, _password);
			_ws.addEventListener(GContactsEvent.LOGIN_SUCCESS, doLoggedIn);
		}
		
		public function doLoggedIn(evt:GContactsEvent):void
		{
			_ws.getContacts();
		}
	}
}