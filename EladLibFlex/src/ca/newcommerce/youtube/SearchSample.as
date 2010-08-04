/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube
{
	import ca.newcommerce.youtube.data.ThumbnailData;
	import ca.newcommerce.youtube.data.VideoData;
	import ca.newcommerce.youtube.events.VideoFeedEvent;
	import ca.newcommerce.youtube.feeds.VideoFeed;
	import ca.newcommerce.youtube.iterators.ThumbnailIterator;
	import ca.newcommerce.youtube.webservice.YouTubeClient;

	public class SearchSample
	{
		protected var _ws:YouTubeClient;		
		protected var _requestId:Number;
		
		public function SearchSample()
		{
			_ws = YouTubeClient.getInstance();
			
			_ws.addEventListener(VideoFeedEvent.VIDEO_DATA_RECEIVED, doSearchResults);
			_requestId = _ws.getVideos("american idol", "", null, null, ["music"], ["male"], YouTubeClient.ORDER_BY_VIEWCOUNT, YouTubeClient.RACY_INCLUDE);
			
			_ws.getVideos("music video");
		}
		
		protected function doSearchResults(evt:VideoFeedEvent):void
		{
			if(_requestId == evt.requestId)
			{
				var feed:VideoFeed = evt.feed;
				var video:VideoData;	
				
				trace("feed:"+feed.id);
				
				while(video = feed.next())
				{
					// video title
					video.title;
					
					// video author's name
					video.authors.first().username;
					
					var tnIt:ThumbnailIterator = video.media.thumbnails;
					var tn:ThumbnailData;
					
					while(tn = tnIt.next())
					{
						// thumbnail url
						tn.url
						
						// thumbnail width
						tn.width;
						
						// thumbnail height
						tn.height;
						
						// thumbnail time sequence
						tn.time;
					}					
				}
			}
			else
			{
				trace("this call:"+evt.requestId+" isn't ours. We'll wait for the next one...");
			}
		}
	}	
}
