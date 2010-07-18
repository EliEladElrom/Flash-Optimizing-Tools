/*
Copyright (c) 2009 Elad Elrom.  Elrom LLC. All rights reserved. 

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

@author  Elad Elrom
*/
package com.elad.optimize.memory
{
	import flash.events.IEventDispatcher;

	/**
	 * 
	 * <p>Easy way to store event listener references and prevent memory leaks - 
	 * Many times when we find memory leaks in our applications, it/'s due to listeners that have been set 
	 * by us or someone else and never removed from memory.   Although it/'s recommended to use weak reference 
	 * when setting event listeners, the fact that we have to put these three extra parameters often cause 
	 * developers not to set them.
	 * 
	 * The only problem is that the array is set to private in EventDispatcher class, which prevents us from cleaning 
	 * an object from it/'s listeners.
	 * 
	 * The idea is to make it simple enough and lightweight so that it will be useful without the need to write any code
	 * to create the class or initialize a collection object (such as Array or a Dictionary).   
	 * 
	 * Also this class doesn/'t have to be used at all times, but be there when you need it 
	 * and when you have cases where you suspect you/'re dealing with a memory leak that is 
	 * related to an event listener that hasn/'t been removed.
	 * 
	 * Although it/'s unconventional I set the class name as lower case on purpose, 
	 * so when you implement it will appear as if it/'s part of your class when using the API.</p> 
	 * 
	 * @Example	Here is an example off adding listeners and removing them
	 * 
	 * <listing version="3.0">
	 * 		var movieClip:MovieClip = new MovieClip();
	 * 		movieClip.addEventListener( listeners.type = MouseEvent.CLICK, listeners.handler = onClick );
	 *		 movieClip.addEventListener( listeners.type = MouseEvent.DOUBLE_CLICK, listeners.handler = onDoubleClick );
	 * 		listeners.removeAllListeners( movieClip );
   	 * </listing>
	 * 
	 *  
	 */	
	public class listeners
	{
		/**
		 * Holds the current listener item being added  
		 */		
		private static var listenerItem:ListenerItem = null;
		
		/**
		 * Holds the listener references collection 
		 */		
		private static var listenerItems:Vector.<ListenerItem>;
		
		/**
		 * Each time you set the type a new <code>ListenerItem</code> is created to hold the the type and handler. 
		 * 
		 * @param listenerType
		 * 
		 */		
		public static function set type( listenerType:String ):void
		{
			listenerItem = new ListenerItem;
			listenerItem.type = listenerType;
		}
		
		/**
		 * Once both type and handler are set we can add them to the <code>listenerItems</code> collection.
		 *  
		 * @param eventHandlerReference
		 * 
		 */		
		public static function set handler( eventHandlerReference:Function ):void
		{
			if (listenerItem == null)
				return;
			
			listenerItem.handler = eventHandlerReference;
			
			if ( listenerItems == null )
				listenerItems = new Vector.<ListenerItem>();
			
			listenerItems.push( listenerItem );
			listenerItem = null;
		}
		
		/**
		 * <p>When you/'re ready to remove all the listeners you can use <code>removeAllListeners</code> method.  
		 * There may be cases where you want to store the events added on more than one object so when
		 *  it/'s time to clean you can use <code>clearListenerItems</code> set to false, so it will keep the 
		 * collection of handlers and we will be able to clean other objects.</p>
		 *  
		 * @param eventDispatcherObject
		 * @param clearListenerItems
		 * 
		 */		
		public static function removeAllListeners(eventDispatcherObject:IEventDispatcher, clearListenerItems:Boolean = true ):void
		{
			if ( listenerItems == null )
				return;
			
			var newListenerItems:Vector.<ListenerItem> = new Vector.<ListenerItem>();
			
			listenerItems.forEach( function callback(item:ListenerItem, index:int, vector:Vector.<ListenerItem>):void {
				
				if (eventDispatcherObject.hasEventListener( item.type ) )
				{
					eventDispatcherObject.removeEventListener( item.type, item.handler );
					
					if ( eventDispatcherObject.willTrigger( item.type ) )
						newListenerItems.push( item );
				}
				else
				{
					newListenerItems.push( item );
				}
			});
			
			if (clearListenerItems)
				listenerItems = null;
			else
				listenerItems = newListenerItems;
		}
	}
}

/**
 * a Value Object class to holds the properties needed to keep reference of.
 * 
 */
class ListenerItem {	
	public var type:String;
	public var handler:Function;	
}