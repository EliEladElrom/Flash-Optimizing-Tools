/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	public class FeedLinkData extends AbstractData
	{
		protected var _data:Object;
		
		public function FeedLinkData(data:Object)
		{
			_data = data;
		}
		
		public function get countHint():Number
		{
			return parseInt(fromObj(_data, "countHint"));
		}
		
		public function get rel():String
		{
			var rel:String = fromObj(_data, "rel");
			if (rel.indexOf("#") != -1)
				return rel.substr(rel.lastIndexOf("#")+1);
			else
				return rel;
		}		
		
		public function get href():String
		{
			return fromObj(_data, "href");			
		}
	}
}
