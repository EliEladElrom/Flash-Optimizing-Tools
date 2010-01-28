/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.notes
{
	import com.adobe.xml.syndication.Namespaces;

	public class XmlNotes
	{
		protected var yt:Namespace = Namespaces.YOUTUBE_NS;
		protected var media:Namespace = Namespaces.MEDIA_NS;
		
		public function XmlNotes()
		{
		
		}
	
		//parses RSS 2.0 feed and prints out the feed titles into
		//the text area
		protected function parseRSS(data:String):void
		{
			//XMLSyndicationLibrary does not validate that the data contains valid
			//XML, so you need to validate that the data is valid XML.
			//We use the XMLUtil.isValidXML API from the corelib library.
			if(!XMLUtil.isValidXML(data))
			{
				trace("Feed does not contain valid XML.");
				return;
			}	

			//create RSS20 instance
			var rss:RSS20 = new RSS20();
			var lclAtom:Atom10 = new Atom10();
			
			lclAtom.parse(data);
			
			//trace("lclAtom.entries:" + lclAtom.entries);
			
			var entry:Entry = lclAtom.entries[0];
			//trace("entry:" + entry.title);			
			var category:Category = entry.categories[0];
			//trace("category.term:" + category.term);
			//trace("category.label:" + category.label);
			//trace("");
			//trace("entry.xml:" + entry.xml);
			//trace("");
			
			var i:String;
			//trace("entry.xml.children():" + entry.xml.children);
			//trace("entry.xml.toString():" + entry.xml.toString());
			//trace("entry.xml.id.text():" + entry.xml.id);
			//trace("entry.xml.title.text():" + entry.xml.atom::title);
			
			//trace("entry.xml.media:title.text():" + entry.xml.media::group.title);
			
			
			var mediaGroup:XMLList = entry.xml.media::group;
			trace("mediaGroup.title:" + mediaGroup.media::title);
			trace("mediaGroup.duration:" + mediaGroup.yt::duration.@seconds);
			trace("mediaGroup.thumbnail[0].url:" + mediaGroup.media::thumbnail[0].@url);
			trace("mediaGroup.thumbnail[1].url:" + mediaGroup.media::thumbnail[1].@url);
			
			
			//trace("entry.xml..*:group:" + entry.xml.media::group);
			for each (i in entry.xml.children())
			{
				//trace("["+i+"] :" + entry.xml[i]);
			}

			//parse the raw rss data
			rss.parse(data);
			
			//trace("data parsed");

			//get all of the items within the feed
			var items:Array = rss.items;
			
			//trace("items:" + items);
			

			//loop through each item in the feed
			for each(var item:Item20 in items)
			{
				//print out the title of each item
				//trace("item title:"+item.title);
			}
		}
	}
}