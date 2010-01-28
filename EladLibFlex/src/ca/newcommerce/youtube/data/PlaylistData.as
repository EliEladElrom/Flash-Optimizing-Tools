/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	import ca.newcommerce.youtube.iterators.AuthorIterator;
	import ca.newcommerce.youtube.iterators.CategoryIterator;
	import ca.newcommerce.youtube.iterators.FeedLinkIterator;
	import ca.newcommerce.youtube.iterators.LinkIterator;
	
	public class PlaylistData extends AbstractData
	{
		protected var _data:Object;
		
		public function PlaylistData(data:Object)
		{
			_data = data;
		}
		
		public function get feedLink():FeedLinkData
		{
			return new FeedLinkData(_data.gd$feedLink);
		}
		
		public function get content():String
		{
			return fromObj(_data, "content");
		}
		
		public function get id():String
		{
			return fromObj(_data, "id");
		}
		
		/*
		 * the actual ID to be used to fetch it..
		 */
		
		public function get actualId():String
		{
			var id:String = this.id;
			return id.substr(id.lastIndexOf("/") + 1);
		}
		
		public function get authors():AuthorIterator
		{
			return new AuthorIterator(_data.author);
		}
		
		public function get title():String
		{
			return fromObj(_data, "title");
		}
		
		public function get categories():CategoryIterator
		{
			return new CategoryIterator(_data.category);
		}
		
		public function get updated():String
		{
			return fromObj(_data, "updated");
		}
		
		public function get description():String
		{
			return fromObj(_data, "yt$description");
		}
		
		public function get links():LinkIterator
		{
			return new LinkIterator(_data.link);
		}
		
		public function get published():String
		{
			return fromObj(_data, "published");
		}
	}
}