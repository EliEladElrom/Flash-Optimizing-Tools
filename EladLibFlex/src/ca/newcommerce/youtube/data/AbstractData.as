/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{

	public class AbstractData
	{
		
		public function AbstractData()
		{
			
		}
		
		protected function fromObj(data:Object, index:String):String
		{
			if (data[index] == null)
				return "";
				
			if (data[index] as String != null)
				return data[index];
			else
				return data[index].$t;
		}
	}
	
}
