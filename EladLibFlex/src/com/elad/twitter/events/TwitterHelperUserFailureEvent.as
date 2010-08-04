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
	import flash.events.Event;
	
	public class TwitterHelperUserFailureEvent extends Event
	{
		public static const RETRIEVE_USER_INFO_FAILURE:String = "retrieveUserInfoFailure";
		
		public var message:String;
		
		public function TwitterHelperUserFailureEvent( message:String )
		{
			this.message = message;
			super( RETRIEVE_USER_INFO_FAILURE );
		}
	}
}