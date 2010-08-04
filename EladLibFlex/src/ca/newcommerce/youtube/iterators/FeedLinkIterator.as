/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.iterators
{
	import ca.newcommerce.youtube.data.FeedLinkData;
	
	public class FeedLinkIterator
	{
		protected var _data:Array;
		protected var _feedPointer:Number = -1;
		
		public function FeedLinkIterator(data:Array)
		{
			_data = data;
		}
		
		public function get count():Number
		{
			return _data.length;
		}
		
		public function getAt(pos:Number):FeedLinkData
		{
			if (pos >= 0 && pos < count)
				return new FeedLinkData(_data[pos]);
			else
				return null;
		}
		
		public function next():FeedLinkData
		{
			return getAt(++_feedPointer);
		}
		
		public function first():FeedLinkData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function last():FeedLinkData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function previous():FeedLinkData
		{
			return getAt(--_feedPointer);
		}
	}
}