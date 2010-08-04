/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.iterators
{
	import ca.newcommerce.youtube.data.ThumbnailData;
	
	public class ThumbnailIterator
	{
		protected var _data:Array;
		protected var _feedPointer:Number = -1;
		
		public function ThumbnailIterator(data:Array)
		{
			_data = data;
		}
		
		public function get count():Number
		{
			return _data.length;
		}
		
		public function getAt(pos:Number):ThumbnailData
		{
			if (pos >= 0 && pos < count)
				return new ThumbnailData(_data[pos]);
			else
				return null;
		}
		
		public function first():ThumbnailData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function next():ThumbnailData
		{
			return getAt(++_feedPointer);
		}
		
		public function last():ThumbnailData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function previous():ThumbnailData
		{
			return getAt(--_feedPointer);
		}
	}
}