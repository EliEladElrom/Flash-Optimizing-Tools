/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */
package com.elad.youtube.vo
{
	[Bindable]
	public class YouTubeVideoVO
	{
		public var title:String;
		public var description:String;
		public var thumb:String;
		public var videoId:String;
		public var viewed:String;
		public var isAvaliableOffline:Boolean = false;
		public var videoURL:String;
		

		public function YouTubeVideoVO(title:String="", description:String="", thumb:String="", videoId:String="", viewed:String="", videoURL:String="", isAvaliableOffline:Boolean=false) 
		{
			this.title = title;
			this.description = description;
			this.thumb = thumb;
			this.videoId= videoId;
			this.viewed = viewed;
			this.videoURL = videoURL;
			this.isAvaliableOffline = isAvaliableOffline;
		}
	}
}