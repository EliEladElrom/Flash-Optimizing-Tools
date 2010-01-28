/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	import ca.newcommerce.youtube.iterators.AuthorIterator;
	import ca.newcommerce.youtube.iterators.LinkIterator;
	import ca.newcommerce.youtube.iterators.CategoryIterator;
	import ca.newcommerce.youtube.iterators.MediaContentIterator;
	
	public class VideoData extends AbstractData
	{
		protected var _data:Object;
		
		public function VideoData(data:Object)
		{
			_data = data;
		}
		
		public function get content():String
		{
			return fromObj(_data, "content");			
		}
		
		public function get id():String
		{
			return fromObj(_data, "id");			
		}
		
		public function get actualId():String
		{
			var id:String = this.id;
			return id.substr(id.lastIndexOf("/") + 1);
		}
		
		public function get title():String
		{
			return fromObj(_data, "title");
		}
		
		public function get authors():AuthorIterator
		{
			return new AuthorIterator(_data.author);
		}
		
		public function get categories():CategoryIterator
		{
			return new CategoryIterator(_data.category);
		}
		
		public function get media():MediaGroupData
		{
			return new MediaGroupData(_data.media$group);
		}
		
		public function get rating():RatingData
		{
			return new RatingData(_data.gd$rating);
		}
		
		public function get updated():String
		{
			return fromObj(_data, "updated");
		}
		
		public function get links():LinkIterator
		{
			return new LinkIterator(_data.link);
		}
		
		public function get viewCount():Number
		{
			return parseInt(_data.yt$statistics.viewCount);
		}
		
		public function get published():String
		{
			return fromObj(_data, "published");
		}
		
		public function get commentCount():Number
		{
			if (_data.gd$comments && _data.gd$comments.gd$feedLink && _data.gd$comments.gd$feedLink.countHint)
				return parseInt(_data.gd$comments.gd$feedLink.countHint);
			else
				return 0;
		}
		
		public function get commentFeedUri():String
		{		
			if (_data.gd$comments && _data.gd$comments.gd$feedLink && _data.gd$comments.gd$feedLink.href)
				return _data.gd$comments.gd$feedLink.href;
			else
				return null;
		}	
		
		public function get keywords():Array
		{
			return categories.keywords;
		}
		
		public function get categorywords():Array
		{
			return categories.categorywords;
		}
		
		public function get swfUrl():String
		{
			var content:MediaContentData;
			var contents:MediaContentIterator = this.media.contents;
			
			while (content = contents.next())
			{
				if (content.type == "application/x-shockwave-flash")
					return content.url;
			}
			
			return "";
		}
		
		public function get mobileUrl():String
		{
			var content:MediaContentData;
			var contents:MediaContentIterator = this.media.contents;
			
			while (content = contents.next())
			{
				if (content.type == "video/3gpp" && content.format == 6)
					return content.url;
			}
			
			return "";
		}
		
		public function get duration():Number
		{
			return media.duration;
		}
	}	
}
