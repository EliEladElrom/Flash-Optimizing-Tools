/* 
	
	////////////////////////////////////////////////////////////////////////////////
	//
	//  Elad Elrom (elad@elromdesign.com)
	//  Copyright 2008 Elorm LLC,
	//  All Rights Reserved.
	//
	//  NOTICE: Elad Elrom permits you to use, modify, and distribute this file
	//  in accordance with the terms of the license agreement accompanying it.
	//
	////////////////////////////////////////////////////////////////////////////////

 */

package com.elad.framework.objectpoolmanager
{
	
	/**
	 * 
	 * Class Reusable is usage to hold an object and a name.  It is used by the object pooling manager and the client.
	 * 
	 * @author Elad Elrom
	 * 
	 */	
	
	public class Reusable
	{
		
		/**
		 * Object can basically be anything, such as UI, class, array, XML etc... 
		 */		
		public var object:Object;
		
		/**
		 * The name of the Reusable item so it can be identify by the pooling manager. 
		 */		
		public var name:String;
		
		/**
		 * Defualt constractor, create new object. 
		 * 
		 */		
		public function Reusable(object:Object=null, name:String="")
		{
			this.object = object;
			this.name = name;
		}
	}
}