/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	import ca.newcommerce.youtube.iterators.CategoryIterator;
	import ca.newcommerce.youtube.iterators.LinkIterator;

	public class ContactData extends AbstractData 
	{
		protected var _data:Object;
		
		public function ContactData(data:Object)
		{
			_data = data;
		}
		
		public function get id():String
		{
			return fromObj(_data, "id");
		}
		
		public function get title():String
		{
			return fromObj(_data, "title");
		}
		
		public function get categories():CategoryIterator
		{
			return new CategoryIterator(_data.category);
		}
		
		public function get status():String
		{
			return fromObj(_data, "yt$status");
		}
		
		public function get username():String
		{
			return fromObj(_data, "yt$username");
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