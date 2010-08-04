/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	public class ThumbnailData
	{
		
		protected var _data:Object;
		
		public function ThumbnailData(data:Object)
		{
			_data = data;
		}
		
		public function get time():String
		{
			// TODO: make this seconds..
			return _data.time;
		}
		
		public function get height():Number
		{
			return parseInt(_data.height);
		}
		
		public function get width():Number
		{
			return parseInt(_data.width);
		}
		
		public function get url():String
		{
			return _data.url;
		}
	}
}