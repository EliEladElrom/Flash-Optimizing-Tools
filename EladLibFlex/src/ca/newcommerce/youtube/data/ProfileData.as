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

	public class ProfileData extends AbstractData 
	{
		protected var _data:Object;
		
		public function ProfileData(data:Object)
		{
			_data = data;
		}
		
		public function get feedLinks():FeedLinkIterator
		{
			return new FeedLinkIterator(_data.gd$feedLink);
		}
		
		public function get location():String
		{
			return fromObj(_data, "yt$location");
		}
		
		public function get username():String
		{
			return fromObj(_data, "yt$username");
		}
		
		public function get links():LinkIterator
		{
			return new LinkIterator(_data.link);
		}
		
		public function get age():Number
		{
			return parseInt(fromObj(_data, "yt$age"));
		}
		
		public function get statistics():StatisticsData
		{
			return new StatisticsData(_data.yt$statistics);
		}
		
		public function get id():String
		{
			return fromObj(_data, "id");
		}
		
		public function get author():AuthorIterator
		{
			return new AuthorIterator(_data.author);
		}
		
		public function get categories():CategoryIterator
		{
			return new CategoryIterator(_data.category);
		}
		
		public function get firstname():String
		{
			return fromObj(_data, "yt$firstname");
		}
		
		public function get lastname():String
		{
			return fromObj(_data, "yt$lastname");
		}
		
		public function get title():String
		{
			return fromObj(_data, "title");
		}
		
		public function get updated():String
		{
			return fromObj(_data, "updated");
		}
		
		public function get gender():String
		{
			return fromObj(_data, "yt$gender");
		}
		
		public function get published():String
		{
			return fromObj(_data, "published");
		}
		
		public function get books():String
		{
			return fromObj(_data, "yt$books");
		}
		
		public function get company():String
		{
			return fromObj(_data, "yt$company");
		}
		
		public function get hobbies():String
		{
			return fromObj(_data, "yt$hobbies");
		}
		
		public function get hometown():String
		{
			return fromObj(_data, "yt$hometown");
		}		
		
		public function get movies():String
		{
			return fromObj(_data, "yt$movies");
		}
		
		public function get music():String
		{
			return fromObj(_data, "yt$music");
		}
		
		public function get occupation():String
		{
			return fromObj(_data, "yt$occupation");
		}
		
		public function get school():String
		{
			return fromObj(_data, "yt$school");
		}		
		
		public function get relationship():String
		{
			return fromObj(_data, "yt$relationship");
		}
		
		public function get thumbnail():String
		{
			return _data.media$thumbnail.url;			
		}
	}
}