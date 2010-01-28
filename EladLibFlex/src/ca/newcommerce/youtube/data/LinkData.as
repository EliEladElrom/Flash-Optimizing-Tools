/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	public class LinkData extends AbstractData
	{
		protected var _data:Object;
		
		public function LinkData(data:Object)
		{
			_data = data;
		}
		
		public function get rel():String
		{
			var rel:String = fromObj(_data, "rel");
			if (rel.indexOf("#") != -1)
				return rel.substr(rel.lastIndexOf("#")+1);
			else
				return rel;
		}
		
		public function get type():String
		{
			return fromObj(_data, "type");			
		}
		
		public function get href():String
		{
			return fromObj(_data, "href");			
		}
	}
}