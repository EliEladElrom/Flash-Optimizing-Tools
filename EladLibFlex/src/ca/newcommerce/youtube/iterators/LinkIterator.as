/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.iterators
{
	import ca.newcommerce.youtube.data.LinkData;
	
	public class LinkIterator
	{
		protected var _data:Array;
		protected var _feedPointer:Number = -1;
		
		public function LinkIterator(data:Array)
		{
			_data = data;
		}
		
		public function get count():Number
		{
			return _data.length;
		}
		
		public function getAt(pos:Number):LinkData
		{
			if (pos >= 0 && pos < count)
				return new LinkData(_data[pos]);
			else
				return null;
		}
		
		public function next():LinkData
		{
			return getAt(++_feedPointer);
		}
		
		public function first():LinkData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function last():LinkData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function previous():LinkData
		{
			return getAt(--_feedPointer);
		}
	}
}