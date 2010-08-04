package ca.newcommerce.youtube.net
{
	import flash.net.*;
	import flash.events.*;
	import flash.system.Security;
	import flash.errors.EOFError;
	import com.adobe.net.URI;
	import flash.utils.Timer;
	import flash.errors.IOError;
	import com.adobe.utils.StringUtil;


	dynamic public class SocketURLLoader extends EventDispatcher
	{
		[Event(name="close", type="flash.events.Event.CLOSE")]
		[Event(name="complete", type="flash.events.Event.COMPLETE")]
		[Event(name="open", type="flash.events.Event.CONNECT")]
		[Event(name="ioError", type="flash.events.IOErrorEvent.IO_ERROR")]
		[Event(name="securityError", type="flash.events.SecurityErrorEvent.SECURITY_ERROR")]
		[Event(name="progress", type="flash.events.ProgressEvent.PROGRESS")]
		[Event(name="httpStatus", type="flash.events.HTTPStatusEvent.HTTP_STATUS")]

		private var _httpSocket:Socket;
		private var _httpURI:URI;
		private var _httpMethod:String = "GET";
		private var _request:URLRequest;
		private var _headersServed:Boolean = false;
		private var _responseHeaders:Object;
		private var _data:String = "";
		private var _bytesLoaded:int = 0;
		private var _bytesTotal:int = 0;
		private var _tmpStr:String = "";
		private var _secondTimer:Timer;
		private var _busyCursor:Boolean;
		private var _requestTimeOut:Number = 0;

		public function get data():String
		{
			   return _data;
		}

		public function set method(method:String):void
		{
			   _httpMethod = method;
		}

		public function set showBusyCursor(t:Boolean):void
		{
			   _busyCursor = t;
		}

		public function set requestTimeout(t:Number):void
		{
			   _requestTimeOut = t;
		}

		public function get responseHeaders():Object
		{
			   return _responseHeaders;
		}              

		public function get bytesLoaded():int
		{
			   return _bytesLoaded;
		}

		public function SocketURLLoader()
		{
			   // create http-socket
			   _httpSocket = new Socket();

			   //subscribe to events
			   _httpSocket.addEventListener( "connect" , onConnectEvent , false , 0 );                        
			   _httpSocket.addEventListener( "close" , onCloseEvent , false, 0 );
			   _httpSocket.addEventListener( "ioError" , onIOErrorEvent , false, 0 );
			   _httpSocket.addEventListener( "securityError" , onSecurityErrorEvent , false, 0 );
			   _httpSocket.addEventListener( "socketData" , onSocketDataEvent , false , 0 );
		}

		//## event handlers ##

		private function onConnectEvent(event:Event):void
		{      
			sendHeaders();
			dispatchEvent(new Event(Event.CONNECT));                
		}
			   
		private function onCloseEvent(event:Event):void
		{
			stopTimer();
			hideBusyCursor();
			dispatchEvent(new Event(flash.events.Event.COMPLETE));
		}
			   
		private function onIOErrorEvent(event:IOErrorEvent):void
		{
			stopTimer();
			hideBusyCursor();
			dispatchEvent(event);
		}

		private function onSecurityErrorEvent(event:SecurityErrorEvent):void
		{
			stopTimer();
			hideBusyCursor();
			dispatchEvent(event.clone());
		}

		private function onSocketDataEvent(event:ProgressEvent):void
		{
			hideBusyCursor();
			stopTimer();

			_bytesLoaded+= _httpSocket.bytesAvailable;
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _bytesLoaded, _bytesTotal))
			trace("HTTPURLLoader::onSocketDataEvent() -> " + _bytesLoaded);

			//temporary string variable                    
			var str:String = ""

			// loop while there are bytes available
			while (_httpSocket.bytesAvailable)
			{
				//attempt to read from the socket receive buffer
				try
				{                                              
					   str = _httpSocket.readUTFBytes(_httpSocket.bytesAvailable);                                                    
				}
				//watch for EndOfFile Errors!!!
				catch(e:EOFError)
				{
					   break;
				}                                                                              

			}
			if(!_headersServed)
			{
				_tmpStr+= str;


				//check if headers are over;
				if(str.indexOf("\r\n\r\n")!=-1)
				{
					_headersServed = true;
					 
					//parse header
					var t1:Array =  _tmpStr.split("\r\n\r\n");
					_data+= t1[1];

					var t2:Array = t1[0].split("\r\n");

					_responseHeaders = {};
					for each(var header:String in t2)
					{
						if(header.indexOf("HTTP/1.")==-1)
						{
							var t3:Array = header.split(":");
							if (t3.length > 2)
							{
								var r:String = t3.shift();
								_responseHeaders[r] = StringUtil.trim(t3.join(':'));
							}
							else
							{
								_responseHeaders[t3[0]] = StringUtil.trim(t3[1]);
							}
						}
					}

					if(_responseHeaders["Content-Length"])
					{
						   //total bytes = content-length + header size (number of characters in header)
						   //not working, need to work on right logic..
						   _bytesTotal = int(_responseHeaders["Content-Length"])  +_tmpStr.length;
					}

				}

				var isHTTPStatus:Boolean = false;
				var httpStatusEx:RegExp = /HTTP\/(\d\.\d) (\d{1,3})/i;
				var result:Object = httpStatusEx.exec(_tmpStr);
				var status:Number = parseInt(result[2]);
				var httpVersion:Number = parseFloat(result[1]);

				dispatchEvent(new HTTPStatusEvent(HTTPStatusEvent.HTTP_STATUS, false, false, status));

				switch(httpVersion)
				{
					case 400:
					case 401:
					case 403:
					case 404:
					case 409:
					case 500:
					case 501:
					_httpSocket.close();
					break;
				}
			}
			else
			{
				_data+= str;
			}
		}              

		private function sendHeaders():void
		{
			var requestHeaders:Array = _request.requestHeaders;
			var h:String = "";

			_responseHeaders = null;
			_bytesLoaded = 0;
			_bytesTotal = 0;
			_data = "";
			_headersServed = false;
			_tmpStr = "";
										   
			//create an HTTP 1.0 Header Request

			h+= _httpMethod.toString() + " " + _httpURI.path + " HTTP/1.0\r\n";
			h+= "Host:" + _httpURI.authority + ':' + _httpURI.port + "\r\n";

			if(requestHeaders.length > 0)
			{
				for each(var rh:URLRequestHeader in requestHeaders)
				{
					   h+= rh.name + ":" + rh.value + "\r\n";
				}
			}

			//set HTTP headers to socket buffer
			_httpSocket.writeUTFBytes(h + "\r\n")

			if (_httpMethod != "GET") {
				   if(_request.data){
						   _httpSocket.writeUTFBytes(_request.data.toString());
				   }
			}

			//push the data to server
			_httpSocket.flush()                    
		}

		private function timeout():void
		{
			if (_requestTimeOut < 1)
			{
				   return;
			}
			
			if (_secondTimer && _secondTimer.running)
				_secondTimer.stop();
				
			_secondTimer = new Timer(_requestTimeOut * 1000);
			_secondTimer.addEventListener(TimerEvent.TIMER_COMPLETE,timeoutComplete);
			_secondTimer.start();
		}

		public function stopTimer():void
		{
			//_secondTimer.stop();
		}

		private function timeoutComplete():void
		{
			dispatchEvent(new IOErrorEvent(IOErrorEvent.NETWORK_ERROR,false,false,"Request timed out."));
			_httpSocket.close();
		}

		private function setBusyCursor():void
		{
			if (!_busyCursor)
			{
				return;
			}			   
		}

		public function hideBusyCursor():void
		{
			if (!_busyCursor)
			{
				return;
			}
		}

		public function load(request:URLRequest):void
		{
			_request = request;
			_httpURI = new URI(request.url)
			//var query:String = ""

			_request.requestHeaders.push(new URLRequestHeader('Accept:','text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5'));

			timeout();
			setBusyCursor();

			if (_httpMethod == "GET")
			{
				var newrh4:URLRequestHeader = new URLRequestHeader('Content-Length','0')
				_request.requestHeaders.push(newrh4);
			}
			else
			{
				if (_request.data)
				{
					var newrh:URLRequestHeader;
					
					if (_request.data is XML)
					{
						newrh = new URLRequestHeader('Content-Type','application/xml')
					}
					else
					{
						newrh = new URLRequestHeader('Content-Type','application/x-www-form-urlencoded')
					}
					
					var newrh2:URLRequestHeader = new URLRequestHeader('Content-Length',_request.data.toString().length.toString())
					_request.requestHeaders.push(newrh, newrh2);					
				}
				else
				{
					var newrh3:URLRequestHeader = new URLRequestHeader('Content-Length','0');
					_request.requestHeaders.push(newrh3);
				}
			}
			
			//var d:Array = _httpURI.toString().url.split('http://')[1].split('/');
			trace("_httpUri:" + _httpURI.authority);
			_httpURI.port = "80";
			trace("_httpUri.port:" + _httpURI.port);
			
			_httpSocket.connect(_httpURI.authority, Number(_httpURI.port));        //  + _httpURI.path + _httpURI.query
		}

		public function close():void
		{
			if(_httpSocket.connected)
			{
				_httpSocket.close();
				dispatchEvent(new Event(Event.CLOSE));
			}
		}
	}
}