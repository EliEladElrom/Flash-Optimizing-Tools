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
package com.elad.twitter
{
	import com.adobe.serialization.json.JSON;
	import com.elad.twitter.events.TwitterHelperFailureEvent;
	import com.elad.twitter.events.TwitterHelperSuccessEvent;
	import com.elad.twitter.events.TwitterHelperUserFailureEvent;
	import com.elad.twitter.events.TwitterHelperUserSuccessEvent;
	import com.elad.twitter.vo.TweetVO;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.Base64Encoder;
	import mx.utils.ObjectProxy;
    
	/**
	 *  Success custom event
	 * 
	 *  @eventType com.elad.twitter.TwitterHelperSuccessEvent.RETRIEVE_TWEETS
	 */
	[Event(name="retrieveTweets", type="com.elad.twitter.events.TwitterHelperSuccessEvent")]
	
	/**
	 *  Failure custome event
	 * 
	 *  @eventType com.elad.twitter.TwitterHelperFailureEvent.SERVICE_FAILURE
	 */
	[Event(name="serviceFailure", type="com.elad.twitter.events.TwitterHelperFailureEvent")]	

	/**
	 *  Login success custome event
	 * 
	 *  @eventType com.elad.twitter.TwitterHelperUserFailureEvent.RETRIEVE_USER_INFO_FAILURE
	 */
	[Event(name="retrieveUserInfoFailure", type="com.elad.twitter.events.TwitterHelperUserFailureEvent")]	
	
	/**
	 *  Login failure custome event
	 * 
	 *  @eventType com.elad.twitter.TwitterHelperUserSuccessEvent.RETRIEVE_USER_INFO_SUCCESS
	 */
	[Event(name="retrieveUserInfoSuccess", type="com.elad.twitter.events.TwitterHelperUserSuccessEvent")]	
	
	
	public class TwitterClient extends EventDispatcher
	{
		/**
		 * Holds the service class 
		 */		
		private var service:HTTPService;
		
		/**
		 *  Holds user's information 
		 */		
		private var user:ObjectProxy;
		
		/**
		 * Holds the constants with the URLs 
		 */		
		public static const SEARCH_URL:String = "http://search.twitter.com/search.json";
		public static const VERIFY_CREDENTIALS_URL:String = "http://twitter.com/account/verify_credentials.xml";
		public static const STATUS_URL:String = "http://twitter.com/statuses/update.xml"
		 
		//--------------------------------------------------------------------------
		//
		//  Default Constructor
		//
		//--------------------------------------------------------------------------
		public function TwitterClient() 
		{
			// implement
		}
		  
	   /**
	    * Method to send a request to retrieve all the tweet with a HashTag
	    * @param hashTag defined hashtag to search
		* @url	the twitter API url 
	    * 
	    */		  
	   public function retrieveTweetsBasedOnHashTag( hashTag:String, url:String = SEARCH_URL ):void
	   {
		   service = new HTTPService();
		   service.url = url;
		   service.resultFormat = "text";
		   
		   service.addEventListener(ResultEvent.RESULT, onTweetResultsHandler);
		   service.addEventListener(FaultEvent.FAULT, onTweetsFaultHandler);
		   
		   var object:Object = new Object();
		   object.q = hashTag;
		   service.send( object );
	   }
	   
	   public function retrieveRetrieveUserInformation( username:String, password:String, url:String = VERIFY_CREDENTIALS_URL ):void
	   {
		   service = new HTTPService();
		   service.url = url;
		   service.method = "GET";
		   
		   service.addEventListener( FaultEvent.FAULT, onRetrieveUserTweetsFaultHandler );
		   service.addEventListener( ResultEvent.RESULT, onRetrieveUserResultsHandler );
		   
		   var encoder:Base64Encoder = new Base64Encoder();
		   encoder.encode(username+":"+password);
		   
		   service.headers = {Authorization:"Basic " + encoder.toString()};
		   service.send();
	   }
	   
	   public function updateStatus( status:String, url:String = STATUS_URL ):void
	   {
		   service = new HTTPService();
		   service.url = url;
		   service.method = "POST";
		   service.resultFormat = "text";
		   
		   service.addEventListener( FaultEvent.FAULT, onUpdateTweetsFaultHandler );
		   service.addEventListener( ResultEvent.RESULT, onUpdateResultsHandler );
		   
		   var object:Object = new Object();
		   object.status = status;
		   service.send( object );
	   }	   
	   
	   //--------------------------------------------------------------------------
	   //
	   //  Event handlers
	   //
	   //--------------------------------------------------------------------------

	   /**
		* Method to handle the result event 
		* 
		* @param event
		* 
		*/	   
	   private function onUpdateTweetsFaultHandler(event:FaultEvent):void
	   {
		   service.removeEventListener( FaultEvent.FAULT, onUpdateTweetsFaultHandler );
		   service.removeEventListener( ResultEvent.RESULT, onUpdateResultsHandler );
	   }
	   
	   /**
		* Method to handle the fault event 
		* 
		* @param event
		* 
		*/	   
	   private function onUpdateResultsHandler(event:ResultEvent):void
	   {
		   service.removeEventListener( FaultEvent.FAULT, onUpdateTweetsFaultHandler );
		   service.removeEventListener( ResultEvent.RESULT, onUpdateResultsHandler );
	   }	   
	   
	   
	   /**
	    * Method to handle the result event of verifing user's information 
		 * 
	    * @param event
	    * 
	    */	   
	   private function onRetrieveUserResultsHandler(event:ResultEvent):void
	   {
		   service.removeEventListener( FaultEvent.FAULT, onRetrieveUserTweetsFaultHandler );
		   service.removeEventListener( ResultEvent.RESULT, onRetrieveUserResultsHandler );
		   
		   user = event.result.user;
		   this.dispatchEvent( new TwitterHelperUserSuccessEvent(user) );
	   }
	   
	   /**
	    * Method to handle the fault event of verifing user's information 
		 * 
	    * @param event
	    * 
	    */	   
	   private function onRetrieveUserTweetsFaultHandler(event:FaultEvent):void
	   {
		   service.removeEventListener( FaultEvent.FAULT, onRetrieveUserTweetsFaultHandler );
		   service.removeEventListener( ResultEvent.RESULT, onRetrieveUserResultsHandler );
		   
		   this.dispatchEvent( new TwitterHelperUserFailureEvent( event.fault.message ) );
	   }
	   
	   /**
	    * Method to handle the result of a request to retrieve all the list 
	    * @param event
	    * 
	    */
	   private function onTweetResultsHandler(event:ResultEvent):void
	   {
		   service.removeEventListener(ResultEvent.RESULT, onTweetResultsHandler);
		   service.removeEventListener(FaultEvent.FAULT, onTweetsFaultHandler);
		   
		   var rawData:String = String( event.result );
		   var object:Object = JSON.decode( rawData );
		   var results:Array = object.results as Array;
		   var collection:Vector.<TweetVO> = new Vector.<TweetVO>;
		   
		   results.forEach( function callback(item:*, index:int, array:Array):void {
			   var tweet:TweetVO = new TweetVO( item.from_user, item.from_user_id, item.geo, item.id, 
				   item.profile_image_url, item.source, item.text, item.to_user, item.to_user_id );
			   
			   collection.push( tweet );
		   });
		   
		   // dispatch an event that holds the results
		   this.dispatchEvent( new TwitterHelperSuccessEvent( collection ) );
	   }
	   
	   /**
	    * Holds the fault method in case the service failed 
		 *  
	    * @param event
	    * 
	    */	   
	   private function onTweetsFaultHandler(event:FaultEvent):void
	   {
		   service.removeEventListener(ResultEvent.RESULT, onTweetResultsHandler);
		   service.removeEventListener(FaultEvent.FAULT, onTweetsFaultHandler);
		   
		   this.dispatchEvent( new TwitterHelperFailureEvent( event.fault.message ) );
	   }   
	}
}