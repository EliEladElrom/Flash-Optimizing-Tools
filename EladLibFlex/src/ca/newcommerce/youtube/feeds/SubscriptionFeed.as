/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.feeds
{
	import ca.newcommerce.youtube.data.SubscriptionData;
	
	public class SubscriptionFeed extends AbstractFeed
	{		
		public function SubscriptionFeed(rawData:String)
		{
			super(rawData);
		}
		
		public function next():SubscriptionData
		{
			return getAt(++_feedPointer);
		}
		
		public function first():SubscriptionData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function last():SubscriptionData
		{
			return getAt(_feedPointer = count - 1);
		}
		
		public function getAt(pos:Number):SubscriptionData
		{
			if (count >= 0 && pos < count)
				return new SubscriptionData(_entries[pos]);
			else
				return null;
		}
	}
}