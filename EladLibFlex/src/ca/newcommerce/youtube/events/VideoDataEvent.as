/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import flash.events.Event;
	import ca.newcommerce.youtube.data.VideoData;

	public class VideoDataEvent extends Event
	{
		public static const VIDEO_INFO_RECEIVED:String = "video_info_received";		
		
		protected var _video:VideoData;
		protected var _requestId:Number;
		
		public function VideoDataEvent(type:String, requestId:Number, video:VideoData)
		{
			super(type);
			_video = video;
			_requestId = requestId;
		}
		
		public function get video():VideoData
		{
			return _video;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public override function toString():String
		{
			return "ca.newcommerce.youtube.events.VideoDataEvent";
		}
	}
}