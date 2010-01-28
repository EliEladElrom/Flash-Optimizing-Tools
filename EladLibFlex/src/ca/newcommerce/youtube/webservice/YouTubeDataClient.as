package ca.newcommerce.youtube.webservice 
{
	import ca.newcommerce.youtube.events.SubscriptionFeedEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import ca.newcommerce.youtube.events.YouTubeEvent;
	
	/**
	* ...
	* @author Martin Legris
	*/
	
	public class YouTubeDataClient extends EventDispatcher
	{
		protected const _clientId:String = "ytapi-MartinLegris-YoutubeDiscovery-rn7ifdis-0";
		protected const _developerKey:String = "AI39si5ojvdQW_7wzbgApyTS1EMXiEfRVZtq4usxFYDFq6ZqEDiaSsPrkNLdFPwy97z9wyGtk6FPrc35H5B9LjugSQG5duueYg";
		protected const _apName:String = "youtube_discovery_test";
		protected var _auth:String = "";
		protected var _username:String = "";
		
		protected var _requestQueue:Array;
		protected var _requestId:Number = 0;
		
		protected var _conn:NetConnection;
		
		protected var _proxyUrl:String = "http://www.martinlegris.com/amf3/gateway.php";
		
		protected static var _instance:YouTubeDataClient;
		
		public static function getInstance():YouTubeDataClient
		{
			if (_instance == null)
				_instance = new YouTubeDataClient();
				
			return _instance;
		}
		
		public function get proxyUrl():String { return _proxyUrl; }
		
		public function set proxyUrl(value:String):void {
			_proxyUrl = value;
		}
		
		public function YouTubeDataClient()
		{
			_requestQueue = [];
			
			_conn = new NetConnection();
			_conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, doAsyncError);
			_conn.addEventListener(NetStatusEvent.NET_STATUS, doNetStatus);
			_conn.addEventListener(IOErrorEvent.IO_ERROR, doIOError);
			_conn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, doSecurityError);
			_conn.connect(_proxyUrl);
		}
		
		protected function getRequestById(id:Number):Object
		{
			var i:Number = 0;
			for (i = 0; i < _requestQueue.length; i++)
			{
				if (_requestQueue[i].id == id)
					return _requestQueue[i];
			}
			
			return null;
		}
		
		public function login(username:String, password:String, loginToken:String = "", captcha:String = ""):Number
		{
			var url:String =  "https://www.google.com/youtube/accounts/ClientLogin";
			var headers:Array = ["Content-Type", "application/x-www-form-urlencoded"];
			var method:String = "POST";
			var postVars:Array = ["Email=" + username,
								  "Passwd=" + password,
								  "service=youtube",
								  "source=" + _apName];
								  
			if (loginToken.length)
				postVars.push("loginToken=" + loginToken);
				
			if (captcha.length)
				postVars.push("captcha=" + captcha);
				
			var responder:Responder = new Responder(doLogin, doFault);
			var wrapper:Object = getWrapper(responder, "login");
				
			_conn.call("RESTProxy.request", responder, url, method, [], postVars, headers, wrapper.id);
			
			return wrapper.id;
		}
		
		public function rate(videoId:String, rating:Number):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/videos/" + videoId + "/ratings";
			var method:String = "POST";
			var headers:Array = getStdHeaders();
			
			var content:String = '<?xml version="1.0" encoding="UTF-8"?>';
			content = content.concat('<entry xmlns="http://www.w3.org/2005/Atom" xmlns:gd="http://schemas.google.com/g/2005">');
			content = content.concat('<gd:rating value="' + rating + '" min="1" max="5" />');
			content = content.concat('</entry>');
			
			var responder:Responder = new Responder(doRating, doFault);
			var wrapper:Object = getWrapper(responder, "rate");
			
			_conn.call("RESTProxy.request", responder, url, method, [], content, headers, wrapper.id);
			
			return wrapper.id;
		}
		
		public function favorite(videoId:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/users/default/favorites";
			var method:String = "POST";
			var headers:Array = getStdHeaders();
			
			var content:String = '<?xml version="1.0" encoding="UTF-8"?>';
			content = content.concat('<entry xmlns="http://www.w3.org/2005/Atom">');
			content = content.concat("<id>" + videoId + "</id>");
			content = content.concat('</entry>');
			
			var responder:Responder = new Responder(doFavorite, doFault);
			var wrapper:Object = getWrapper(responder, "favorite");
			
			_conn.call("RESTProxy.request", responder, url, method, [], content, headers, wrapper.id);
			
			return wrapper.id;
		}
		
		public function unfavorite(videoId:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/users/" + _username + "/favorites/" + videoId;
			var method:String = "DELETE";			
			var headers:Array = getStdHeaders();
			
			var responder:Responder = new Responder(doUnfavorite, doFault);
			var wrapper:Object = getWrapper(responder, "unfavorite");
			
			_conn.call("RESTProxy.request", responder, url, method, [], [], headers, wrapper.id);
			
			return wrapper.id;
		}
		
		public function subscribeChannel(username:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/users/" + _username + "/subscriptions";
			var method:String = "POST";
			var headers:Array = getStdHeaders();
			
			var content:String = '<?xml version="1.0" encoding="UTF-8"?>';
			content = content.concat('<entry xmlns="http://www.w3.org/2005/Atom" xmlns:yt="http://gdata.youtube.com/schemas/2007">');
			content = content.concat('<category scheme="http://gdata.youtube.com/schemas/2007/subscriptiontypes.cat" term="channel"/>');
			content = content.concat('<yt:username>' + username + '</yt:username></entry >');
			
			var responder:Responder = new Responder(doSubscribeChannel, doFault);
			var wrapper:Object = getWrapper(responder, "subscribeChannel");
			wrapper.channel = username;
			
			
			_conn.call("RESTProxy.request", responder, url, method, [], content, headers, wrapper.id);
			
			return wrapper.id;
		}
		
		public function subscribeFavorites(username:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/users/" + _username + "/subscriptions";
			var method:String = "POST";
			var headers:Array = getStdHeaders();
			
			var content:String = '<?xml version="1.0" encoding="UTF-8"?>';
			content = content.concat('<entry xmlns="http://www.w3.org/2005/Atom" xmlns:yt="http://gdata.youtube.com/schemas/2007">');
			content = content.concat('<category scheme="http://gdata.youtube.com/schemas/2007/subscriptiontypes.cat" term="favorites"/>');
			content = content.concat('<yt:username>' + username + '</yt:username></entry>');
			
			var responder:Responder = new Responder(doSubscribeFavorites, doFault);
			var wrapper:Object = getWrapper(responder, "subscribeFavorites");
			wrapper.favorites = username;
			
			_conn.call("RESTProxy.request", responder, url, method, [], content, headers, wrapper.id);
			
			return wrapper.id;
		}
		
		public function subscribeSearch(keywords:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/users/" + _username + "/subscriptions";
			var method:String = "POST";
			var headers:Array = getStdHeaders();
			
			var content:String = '<?xml version="1.0" encoding="UTF-8"?>';
			content = content.concat('<entry xmlns="http://www.w3.org/2005/Atom" xmlns:yt="http://gdata.youtube.com/schemas/2007">');
			content = content.concat('<category scheme="http://gdata.youtube.com/schemas/2007/subscriptiontypes.cat" term="query"/>');
			content = content.concat('<yt:queryString>' + keywords + '</yt:queryString></entry>');
			
			var responder:Responder = new Responder(doSubscribeSearch, doFault);
			var wrapper:Object = getWrapper(responder, "subscribeSearch");
			wrapper.search = keywords;
			
			_conn.call("RESTProxy.request", responder, url, method, [], content, headers, wrapper.id);
			
			return wrapper.id;
		}
		
		public function deleteSubscription(subscriptionId:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/users/" + _username + "/subscriptions/" + subscriptionId;
			var method:String = "DELETE";
			var headers:Array = getStdHeaders();
			
			var responder:Responder = new Responder(doDeleteSubscription, doFault);
			var wrapper:Object = getWrapper(responder, "deleteSubscription");
			wrapper.subscriptionId = subscriptionId;
			
			_conn.call("RESTProxy.request", responder, url, method, [], [], headers, wrapper.id);
			
			return wrapper.id;
		}
		
		public function addResponse(videoId:String, responseVideoId:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/videos/" + videoId + "/responses";
			var method:String = "POST";
			var headers:Array = getStdHeaders();
			
			var content:String = '<?xml version="1.0" encoding="UTF-8"?>';
			content = content.concat('<entry xmlns="http://www/w3.org/2005/Atom">');
			content = content.concat('<id>' + responseVideoId + '</id>');
			content = content.concat('</entry>');
			
			var responder:Responder = new Responder(doAddResponse, doFault);
			var wrapper:Object = getWrapper(responder, "addResponse");
			wrapper.videoId = videoId;
			wrapper.responseVideoId = responseVideoId;
			
			_conn.call("RESTProxy.request", responder, url, method, [], content, headers, wrapper.id);
			return wrapper.id;
		}
		
		public function comment(videoId:String, comment:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/videos/" + videoId + "/comments";
			var method:String = "POST";
			var headers:Array = getStdHeaders();
			
			var content:String = '<?xml version="1.0" encoding="UTF-8"?>';
			content = content.concat('<entry xmlns="http://www.w3.org/2005/Atom" xmlns:yt="http://gdata.youtube.com/schemas/2007">');
			content = content.concat('<content>' + comment + '</content>');
			content = content.concat('</entry>');
			
			var responder:Responder = new Responder(doComment, doFault);
			var wrapper:Object = getWrapper(responder, "comment");
			wrapper.videoId = videoId;
			wrapper.comment = comment;
			
			_conn.call("RESTProxy.request", responder, url, method, [], content, headers, wrapper.id);
			
			return wrapper.id;
		}
		
		public function deleteResponse(videoId:String, responseVideoId:String):Number
		{
			var url:String = "/feeds/api/videos/" + videoId + "/responses/" + responseVideoId;
			var method:String = "DELETE";
			var headers:Array = getStdHeaders();
			
			var responder:Responder = new Responder(doDeleteResponse, doFault);
			var wrapper:Object = getWrapper(responder, "deleteResponse");
			wrapper.videoId = videoId;
			wrapper.responseVideoId = responseVideoId;
			
			_conn.call("RESTProxy.request", responder, url, method, [], [], headers, wrapper.id);
			
			return wrapper.id;
		}
		
		protected function complaint(videoId:String, type:String, comment:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/videos/" + videoId + "/complaints";
			var method:String = "POST";
			var headers:Array = getStdHeaders();
			
			var content:String = '<?xml version="1.0" encoding="UTF-8"?>';
			content = content.concat('<entry xmlns="http://www.w3.org/2005/Atom" xmlns:yt="http://gdata.youtube.com/schemas/2007">');
			content = content.concat('<yt:content type="text">' + comment + '</yt:content>');
			content = content.concat('<category scheme="http://gdata.youtube.com/schemas/2007/complaint-reasons.cat" term="' + type + '"/>');
			content = content.concat('</entry>');
			
			var responder:Responder = new Responder(doComplaint, doFault);
			var wrapper:Object = getWrapper(responder, "complaint");
			wrapper.videoId = videoId;
			wrapper.type = type;
			wrapper.comment = comment;
			
			_conn.call("RESTProxy.request", responder, url, method, [], content, headers, wrapper.id);
			
			return wrapper.id;
		}
		
		protected function doComplaint(result:Object):void
		{
			trace("doComplaint");
			var requestId:Number = parseInt(result.requestId);
			var wrapper:Object = getWrapperById(requestId);
		}
		
		protected function doComment(result:Object):void
		{
			trace("doComment");
			var requestId:Number = parseInt(result.requestId);
			var wrapper:Object = getWrapperById(requestId);
		}
		
		protected function doAddResponse(result:Object):void
		{
			trace("doAddResponse");
			var requestId:Number = parseInt(result.requestId);
			var wrapper:Object = getWrapperById(requestId);
		}
		
		protected function doDeleteResponse(result:Object):void
		{
			trace("doDeleteResponse");
			var requestId:Number = parseInt(result.requestId);
			var wrapper:Object = getWrapperById(requestId);
		}
		
		protected function doDeleteSubscription(result:Object):void
		{
			trace("doDeleteSubscription");
			var requestId:Number = parseInt(result.requestId);
			var wrapper:Object = getWrapperById(requestId);
			
			dispatchEvent(new YouTubeEvent(YouTubeEvent.SUBSCRIPTION_DELETED, wrapper));
		}
		
		protected function doSubscribeSearch(result:Object):void
		{
			trace("doSubscribeSearch");
			var httpCode:String = result.httpCode;
			var content:String = result.content;
			var wrapper:Object = getWrapperFromResult(result);
			if (httpCode == "201")
			{
				var idEx:RegExp = /feeds\/api\/users\/.+\/subscriptions\/(.+)[<]\/id[>]/i;
				var id:String = idEx.exec(content)[1];
				
				wrapper.subscriptionId = id;
				dispatchEvent(new YouTubeEvent(YouTubeEvent.SEARCH_SUBSCRIPTION_SUCCESSFUL, wrapper));
			}
			else if (httpCode == "400")
			{
				wrapper.error = content;
				dispatchEvent(new YouTubeEvent(YouTubeEvent.SUBSCRIPTION_FAILED, wrapper));
			}
		}
		
		protected function doSubscribeFavorites(result:Object):void
		{
			trace("doSubscribeFavorites");
			var httpCode:String = result.httpCode;
			var content:String = result.content;
			var wrapper:Object = getWrapperFromResult(result);
			if (httpCode == "201")
			{
				var idEx:RegExp = /feeds\/api\/users\/.+\/subscriptions\/(.+)[<]\/id[>]/i;
				var id:String = idEx.exec(content)[1];
				
				wrapper.subscriptionId = id;
				dispatchEvent(new YouTubeEvent(YouTubeEvent.FAVORITES_SUBSCRIPTION_SUCCESSFUL, wrapper));
			}
			else if (httpCode == "400")
			{
				wrapper.error = content;
				dispatchEvent(new YouTubeEvent(YouTubeEvent.SUBSCRIPTION_FAILED, wrapper ));
			}
		}
		
		protected function doSubscribeChannel(result:Object):void
		{
			trace("doSubscribeChannel");
			
			var httpCode:String = result.httpCode;
			var content:String = result.content;
			var wrapper:Object = getWrapperFromResult(result);
			
			if (httpCode == "201")
			{
				var idEx:RegExp = /feeds\/api\/users\/.+\/subscriptions\/(.+)[<]\/id[>]/i;
				var id:String = idEx.exec(content)[1];
				
				wrapper.subscriptionId = id;
				
				dispatchEvent(new YouTubeEvent(YouTubeEvent.CHANNEL_SUBSCRIPTION_SUCCESSFUL, wrapper));
			}
			else if (httpCode == "400")
			{
				wrapper.error = content;
				dispatchEvent(new YouTubeEvent(YouTubeEvent.SUBSCRIPTION_FAILED, wrapper ));
			}
		}
		
		protected function doUnfavorite(result:Object):void
		{
			var wrapper:Object = getWrapperFromResult(result);
			var httpCode:String = result.httpCode;
			var content:String = result.content;
			
			if (httpCode == "200")
				dispatchEvent(new YouTubeEvent(YouTubeEvent.UNFAVORITE_SUCCESSFUL, { } ));
			else if (httpCode == "404")
				dispatchEvent(new YouTubeEvent(YouTubeEvent.UNFAVORITE_FAILED, { error:content } ));
		}
		
		protected function doFavorite(result:Object):void
		{
			var httpCode:String = result.httpCode;
			var content:String = result.content;
			
			var wrapper:Object = getWrapperFromResult(result);
			
			if (content == "This resource already exists" && httpCode == "400")
				dispatchEvent(new YouTubeEvent(YouTubeEvent.FAVORITE_FAILED, { error:content } ));
			else if (httpCode == "201")
				dispatchEvent(new YouTubeEvent(YouTubeEvent.FAVORITE_SUCCESSFUL, { } ));
		}
		
		protected function doRating(result:Object):void
		{
			trace("doRating");
			
			var wrapper:Object = getWrapperFromResult(result);
			
			if (result.httpCode == "201")
			{
				trace("rating was a success");
				dispatchEvent(new YouTubeEvent(YouTubeEvent.RATING_SUCCESSFUL, wrapper ));
			}
			else
			{
				trace("rating was not successfull");
			}
		}
		
		protected function doLogin(result:Object):void
		{
			trace("doLogin");
			
			var content:String = result.content;
			var wrapper:Object = getWrapperFromResult(result);
			
			if (result.httpCode == "200")
			{
				
				var authRegEx:RegExp = /Auth=(.*)\n/i;
				var userRegEx:RegExp = /YouTubeUser=(.*)\n/i;

				_auth = authRegEx.exec(content)[1];
				_username = userRegEx.exec(content)[1];
				
				dispatchEvent(new YouTubeEvent(YouTubeEvent.LOGIN_SUCCESSFULL, {}));
			}
			else if (result.httpCode == "403")
			{
				var errEx:RegExp = /Error=(.+)\n/i;
				var error:String = errEx.exec(content)[1];
				
				dispatchEvent(new YouTubeEvent(YouTubeEvent.LOGIN_FAILED, { error:error } ));
			}
			else if (result.httpCode == "401")
			{
				
			}
		}		
		
		protected function traceObj(obj:Object):void
		{
			var i;
			for (i in obj)
				trace(i + ":" + obj[i]);
		}
		
		protected function getStdHeaders():Array
		{
			var headers = ["Content-Type: application/atom+xml",
			   "Authorization: GoogleLogin auth=" + _auth,
			   "X-GData-Client: "+_clientId,
			   "X-GData-Key: key=" + _developerKey];

			return headers;
		}
		
		protected function getWrapper(responder:Responder, type:String):Object
		{
			var wrapper:Object = { };
			wrapper.id = _requestId++;
			wrapper.success = false;
			wrapper.type = type;
			wrapper.responder = responder;
			_requestQueue.push(wrapper);
			
			return wrapper;
		}
		
		protected function getWrapperById(requestId:Number):Object
		{
			for (var i:Number = 0; i < _requestQueue.length; i++)
			{
				if (_requestQueue[i].id == requestId)
					return _requestQueue[i];
			}
			
			trace("wrapper with requestId:" + requestId + " not found. Returning null");
			return null;
		}
		
		protected function getWrapperFromResult(result:Object):Object
		{
			var requestId:Number = parseInt(result.requestId);
			return getWrapperById(requestId);
		}
		
		protected function doAsyncError(evt:AsyncErrorEvent):void
		{
			
		}
		
		protected function doNetStatus(evt:NetStatusEvent):void
		{
			
		}
		
		protected function doIOError(evt:IOErrorEvent):void
		{
			
		}
		
		protected function doSecurityError(evt:SecurityErrorEvent):void
		{
			
		}
		
		protected function doFault(fault:Object):void
		{
			
		}
	}
}