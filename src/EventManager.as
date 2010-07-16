package
{
	import com.utils.*;
	import game.*;
	
	public class EventManager
	{
		private static const DEBUG = false;
		private static var events:EventsHolder = null;
		
		public function EventManager()
		{
		}
		
		public static function Add(s, o, e, f) // swf, object, event, function
		{
			if(DEBUG)
			{
				trace("s", s);
				trace("o", o);
				trace("e", e);
				trace("f", f);
			}
			
			if(!events) events = new EventsHolder();
			
			var ed:EventDescriptor = new EventDescriptor();
			
			if(!events[s]) events[s] = new Array();
			
			ed.object = o;
			ed.event = e;
			ed._function = f;
			events[s].push(ed)
			
			o.addEventListener(e, f, false, 0, true);
		}
		
		public static function Remove(o, e, f)
		{
			o.removeEventListener(e, f);
		}
		
		public static function RemoveAllForSwf(s)
		{
			if(!events[s]) return;
			while(events[s].length)
			{
				var e:EventDescriptor = events[s].pop();
				if(e.object.hasEventListener(e.event)) e.object.removeEventListener(e.event, e._function);
			}
		}
	}
}

internal dynamic class GameData
{
	public function GameData()
	{
	}
}

internal dynamic class EventsHolder
{
	public function EventsHolder()
	{
	}
}

internal dynamic class EventDescriptor
{
	public function EventDescriptor()
	{
	}
}