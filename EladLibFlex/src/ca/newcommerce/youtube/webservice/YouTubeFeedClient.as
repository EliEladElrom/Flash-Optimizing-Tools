/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.webservice
{
	import ca.newcommerce.youtube.data.*;
	import ca.newcommerce.youtube.events.CommentFeedEvent;
	import ca.newcommerce.youtube.events.ContactFeedEvent;
	import ca.newcommerce.youtube.events.PlaylistFeedEvent;
	import ca.newcommerce.youtube.events.ProfileEvent;
	import ca.newcommerce.youtube.events.ResponseFeedEvent;
	import ca.newcommerce.youtube.events.StandardVideoFeedEvent;
	import ca.newcommerce.youtube.events.SubscriptionFeedEvent;
	import ca.newcommerce.youtube.events.VideoDataEvent;
	import ca.newcommerce.youtube.events.VideoFeedEvent;
	import ca.newcommerce.youtube.events.YouTubeEvent;
	import ca.newcommerce.youtube.feeds.*;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
		
	public class YouTubeFeedClient extends EventDispatcher
	{	
		protected var _requestQueue:Array;
		protected var _requestId:Number = 0;
		protected var _sessionId:String;
		
		protected const _clientId:String = "ytapi-MartinLegris-YoutubeDiscovery-rn7ifdis-0";
		protected const _developerKey:String = "AI39si5ojvdQW_7wzbgApyTS1EMXiEfRVZtq4usxFYDFq6ZqEDiaSsPrkNLdFPwy97z9wyGtk6FPrc35H5B9LjugSQG5duueYg";
		protected var _auth:String = "";
		protected var _username:String = "";
		
		// is a Singleton
		private static var _instance:YouTubeFeedClient;	
		
		public static const STD_TOP_RATED:String = "top_rated";
		public static const STD_TOP_FAVORITES:String = "top_favorites";
		public static const STD_MOST_VIEWED:String = "most_viewed";
		public static const STD_MOST_DISCUSSED:String = "most_discussed";
		public static const STD_MOST_LINKED:String = "most_linked";
		public static const STD_MOST_RESPONSED:String = "most_responded";
		public static const STD_RECENTLY_FEATURED:String = "recently_featured";
		public static const STD_MOBILE_VIDEOS:String = "watch_on_mobile";
		
		public static const TIME_TODAY:String = "today";
		public static const TIME_WEEK:String = "this_week";
		public static const TIME_MONTH:String = "this_month";
		public static const TIME_ALL:String = "all_time";
		
		public static const RACY_INCLUDE:String = "include";
		public static const RACY_EXCLUDE:String = "exclude";
		
		public static const ORDER_BY_PUBLISHED:String = "published";
		public static const ORDER_BY_VIEWCOUNT:String = "viewCount";
		public static const ORDER_BY_RELEVANCE:String = "relevance";
		
		/**
		 * Encodes a object into a JSON string.
		 *
		 * @param o The object to create a JSON string for
		 * @return the JSON string representing o
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		
		 /**
		  * Get access to the unique YouTubeFeedClient instance (singleton)
		  * 
		  * @return the unique YouTubeFeedClient instance
		  */
		
		public static function getInstance():YouTubeFeedClient
		{
			if (_instance == null)
				_instance = new YouTubeFeedClient();
			
			return _instance;
		}
		
		/**
		 * Constructor, never to be used outside
		 */
		public function YouTubeFeedClient()
		{
			_requestQueue = [];
		}
		
		/**
		 * Function which executes the call to the API
		 * 
		 * @param	request URLRequest object containing the URL to be called
		 * @param	doComplete callback function for the Event.COMPLETE handler
		 * @param	wrapper the wrapper object which contains the call context, can be used once we get the answer back
		 * @return  requestId
		 */
		
		protected function runLoader(request:URLRequest, doComplete:Function, wrapper:Object):Number
		{
			var loader:URLLoader = new URLLoader();			
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, doHttpStatus);
			loader.addEventListener(IOErrorEvent.IO_ERROR, doIOError);
			loader.addEventListener(ProgressEvent.PROGRESS, handleProgress);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR , doSecurityError);
			loader.addEventListener(Event.COMPLETE, doComplete);
			loader.load(request);
			
			wrapper.id = _requestId++;
			wrapper.success = false;
			wrapper.loader = loader;
			_requestQueue.push(wrapper);
			
			return _requestId - 1;
		}
		
		/**
		 * TODO: to be implemented
		 * 
		 * @param	url the url to deconsctruct to know what the call was for
		 * @return  nothing yet
		 */
		
		public static function fromURL(url:String):Number
		{
			return -1;
			// deconstruct the url to find out which service it is and call it.
		}
		
		/**
		 * Function which returns a position inside of the _requestQueue based on which loader
		 * 
		 * @param	loader URLLoader to be used to fetch the position in the queue
		 * @return  index of the _requestQueue
		 */
		
		protected function getLoaderIndex(loader:URLLoader):Number
		{
			for (var i:Number = 0; i < _requestQueue.length; i++)
			{
				if (_requestQueue[i].loader == loader)
					return i;
			}
			
			return -1;
		}
		
		/**
		 * Function which returns the call context wrapping object based on a loader (from Event.COMPLETE handler)
		 * 
		 * @param	loader URLLoader to be used to find the call context wrapping object
		 * @return  the call context wrapping object
		 */
		
		protected function getWrapper(loader:URLLoader):Object
		{
			return _requestQueue[getLoaderIndex(loader)];
		}
		
		public function rawUrl(url:String):Number
		{
			var request:URLRequest = new URLRequest(url);
			return runLoader(request, doRawUrlLoaded, { comment:"rawUrl", url:url } );
		}
		
		public function getPlaylist(playlistId:String, startIndex:Number = 1, maxResults:Number = 50):Number
		{
			var request:URLRequest = new URLRequest("http://gdata.youtube.com/feeds/api/playlists/" + playlistId + "?alt=json&start-index=" + startIndex + "&max-results=" + maxResults);
			return runLoader(request, doPlaylistLoaded, { comment:"playlist", playlistId:playlistId } );
		}
		
		// default categories: Friends and Family.. other categories can exist..
		public function getUserContacts(username:String, categories:Array = null, startIndex:Number = 1, maxResults:Number = 50):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/users/" + username+"/contacts";
			
			if (categories != null && categories.length > 0)
				url += "/-/" + categories.join("%7C");
				
			url += "?alt=json&start-index=" + startIndex + "&max-results=" + maxResults;
			
			var request:URLRequest = new URLRequest(url);
			return runLoader(request, doUserContactsLoaded, { comment: "contacts", username:username, categories:categories, startIndex:startIndex, maxResults:maxResults } );
		}
		
		public function getStandardFeed(type:String, time:String = "", startIndex:Number = 1, maxResults:Number = 50 ):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/standardfeeds/" + type + "?alt=json&start-index="+startIndex+"&max-results="+maxResults;
			if (type == STD_TOP_RATED && type == STD_MOST_VIEWED && time.length > 0)
				url += "&time=" + time;
			var request:URLRequest = new URLRequest(url);
			return runLoader(request, doStdFeedLoaded, { comment: "standard_feed", type:type, time:time } );
		}
		
		public function getVideos(search:String = "", author:String = "", categories:Array = null, negativeCategories:Array = null, keywords:Array = null, negativeKeywords:Array = null, orderBy:String = "relevance", racy:String = "exclude", startIndex:Number = 1, maxResults:Number = 50):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/videos";
			if (categories is Array && categories.length > 0)
				url += "/-/" + categories.join("%7C");
			
			if (keywords is Array && keywords.length > 0)
			{
				if (url.indexOf("/-/") == -1)
					url += "/-";
				
				url += "/" + keywords.join("%7C");
			}			
			
			url += "?alt=json&orderby=" + orderBy + "&racy=" + racy + "&start-index=" + startIndex + "&max-results=" + maxResults;
			
			if (search.length > 0)
				url += "&vq=" + search;
			if (author.length > 0)
				url += "&author=" + author;

			var request:URLRequest = new URLRequest(url);
			return runLoader(request, doVideosLoaded, { comment: "videos", search:search, author:author, categories:categories, keywords:keywords, orderBy:orderBy, racy:racy, startIndex:startIndex, maxResults:maxResults } );
		}
		
		public function getVideo(videoId:String):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/videos/" + videoId + "?alt=json";			
			var request:URLRequest = new URLRequest(url);
			
			return runLoader(request, doVideoLoaded, { comment: "video", videoId: videoId } );
		}
		
		public function getUserProfile(username:String):Number
		{
			var request:URLRequest = new URLRequest("http://gdata.youtube.com/feeds/api/users/"+username+"?alt=json");
			return runLoader(request, doProfileLoaded, { comment:"profile", username:username } );
		}
		
		public function getVideoComments(videoId:String, startIndex:Number = 1, maxResults:Number = 50):Number
		{
			var request:URLRequest = new URLRequest("http://gdata.youtube.com/feeds/api/videos/" + videoId + "/comments?alt=json&start-index=" + startIndex + "&max-results=" + maxResults);
			return runLoader(request, doCommentsLoaded, { comment:"comments", videoId:videoId } );
		}
		
		public function getRelatedVideos(videoId:String, startIndex:Number = 1, maxResults:Number = 50):Number
		{
			var request:URLRequest = new URLRequest("http://gdata.youtube.com/feeds/api/videos/" + videoId + "/related?alt=json&start-index=" + startIndex + "&max-results=" + maxResults);
			return runLoader(request, doRelatedVideosLoaded, { comments:"related_videos", videoId:videoId } );
		}
		
		// possible categories: channel, favorites, query
		public function getUserSubscriptions(username:String, categories:Array = null, startIndex:Number = 1, maxResults:Number = 50):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/users/" + username + "/subscriptions";
			
			if (categories != null && categories.length > 0)
				url += "/-/" + categories.join("%7C");
			
			url += "?alt=json&start-index=" + startIndex + "&max-results=" + maxResults;
			var request:URLRequest = new URLRequest(url);
			
			return runLoader(request, doSubscriptionsLoaded, { comment:"subscriptions", username:username } );
		}
		
		public function getUserFavorites(username:String, categories:Array = null, keywords:Array = null, startIndex:Number = 1, maxResults:Number = 50):Number
		{
			var url:String = "http://gdata.youtube.com/feeds/api/users/" + username + "/favorites";			
			
			if (categories is Array && categories.length > 0)
				url += "/-/" + categories.join("%7C");
			
			if (keywords is Array && keywords.length > 0)
			{
				if (url.indexOf("/-/") == -1)
					url += "/-";
				
				url += "/" + keywords.join("%7C");
			}
			
			url += "?alt=json&start-index=" + startIndex + "&max-results=" + maxResults;
			
			var request:URLRequest = new URLRequest(url);
			
			return runLoader(request, doUserFavoritesLoaded, { comment:"favorites", username:username } );
		}
		
		public function getUserPlaylists(username:String, startIndex:Number = 1, maxResults:Number = 50):Number
		{
			var request:URLRequest = new URLRequest("http://gdata.youtube.com/feeds/api/users/" + username + "/playlists?alt=json&start-index=" + startIndex + "&max-results=" + maxResults);
			return runLoader(request, doUserPlaylistsLoaded, { comment:"user_playlist", username:username } );
		}
		
		public function getVideoResponses(videoId:String):Number
		{
			var request:URLRequest = new URLRequest("http://gdata.youtube.com/feeds/api/videos/"+videoId+"/responses?alt=json");
			return runLoader(request, doResponsesLoaded, { comment:"responses", videoId:videoId } );
		}
		
		
		protected function doUserPlaylistsLoaded(evt:Event):void
		{
			trace("doUserPlaylistsLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var feed:PlaylistFeed = new PlaylistFeed(evt.target.data as String);
			
			dispatchEvent(new PlaylistFeedEvent(PlaylistFeedEvent.PLAYLIST_DATA_RECEIVED, wrapper.id, wrapper.username, feed));
		}
		
		protected function doUserContactsLoaded(evt:Event):void
		{
			trace("doUserContactsLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var feed:ContactFeed = new ContactFeed(evt.target.data as String);
			
			dispatchEvent(new ContactFeedEvent(ContactFeedEvent.USER_DATA_RECEIVED, wrapper.id, feed));
		}
		
		protected function doUserFavoritesLoaded(evt:Event):void
		{
			trace("doUserFavoritesLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var feed:VideoFeed = new VideoFeed(evt.target.data as String);
			
			dispatchEvent(new VideoFeedEvent(VideoFeedEvent.USER_FAVORITES_DATA_RECEIVED, wrapper.id, feed));
		}
		
		protected function doPlaylistLoaded(evt:Event):void
		{
			trace("doPlaylistLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var feed:VideoFeed = new VideoFeed(evt.target.data as String);
		
			dispatchEvent(new VideoFeedEvent(VideoFeedEvent.VIDEO_PLAYLIST_DATA_RECEIVED, wrapper.id, feed));
		}
		
		protected function doRelatedVideosLoaded(evt:Event):void
		{
			trace("doRelatedVideosLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var feed:VideoFeed = new VideoFeed(evt.target.data as String);
			
			dispatchEvent(new VideoFeedEvent(VideoFeedEvent.RELATED_VIDEOS_DATA_RECEIVED, wrapper.id, feed));
		}
		
		protected function doStdFeedLoaded(evt:Event):void
		{
			trace("doStdFeedLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var feed:VideoFeed = new VideoFeed(evt.target.data as String);
			
			dispatchEvent(new StandardVideoFeedEvent(StandardVideoFeedEvent.STANDARD_VIDEO_DATA_RECEIVED, wrapper.id, wrapper.type, feed));
		}
		
		protected function doRawUrlLoaded(evt:Event):void
		{
			trace("doRawUrlLoaded");
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			dispatchEvent(new YouTubeEvent(YouTubeEvent.RAW_URL_DATA_RECEIVED, wrapper));
		}
		
		protected function doVideosLoaded(evt:Event):void
		{
			trace("doVideosLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var feed:VideoFeed = new VideoFeed(evt.target.data);
			
			dispatchEvent(new VideoFeedEvent(VideoFeedEvent.VIDEO_DATA_RECEIVED, wrapper.id, feed));
		}
		
		protected function doCommentsLoaded(evt:Event):void
		{
			trace("doCommentsLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var feed:CommentFeed = new CommentFeed(evt.target.data as String);
			
			dispatchEvent(new CommentFeedEvent(CommentFeedEvent.COMMENT_DATA_RECEIVED, wrapper.id, feed));
		}
		
		public function doResponsesLoaded(evt:Event):void
		{
			trace("doResponsesLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);			
			var feed:VideoFeed = new VideoFeed(evt.target.data as String);
			
			dispatchEvent(new ResponseFeedEvent(ResponseFeedEvent.RESPONSES_DATA_RECEIVED, wrapper.id, wrapper.videoId, feed));
		}
		
		protected function doProfileLoaded(evt:Event):void
		{
			trace("doProfileLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var profile:ProfileData = new ProfileData(JSON.decode(evt.target.data as String).entry);
			
			dispatchEvent(new ProfileEvent(ProfileEvent.PROFILE_DATA_RECEIVED, wrapper.id, profile));
		}
		
		protected function doSubscriptionsLoaded(evt:Event):void
		{
			trace("doSubscriptionsLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);			
			var feed:SubscriptionFeed = new SubscriptionFeed(evt.target.data as String);
			
			dispatchEvent(new SubscriptionFeedEvent(SubscriptionFeedEvent.SUBSCRIPTION_DATA_RECEIVED, wrapper.id, feed));
		}
		
		protected function doVideoLoaded(evt:Event):void
		{
			trace("doVideoLoaded");
			
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			var entry:Object = JSON.decode(evt.target.data as String);			
			
			var video:VideoData = new VideoData(entry.entry);
			
			dispatchEvent(new VideoDataEvent(VideoDataEvent.VIDEO_INFO_RECEIVED, wrapper.id, video));
		}
		
		protected function doHttpStatus(evt:HTTPStatusEvent):void
		{
			trace("WSClient.doHttpStatus:" + evt.status);
			if (evt.status == 201)
			{
				evt.stopImmediatePropagation();
				var wrapper:Object = getWrapper(evt.target as URLLoader);
				trace("wrapper.videoId:" + wrapper.videoId);
				wrapper.success = true;
				trace(evt.target.data);
			}
		}
		
		/**
		* Event handler for IOErrorEvent.IO_ERROR on URLLoader
		* @param	evt IOErrorEvent object
		*/
		protected function doIOError(evt:IOErrorEvent):void
		{
			var wrapper:Object = getWrapper(evt.target as URLLoader);
			if(!wrapper.success)
				trace("WSClient.doIOError(" + evt.toString());
			else
				trace("success!");
		}
		
		/**
		* Event handler for  SecurityErrorEvent.SECURITY_ERROR on URLLoader 
		* @param	evt SecurityErrorEvent object
		*/
		protected function doSecurityError(evt:SecurityErrorEvent):void
		{
			trace("WSClient.doSecurityError("+evt.toString());			
		}

		/**
		* Event handler for ProgressEvent.PROGRESS on URLLoader
		* @param	evt ProgressEvent object
		*/
		protected function handleProgress(evt:ProgressEvent):void
		{
			var percent:Number = Math.round(evt.bytesLoaded / evt.bytesTotal * 100);
			var idx:Number = getLoaderIndex(evt.target as URLLoader);
			//trace("loader:"+idx+" at "+percent+"%; bytesLoaded:"+evt.bytesLoaded+", bytesTotal:"+evt.bytesTotal);
		}
		
		/**
		* Event handler for IoErrorEvent.IO_ERROR on URLLoader for getTracksById calls
		* @param	evt IOErrorEvent object
		*/		
		protected function handleIOError(evt:IOErrorEvent):void
		{
			trace("ioError on loader:" + getLoaderIndex(evt.target as URLLoader));
		}		
		
	}
}