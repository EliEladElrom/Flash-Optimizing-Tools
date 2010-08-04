/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{	
	import ca.newcommerce.youtube.iterators.ThumbnailIterator;
	import ca.newcommerce.youtube.iterators.MediaContentIterator;
	import ca.newcommerce.youtube.iterators.CategoryIterator;
	
	public class MediaGroupData extends AbstractData
	{
		protected var _data:Object;
		
		public function MediaGroupData(data:Object)
		{
			_data = data;
		}
		
		public function get contents():MediaContentIterator
		{
			return new MediaContentIterator(_data.media$content);
		}
		
		public function get thumbnails():ThumbnailIterator
		{
			return new ThumbnailIterator(_data.media$thumbnail);
		}
		
		public function get description():String
		{
			return _data.media$description.$t;
		}
		
		public function get title():String
		{
			return _data.media$title.$t;
		}
		
		public function get keywords():Array
		{
			var key:String = _data.media$keywords;
			return key.split(", ");
		}
		
		public function get duration():Number
		{
			return parseInt(_data.yt$duration.seconds);
		}
		
		public function get mediaPlayerUri():String
		{
			return _data.media$player[0].url;
		}
		
		public function get categories():CategoryIterator
		{
			return new CategoryIterator(_data.media$category);
		}		
	}
}