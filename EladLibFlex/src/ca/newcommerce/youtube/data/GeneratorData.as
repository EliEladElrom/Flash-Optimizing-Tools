/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	public class GeneratorData 
	{
		protected var _data:Object;
		
		public function GeneratorData(data:Object)
		{
			_data = data;			
		}
		
		public function get text():String
		{
			return _data.$t;
		}
		
		public function get uri():String
		{
			return _data.uri;
		}
		
		public function get version():String
		{
			return _data.version;
		}
	}
}
