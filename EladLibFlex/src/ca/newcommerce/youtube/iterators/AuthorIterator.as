/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.iterators
{
	import ca.newcommerce.youtube.data.AuthorData;
	
	public class AuthorIterator
	{
		protected var _data:Array;
		protected var _feedPointer:Number = -1;
		
		public function AuthorIterator(data:Array)
		{
			_data = data;
		}
		
		public function get count():Number
		{
			return _data.length;
		}
		
		public function next():AuthorData
		{
			return getAt(++_feedPointer);
		}
		
		public function first():AuthorData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function last():AuthorData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function getAt(pos:Number):AuthorData
		{
			if (count > pos)
				return new AuthorData(_data[pos]);
			else
				return null;
		}
	}
}
