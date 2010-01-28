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
	import com.elad.framework.utils.collections.HashMapCollection;

	/**
	 * ReusablePool is a singleton objecet that holds
	 * an instances of classes and it's role is to manage Reusable objects 
	 * that will be used by the Client.
	 * 
	 * <p>
	 * The object pooling can boost performance; especially in cases where the resources used to initializing
	 *  a class instance are high, the number of times the class will be usage is often, 
	 * and the number of instantiations in use at any single time is low.
	 * </p>
	 * 
     * @example
     * <listing version="3.0">
     * 
	 * var reusable:Reusable = new Reusable();
	 * reusable.name = "FlexImage";
	 * reusable.object = new UIComponent();
	 * reusablePool.setReusable(reusable);
	 * 
     * </listing>
	 * 
	 */	
	
	public class ReusablePool
	{
		/**
		 * ReusablePool to be used by the singleton pattern.   
		 */		
		private static var reusablePool : ReusablePool;
		
		/**
		 *  Temporary place holder for a reusable object.
		 */		
		protected static var reusable:Reusable = new Reusable();
		
		/**
		 * the collection that hold the pool of reusable objects.
		 */		
		private static var collection:HashMapCollection = new HashMapCollection();
		
		/**
		 * The maximum amount of reusable objects allowed in the collection, defualt is 1000 
		 */		
		private static var maxPoolSize:int=1000;

		/**
		 * 
		 * Class acquireReusable is called when it client need a Reusable object
		 * The reusable object is cleared until the client return the object
		 * back to the pool via the releaseReusable method.
		 * 
		 * @param name	The name of the reusable object.
		 * @return	Reusable class which holds the name and the object.
		 * 
		 */	
		public function acquireReusable(name:String):Reusable
		{
			var index:int = -1;
			var len:int = collection.length;
			
			for (var i:int; i<len; i++)
			{
				if ( collection.containsKey(name) )
				{
					index = i;
					break;
				}
			}
			
			if (index == -1)
				throw new Error("No Reusable object exists with name: "+name);
									
			
			reusable.object = collection.getItemValue(name);
			reusable.name = name;
			collection.removeItemAt(name);
			return reusable;	
		}
		
		/**
		 * Check weather or not the reusable object exists
		 *  
		 * @param name
		 * @return 
		 * 
		 */		
		public function isReusableExists(name:String):Boolean
		{
			return collection.containsKey(name);
		}

		/**
		 * Method to add an object to the collection the collection, as long as the collection size is smaller than the max allowed pool.
		 *  
		 * @param reusable	type Reusable which holds the name and the object.
		 * 
		 */	
		public function setReusable(reusable:Reusable):void
		{
			if (collection.length < maxPoolSize)
				collection.addItem( reusable.name, reusable.object );
			else
				throw new Error("Pool size is too big, please change the size of the pool or reduce the collection.");	
		}		

		/**
		 * 
		 * Method will be used to release Reusable collection once the client finished using it.
		 * 
		 * @param releasedReusable	type Reusable class and holds the name and object to be returned to the collection.
		 * 
		 */		
		public function releaseReusable(releasedReusable:Reusable):void
		{
			collection.addItem(releasedReusable.name, releasedReusable.object);
		}

		/**
		 * Method to set the size of the collection. If the collection reaches the max allowed object the class will return an error message.
		 *  
		 * @param size	The size of the collection.
		 * 
		 */		
		public function setMaxPoolSize(size:Number):void
		{
			maxPoolSize = size;
		}	
		
		/**
		 * Method function to retrieve instance of object ReusablePool
		 * 
		 * @return ReusablePool Instance
		 * 
		 */
		public static function getInstance() : ReusablePool
		{
			if( reusablePool == null )
			{
				reusablePool = new ReusablePool(new AccessRestriction());
			}
			
			return reusablePool;
		}
	
		/**
		 * Internal constructor. Should not be called from outside this class. 
		 * 
		 * @param enforcer	Object accessible to just this class to enforce
		 * 					singleton pattern. 
		 * 
		 */
		public function ReusablePool(enforcer:AccessRestriction):void
		{
			// TODO: throw exception
			if ( enforcer == null )
			{
				throw new Error("ReusablePool error enforcer input param is undefined" );
			}
		}
	}
}

class AccessRestriction {}