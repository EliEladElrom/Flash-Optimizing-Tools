/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.iterators
{
	import ca.newcommerce.youtube.data.CategoryData;
	
	public class CategoryIterator
	{
		protected var _data:Array;
		protected var _feedPointer:Number = -1;
		
		public function CategoryIterator(data:Array)
		{
			_data = data;
		}
		
		public function get count():Number
		{
			return _data.length;
		}
		
		public function getAt(pos:Number):CategoryData
		{
			if (pos >= 0 && pos < count)
				return new CategoryData(_data[pos]);
			else 
				return null;
		}
		
		public function next():CategoryData
		{
			return getAt(++_feedPointer);
		}
		
		public function previous():CategoryData
		{
			return getAt(--_feedPointer);
		}
		
		public function first():CategoryData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function last():CategoryData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function get keywords():Array
		{
			var lastPointer:Number = _feedPointer;
			_feedPointer = -1;
			
			var keywords:Array = [];
			var category:CategoryData;			
			
			while (category = next())
			{
				if (category.scheme == "keywords")
					keywords.push(category.term);
			}
			
			_feedPointer = lastPointer;
			
			return keywords;
		}
		
		public function get categorywords():Array
		{
			var lastPointer:Number = _feedPointer;
			_feedPointer = -1;
			
			var catwords:Array = [];
			var category:CategoryData;			
			
			while (category = next())
			{
				if (category.scheme == "categories")
					catwords.push(category.label);
			}
			
			_feedPointer = lastPointer;
			
			return catwords;
		}
	}
}