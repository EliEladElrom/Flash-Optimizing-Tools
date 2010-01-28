/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.feeds
{
	import ca.newcommerce.youtube.data.AbstractData;
	import com.adobe.serialization.json.JSON;
	import ca.newcommerce.youtube.iterators.LinkIterator;
	import ca.newcommerce.youtube.iterators.AuthorIterator;
	import ca.newcommerce.youtube.iterators.CategoryIterator;
	import ca.newcommerce.youtube.data.GeneratorData;
	
	
	public class AbstractFeed extends AbstractData
	{
		protected var _entries:Array;
		protected var _data:Object;		
		protected var _feedPointer:Number = -1;
		
		public function AbstractFeed(data:String)
		{
			_data = JSON.decode(data).feed;
			_entries = _data.entry;
		}		
		
		public function get count():Number
		{
			return _entries.length;
		}		
		
		public function get logo():String
		{
			return fromObj(_data, "logo");
		}
		
		public function get links():LinkIterator
		{
			return new LinkIterator(_data.link);
		}
		
		public function get totalResults():Number
		{
			return parseInt(fromObj(_data, "openSearch$totalResults"));
		}
		
		public function get startIndex():Number
		{
			return parseInt(fromObj(_data, "openSearch$startIndex"));
		}
		
		public function get itemsPerPage():Number
		{
			return parseInt(fromObj(_data, "openSearch$itemsPerPage"));
		}		
		
		public function get id():String
		{
			return fromObj(_data, "id");
		}
		
		public function get authors():AuthorIterator
		{
			return new AuthorIterator(_data.author);
		}
		
		public function get categories():CategoryIterator
		{
			return new CategoryIterator(_data.category);
		}
		
		public function get title():String
		{
			return fromObj(_data, "title");
		}
		
		public function get updated():String
		{
			return fromObj(_data, "updated");
		}
		
		public function get generator():GeneratorData
		{
			return new GeneratorData(_data.generator);
		}		
	}	
}