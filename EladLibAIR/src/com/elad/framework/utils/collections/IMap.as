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

package com.elad.framework.utils.collections
{
    
	import flash.events.IEventDispatcher;
	import mx.events.CollectionEvent;
	
	/**
	 *  Dispatched when the Map has been updated in some way.
	 *
	 *  @eventType mx.events.CollectionEvent.COLLECTION_CHANGE
	 */
	[Event(name="collectionChange", type="mx.events.CollectionEvent")]
	
    /**
     * <code>IMap</code> is the contract for the <code>HashMapCollection</code>. The class extentiate the 
     * <code>IEventDispatcher</code> interface to insure the creating of all the classes to dispach change events.
     * 
     */
    public interface IMap extends IEventDispatcher
    {
        /**
         * Add a pair to the collection.
         * 
         * @param Map key.
         * @param Map value
         * 
         */
        function addItem(key:*, value:*):void;
        
        /**
         * Remove an item based on key. 
         * 
         * @param key	The collection key.
         * 
         */
        function removeItemAt(key:*):void;

        /**
         * Check if the collection contains a key.
         * 
         * @param key	collection key.
         * @return	true|false
         * 
         */
        function containsKey(key:*):Boolean;

        /**
         * Check if collection contain value. 
         * @param value	value from any type.
         * @return	true|false
         * 
         */
        function containsValue(value:*):Boolean;

        /**
         * Return the item key based on it's value.
         *  
         * @param value	The item value.
         * @return	The item Key.
         * 
         */
        function getItemKey(value:*):String;

        /**
         * Retrieve an item value based on its key.
         *  
         * @param key	Key can be any type. Usually string.
         * @return	The value.
         * 
         */
        function getItemValue(key:*):*

        /**
         * Method to retrieve the values. 
         * @return An array with all the values in the map.
         * 
         */
        function getItemsValues():Array;
        
        /**
         * Method to check the size of the HashMap Collection.
         *  
         * @return	Size of the collection. 
         * 
         */
        function get length():int;


        function get isEmpty():Boolean;
        

        function reset():void;   
                

        function removeAll():void; 

        /**
         * Clone the map, the keys and values themselves are not cloned.
         *  
         * @return	Returns a shallow copy.
         * 
         */        
        function clone():Object;
		
		/**
		 * Returns an array collection of the keys contained in this map.
		 * 
		 * @return Returns an array view of the keys contained in this map.
		 * 
		 */		
		function get keySet():Array
		
		/**
		 * Copies all of the mappings from the specified map to this map 
		 * These mappings will be replace for any mappings that this map had 
		 * for the keys currently in the specified map.
		 *  
		 * @param m	a HashMap collection containing keys and values.
		 * 
		 */		
		function set addAll(m:HashMapCollection):void
		
		/**
		 * Compare specified key with the map value for equality. 
		 */		
		function compare(key:*, value:*):Boolean
		
		/**
		 * Method to convert the map into a string representation consists of a list of key-value. 
		 *  
		 * @return Returns a string representation of this map. The string representation consists of a list of key-value. 
		 * 
		 */		
		function toString():String   
    }
}
