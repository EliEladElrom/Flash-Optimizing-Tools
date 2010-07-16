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

	public class listeners
	{
		private static var listenerItem:ListenerItem = null;
		private static var listenerItems:Vector.<ListenerItem>;
		
		public static function set type( listenerType:String ):void
		{
			listenerItem = new ListenerItem;
			listenerItem.type = listenerType;
		}
		
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
		
		public static function removeAllListeners(eventDispatcherObject:IEventDispatcher, clearListenerItems:Boolean = true ):void
		{
			if ( listenerItems == null )
				return;
			
			listenerItems.forEach( function callback(item:ListenerItem, index:int, vector:Vector.<ListenerItem>):void {
				eventDispatcherObject.removeEventListener( item.type, item.handler );
			});
			
			if (clearListenerItems)
				listenerItems = null;
		}
	}
}

class ListenerItem {	
	public var type:String;
	public var handler:Function;	
}