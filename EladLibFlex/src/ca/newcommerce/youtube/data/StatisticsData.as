/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.data
{
	public class StatisticsData extends AbstractData
	{
		protected var _data:Object;
		
		public function StatisticsData(data:Object)
		{
			_data = data;
		}
		
		public function get videoWatchCount():Number
		{
			return parseInt(_data.videoWatchCount);
		}
		
		public function get lastWebAccess():String
		{
			return _data.lastWebAccess;
		}
		
		public function get viewCount():Number
		{
			return parseInt(_data.viewCount);
		}
	}
}