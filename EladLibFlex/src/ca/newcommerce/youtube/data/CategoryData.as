/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	public class CategoryData extends AbstractData
	{
		protected var _data:Object;
		
		public function get scheme():String
		{
			var scheme:String = fromObj(_data, "scheme");
			if (scheme.indexOf("#") != -1)
				return scheme.substr(scheme.indexOf("#") + 1);
			else
				return scheme.substr(scheme.lastIndexOf("/") + 1, scheme.lastIndexOf(".") - (scheme.lastIndexOf("/") + 1));
		}
		
		public function get term():String
		{
			var term:String = fromObj(_data, "term");
			if (term.indexOf("#") != -1)
				return term.substr(term.lastIndexOf("#") +1);			
			else
				return term;
		}
		
		public function get label():String
		{
			return _data.label;
		}
		
		public function get text():String
		{
			return (_data.$t != "") ? _data.$t : ((_data.label != "") ? label : term);
		}
		
		public function CategoryData(data:Object)
		{
			_data = data;
		}
	}
}