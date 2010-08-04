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
package com.elad.twitter.events
{
	import com.elad.twitter.vo.TweetVO;
	
	import flash.events.Event;
	
	public class TwitterHelperSuccessEvent extends Event
	{
		public static const RETRIEVE_TWEETS:String = "retrieveTweets";
		
		public var collection:Vector.<TweetVO>;
		
		public function TwitterHelperSuccessEvent( collection:Vector.<TweetVO> )
		{
			this.collection = collection;
			super( RETRIEVE_TWEETS );
		}
	}
}