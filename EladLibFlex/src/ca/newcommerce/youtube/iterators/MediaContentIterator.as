/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.iterators
{
	import ca.newcommerce.youtube.data.MediaContentData;
	
	public class MediaContentIterator
	{
		protected var _data:Array;
		protected var _feedPointer:Number = -1;
		
		public function MediaContentIterator(data:Array)
		{
			_data = data;
		}
		
		public function get count():Number
		{
			return (_data != null) ? _data.length : 0;
		}
		
		public function getAt(pos:Number):MediaContentData
		{
			if (pos >= 0 && pos < count)
				return new MediaContentData(_data[pos]);
			else 
				return null;
		}
		
		public function first():MediaContentData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function next():MediaContentData
		{
			return getAt(++_feedPointer);
		}
		
		public function last():MediaContentData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function previous():MediaContentData
		{
			return getAt(--_feedPointer);
		}
	}
}