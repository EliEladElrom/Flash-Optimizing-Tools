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

package com.elad.optimize.collections
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
	
	/**
	 *  Dispatched when the <code>HashMapCollection</code> has been updated in some way.
	 *
	 *  @eventType mx.events.CollectionEvent.COLLECTION_CHANGE
	 */
	[Event(name="collectionChange", type="mx.events.CollectionEvent")]
	
    
    /**
     * 
     * Hash table based implementation of the <code>IMap</code> interface. 
     * <code>HashMapCollection</code> class makes no guarantees to the order of the map or that the order 
     * will remain the same.  The class let you pass a pair of keys and values and
     * provides constant-time performance for the basic operations of 
     * <code>addItem</code>, <code>removeItemAt</code> and <code>getItemValue</code>
     * since they require no iteration over the collection.
     * 
     * <p>
     * Example shows how to use the <code>HashMapCollection</code>
     * </p>
     *
     * @example
     * <listing version="3.0">
     * 
	 *		private function map():void {
	 *			
	 *			var map:IMap = new HashMapCollection();
	 *			map.addEventListener(CollectionEvent.COLLECTION_CHANGE, handler);
	 *			
	 *			map.addItem("John", "212-452-8086");
	 *			map.addItem("James", "718-345-3455");
	 *			map.addItem("Micheal", "917-782-8822");
	 *			map.addItem("Ron", "212-426-8855");
	 *			map.addItem("Mike", "212-255-2436");
	 *			map.addItem("Jenny", "718-344-2433");
	 *			map.addItem("Jack", "917-222-4352");
	 *			map.addItem("Riki", "981-222-1122");
	 *			trace("\nAll items: "+map.toString()+"\n");
	 *			
	 *			trace("containsKey Jack? "+map.containsKey("Jack"));
	 *			trace("containsValue 718-344-2433? "+map.containsValue("718-344-2433"));
	 *			trace("getItemKey 718-344-2433: "+map.getItemKey("718-344-2433"));
	 *			trace("getItemValue Jenny: "+map.getItemValue("Jenny"));
	 *			
	 *			map.removeItemAt("Riki");
	 *			trace("Remove Riki.");
	 *			trace("getItemValue Riki: "+map.getItemValue("Riki"));				
	 *			trace("Comapre: "+map.compare("Ron", "212-426-8855"));
	 *			
	 *			map.removeAll();
	 *			trace("\nAll items: "+map.toString()+"\n");
	 *			
	 *		}
	 *		
	 *		private function handler(event:CollectionEvent):void 
	 *		{
	 *			trace("Event: "+event.kind);
	 *		}
	 *  
     * </listing>
     * 
     * @see mx.events.CollectionEvent
     * @see com.elad.framework.utils.collections
     * @see flash.events.IEventDispatcher
     * @see flash.utils.Dictionary
     *
     */
    public class HashMapCollection implements IMap
    {
    	
	    /**
	     *  @private
	     *  Internal event dispatcher.
	     */
	    private var eventDispatcher:EventDispatcher;
        	
        /**
         * The Dictionary class is the base for the Hashtable, it allows to maps keys to value by 
         * creating a dynamic collection of properties.
         *  
         * @see flash.utils.Dictionary
         * 
         */
        private var map:Dictionary;
        
        /**
         * Defualt constractor create the <code>Dictionary</code> and set the event dispatcher.
         * 
         * @param useWeakReferences Instructs the Dictionary object to use "weak" references on object keys. 
         * 
         * @see flash.utils.Dictionary
         * 
         */
        public function HashMapCollection(useWeakReferences:Boolean = true)
        {
            map = new Dictionary( useWeakReferences );
            eventDispatcher = new EventDispatcher(this);
        }

        /**
         * Add a pair consists of key and value.
         * 
         */
        public function addItem(key:*, value:*) : void
        {
            map[key] = value;
			triggerDispatchEvent(new Array({key: key, value: value}) , CollectionEventKind.ADD);           
                            
        }

        /**
         * Remove the value based on the key without the need to iteration.
         * The method also call an event dispatcher.
         */
        public function removeItemAt(key:*) : void
        {   
			triggerDispatchEvent(new Array({key: key, value: map[key]}) , CollectionEventKind.REMOVE);
           	delete map[key];	                    
        }

        /**
         * Method to check if a key exists in the map collection.
         */
        public function containsKey(key:*):Boolean
        {
            return map[key] != null;
        }

        /**
         * Method to check if a value exist in the map colletcion.
         */
        public function containsValue(value:*) : Boolean
        {
            var result:Boolean;

            for ( var key:* in map )
            {
                if (map[key] == value)
                {
                    result = true;
                    break;
                }
            }
            return result;
        }

        /**
         * Method to retrieve the list of keys avaliable in the map.
         * 
         * @return	An array collection with the keys. 
         * 
         */
        public function getKeys():Array
        {
            var keys:Array = [];

            for (var key:* in map)
            {
                keys.push( key );
            }
            return keys;
        }

        /**
         * Retrieve an item key based on a value.
         * 
         * @param value
         * @return 
         * 
         */        
        public function getItemKey(value:*):String
        {
            var keyName:String = null;
            
            for (var key:* in map)
            {
                if (map[key] == value) 
                { 
                	keyName = key;
                	break; 
                }
            }
            
            return keyName; 	
        }

        /**
         * Retrieve item value based on the item key.
         * 
         * @param key
         * @return 
         * 
         */
        public function getItemValue(key:*):*
        {
            return map[key];
        }

        /**
         * Method to retrieve all the items values in the collection.
         * 
         * @return An array collection with all the values.
         * 
         */
        public function getItemsValues():Array
        {
            var values:Array = new Array();

            for (var key:* in map)
            {
                values.push(map[key]);
            }
            return values;
        }

        /**
         * Will result in the length of the map collection.
         * 
         * @return Size of collection. 
         * 
         */
        public function get length():int
        {
            var length:int = 0;

            for (var key:* in map)
            {
                length++;
            }
            return length;
        }

        /**
         * Check if the collection has pairs of values and keys or empty
         * @return true|false
         * 
         */
        public function get isEmpty():Boolean
        {
            return length <= 0;
        }

        /**
         * Method to clear the values of the collection. Keys will stays but values will be removed.
         * 
         */
        public function reset():void
        {
            for (var key:* in map)
            {
                map[key] = null;
            }

			triggerDispatchEvent(new Array() , CollectionEventKind.RESET);          
        }

        /**
         * Remove the entire pairs in the collection. 
         * 
         */
        public function removeAll():void
        {
            for (var key:* in map)
            {
                removeItemAt(key);
            }

			triggerDispatchEvent(new Array() , CollectionEventKind.REMOVE);            
        }
        
        /**
         * Clone the map, the keys and values themselves are not cloned.
         *  
         * @return	Returns a shallow copy of this HashMap instance
         * 
         */        
        public function clone():Object
        {
        	var cloneMap:IMap = this;
        	cloneMap.removeAll();
        	return cloneMap;
        }
		
		/**
		 * Returns an array collection of the keys contained in this map.
		 * 
		 * @return Returns an array view of the keys contained in this map.
		 * 
		 */		
		public function get keySet():Array
		{
            var keys:Array = [];

            for (var key:* in map)
            {
                keys.push( key );
            }
            return keys;
		}
		
		/**
		 * Copies all of the mappings from the specified map to this map 
		 * These mappings will replace any mappings that this map had for any of the keys currently in the specified map.
		 *  
		 * @param m	a HashMap collection containing keys and values.
		 * 
		 */		
		public function set addAll(m:HashMapCollection):void
		{
			for (var key:* in map)
			{
				if (map[key] != null)
				{
					delete map[key];
				}
			}
			
			for (key in m)
			{
				map[key] = m.getItemValue(key);
			}
			
			triggerDispatchEvent(new Array("AddAll") , CollectionEventKind.ADD);			
		}
		
		/**
		 * Compare specified key with the map value for equality.
		 */		
		public function compare(key:*, value:*):Boolean
		{			
			var result:Boolean = (map[key] == value) ? true : false
			return result;
		}
		
		/**
		 * Method to convert the map into a string representation consists of a list of key-value. 
		 *  
		 * @return Returns a string representation of this map. The string representation consists of a list of key-value. 
		 * 
		 */		
		public function toString():String
		{
            var string:String = "";
            
            for (var key:* in map)
            {
            	string = string + "key: " + key + ", value: " + map[key].toString()+"\n";
            }
            			
			return string;
		}
		
		/**
		 * Method to dispatch the event. This method will be called every time there is any change
		 * in the collection. 
		 * 
		 * @param array	Pairs that are being changed.
		 * @param eventKind	Event kind that got initiated
		 * 
		 */		
		private function triggerDispatchEvent(array:Array, eventKind:String):void
		{
			// dispatch Event
	        var event:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
	        event.kind = eventKind;
	        event.items = array;
	        this.dispatchEvent(event);				
		}

	    //--------------------------------------------------------------------------
	    //
	    // Methods needed for the extention of IEventDispatcher
	    //
	    //--------------------------------------------------------------------------
    
	    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
	    {
	        eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
	    }
	    
	    public function dispatchEvent(event:Event):Boolean
	    {
	        return eventDispatcher.dispatchEvent(event);
	    }
	    
	    public function hasEventListener(type:String):Boolean
	    {
	        return eventDispatcher.hasEventListener(type);
	    }    
	    
	    public function willTrigger(type:String):Boolean
	    {
	        return eventDispatcher.willTrigger(type);
	    }
	    
	    public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
	    {
	        eventDispatcher.removeEventListener(type, listener, useCapture);
	    }
    }
}
