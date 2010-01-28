/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{	
	public class RatingData
	{
		protected var _data:Object;
		
		public function RatingData(data:Object)
		{
			_data = data;
		}
		
		public function get min():Number
		{
			return parseInt(_data.min);
		}
		
		public function get max():Number
		{
			return parseInt(_data.max);
		}
		
		public function get numRaters():Number
		{
			return parseInt(_data.numRaters);
		}
		
		public function get average():Number
		{
			return parseInt(_data.average);
		}
	}
}
