/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.feeds
{
	import ca.newcommerce.youtube.data.PlaylistData;

	public class PlaylistFeed extends AbstractFeed
	{
		
		public function PlaylistFeed(rawData:String)
		{
			super(rawData);
		}
		
		public function getAt(pos:Number):PlaylistData
		{
			if (pos >= 0 && pos < count)
				return new PlaylistData(_entries[pos]);
			else
				return null;
		}
		
		public function first():PlaylistData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function next():PlaylistData
		{
			return getAt(++_feedPointer);
		}
		
		public function last():PlaylistData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function previous():PlaylistData
		{
			return getAt(--_feedPointer);
		}
	}
}