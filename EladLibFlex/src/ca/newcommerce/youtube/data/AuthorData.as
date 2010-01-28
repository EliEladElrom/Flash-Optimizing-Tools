/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	public class AuthorData extends AbstractData
	{
		protected var _data:Object;
		
		public function AuthorData(data:Object)
		{
			_data = data;
		}
		
		public function get name():String
		{
			return fromObj(_data, "name");
		}
		
		public function get uri():String
		{
			return fromObj(_data, "uri");			
		}
		
		public function get username():String
		{
			var lclUri:String = uri;
			return lclUri.substr(lclUri.lastIndexOf("/") + 1);
		}
	}
}
