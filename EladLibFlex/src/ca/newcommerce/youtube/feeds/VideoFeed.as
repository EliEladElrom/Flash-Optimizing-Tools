/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.feeds
{	
	import ca.newcommerce.youtube.data.VideoData;
	
	public class VideoFeed extends AbstractFeed
	{
		public function VideoFeed(rawData:String)
		{
			super(rawData);
		}
		
		public function next():VideoData
		{
			return getAt(++_feedPointer);
		}
		
		public function first():VideoData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function last():VideoData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function previous():VideoData
		{
			return getAt(--_feedPointer);
		}
		
		public function getAt(pos:Number):VideoData
		{
			if (pos >= 0 && pos < count)
				return new VideoData(_entries[pos]);
			else
				return null;
		}
	}
}