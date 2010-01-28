/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.feeds
{
	import ca.newcommerce.youtube.data.ContactData;	
	
	public class ContactFeed extends AbstractFeed
	{

		public function ContactFeed(rawData:String)
		{
			super(rawData);
		}
		
		public function getAt(pos:Number):ContactData
		{
			if (pos >= 0 && pos < count)
				return new ContactData(_entries[pos]);
			else 
				return null;
		}		
		
		public function first():ContactData
		{
			return getAt(_feedPointer = 0);
		}
		
		public function next():ContactData
		{
			return getAt(++_feedPointer);
		}
		
		public function previous():ContactData
		{
			return getAt(--_feedPointer);
		}
		
		public function last():ContactData
		{
			return getAt(_feedPointer = count - 1);
		}
	}	
}