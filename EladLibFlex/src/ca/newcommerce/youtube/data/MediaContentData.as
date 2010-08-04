/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	public class MediaContentData
	{
		protected var _data:Object;
		
		public function MediaContentData(data:Object)
		{
			_data = data;
		}
		
		public function get expression():String
		{
			return _data.expression;
		}
		
		public function get duration():Number
		{
			return parseInt(_data.duration);
		}
		
		public function get isDefault():Boolean
		{
			return _data.isDefault == "true"
		}
		
		public function get type():String
		{
			return _data.type;
		}
		
		public function get format():Number
		{
			return parseInt(_data.yt$format);
		}
		
		public function get url():String
		{
			return _data.url;
		}
	}
}
