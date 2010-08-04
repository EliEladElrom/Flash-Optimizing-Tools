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
	
	public class SubscriptionData extends AbstractData
	{
		protected var _data:Object;
		
		public static const FAVORITE_SUBSCRIPTION:String = "favorite";
		public static const CHANNEL_SUBSCRIPTION:String = "channel";
		public static const QUERY_SUBSCRIPTION:String = "query";
		public static const UNKNOWN_SUBSCRIPTION:String = "unknown";
		
		public function SubscriptionData(data:Object)
		{
			_data = data;
		}
		
		public function get type():String
		{
			var categories:CategoryIterator;
			var category:CategoryData;
			while (category = categories.next())
			{
				if (category.scheme == "subscriptiontypes")
				{
					if (category.term == FAVORITE_SUBSCRIPTION)
						return FAVORITE_SUBSCRIPTION;
					else if (category.term == CHANNEL_SUBSCRIPTION)
						return CHANNEL_SUBSCRIPTION;
					else if (category.term == QUERY_SUBSCRIPTION)
						return QUERY_SUBSCRIPTION;
				}
			}
			
			return UNKNOWN_SUBSCRIPTION;
		}
		
		public function get feedLink():FeedLinkData
		{
			return new FeedLinkData(_data.gd$feedLink);
		}
		
		public function get id():String
		{
			return fromObj(_data, "id");
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
		
		public function get username():String
		{
			return fromObj(_data, "yt$username");
		}
		
		public function get queryString():String
		{
			return fromObj(_data, "yt$queryString");
		}
		
		public function get updated():String
		{
			return fromObj(_data, "updated");
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