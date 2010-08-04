/* 

////////////////////////////////////////////////////////////////////////////////
//
//  Elad Elrom (elad@elromdesign.com)
//  Copyright 2010 Elorm LLC,
//  All Rights Reserved.
//
//  NOTICE: Elad Elrom permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

*/
package com.elad.twitter.vo
{
	[Bindable]
	public final class TweetVO
	{
		public var from_user:String;
		public var from_user_id:int;
		public var geo:String;
		public var id:int;
		public var profile_image_url:String;
		public var source:String;
		public var text:String;
		public var to_user:String;
		public var to_user_id:int;		
		
		public function TweetVO(from_user:String, from_user_id:int, geo:String, id:int, profile_image_url:String, 
							source:String, text:String, to_user:String, to_user_id:int)
		{
			this.from_user = from_user;
			this.from_user_id = from_user_id;
			this.geo = geo;
			this.id = id;
			this.profile_image_url = profile_image_url;
			this.source = source;
			this.text = text;
			this.to_user = to_user;
			this.to_user_id = to_user_id;	
		}
	}
}