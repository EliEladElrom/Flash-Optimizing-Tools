/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.feeds
{
	import ca.newcommerce.youtube.data.CommentData;

	public class CommentFeed extends AbstractFeed
	{		
		public function CommentFeed(rawData:String)
		{
			super(rawData);
		}		
		
		public function getAt(pos:Number):CommentData
		{
			if (pos >= 0 && pos < count)
				return new CommentData(_entries[pos]);
			else
				return null;
		}
		
		public function first():CommentData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function next():CommentData
		{
			return getAt(++_feedPointer);
		}
		
		public function last():CommentData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function previous():CommentData
		{
			return getAt(--_feedPointer);
		}
	}
}