package com.elad.youtube.utills
{
	import ca.newcommerce.youtube.data.ThumbnailData;
	import ca.newcommerce.youtube.data.VideoData;
	import ca.newcommerce.youtube.events.StandardVideoFeedEvent;
	import ca.newcommerce.youtube.events.VideoFeedEvent;
	import ca.newcommerce.youtube.feeds.VideoFeed;
	import ca.newcommerce.youtube.iterators.ThumbnailIterator;
	import ca.newcommerce.youtube.webservice.YouTubeFeedClient;
	
	import com.elad.youtube.events.VideoListRetrievedEvent;
	import com.elad.youtube.vo.YouTubeVideoVO;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class GetVideosList extends EventDispatcher
	{
		
		private var maxFeedLength:Number = 15;
		private var feedClient:YouTubeFeedClient;		
		private var requestId:Number;

		/**
		 * Default constructor 
		 * 
		 */		
		public function GetVideosList()
		{
			feedClient = YouTubeFeedClient.getInstance();
			feedClient.addEventListener(VideoFeedEvent.VIDEO_DATA_RECEIVED, feedsEventHandler);
			feedClient.addEventListener(StandardVideoFeedEvent.STANDARD_VIDEO_DATA_RECEIVED, feedsEventHandler);			
		}
		
		/**
		 * Method to retrieve the top rated videos
		 * 
		 */		
		public function getTopRated():void 
		{
			requestId = feedClient.getStandardFeed(YouTubeFeedClient.STD_TOP_RATED, "", 1, maxFeedLength);	
		}
		
		/**
		 * Method to retrieve the most viewed videos 
		 * 
		 */		
		public function getMostViewed():void 
		{
			requestId = feedClient.getStandardFeed(YouTubeFeedClient.STD_MOST_VIEWED, "", 1, maxFeedLength);	
		}
		
		/**
		 * Method to retrieve the featured videos
		 * 
		 */		
		public function getRecentlyFeatured():void 
		{
			requestId = feedClient.getStandardFeed(YouTubeFeedClient.STD_RECENTLY_FEATURED,"", 1, maxFeedLength);	
		}
		
		/**
		 * Method to retrieve based on keywords
		 * 
		 * @param search
		 * 
		 */		
		public function getVideosBasedOnSearch(searchTerm:String):void 
		{			
			requestId = feedClient.getVideos(searchTerm, "", null, null, null, null,"relevance", "exclude", 1, maxFeedLength);	
		}	
		
		/**
		 * Feeds event handler
		 * 
		 * @param event
		 * 
		 */		
		private function feedsEventHandler(event:*):void
		{
			var feed:VideoFeed = event.feed;	
			var videoCollection:ArrayCollection = new ArrayCollection();
			var videoData:VideoData;
			
			while (videoData = feed.next()) 
			{
				var thumbnailIterator:ThumbnailIterator = videoData.media.thumbnails;
				var thumbnailData:ThumbnailData;
				var thumbArray:Array = [];
			
				while(thumbnailData = thumbnailIterator.next() ) 
				{
					thumbArray.push(thumbnailData.url);
				}
				
				var youTubeVideo:YouTubeVideoVO = new YouTubeVideoVO(videoData.title, videoData.content ,thumbArray[0], videoData.actualId, videoData.viewCount.toString(), "", false);
				videoCollection.addItem( youTubeVideo ); 
			}
			
			if (videoCollection.length > 0) 
			{
				this.dispatchEvent(new VideoListRetrievedEvent(VideoListRetrievedEvent.LIST_RETRIEVED, videoCollection));
			}
		}			
	}
}