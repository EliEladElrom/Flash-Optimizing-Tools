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
package com.elad.optimize.cache
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.LocalConnection;
	import flash.system.System;

	public final class GarbageCollector
	{
		/**
		 * Holds the application main entry point. <code>FlexGlobals.topLevelApplication</code> in Flex 4 or 
		 * <code>this</code> from the entry point in AIR and pure AS3
		 */		
		private static var main:Object;
		
		/**
		 * The connection name
		 */		
		private static const CONNECTION_NAME:String = "FORCE_CLEAN_UP";
		
		/**
		 * We need to use a counter so we can run the gc twice to ensure the gc mark and sweep
		 */		
		private static var GarbageCollectorCounter:int;
		
		/**
		 * Method to force the gc.  You pass the main application and after the <code>Event.ENTER_FRAME</code> is 
		 * called twice the gc will mark and sweep.
		 * 
		 * @param main
		 * @param connectionName
		 * 
		 */		
		public static function forceGarbageCollector( main:Object, connectionName:String = CONNECTION_NAME ):void
		{
			GarbageCollectorCounter = 0;
			GarbageCollector.main = main;
			
			main.addEventListener(Event.ENTER_FRAME, clearGarbageCollector);
		}
		
		/**
		 * Method to clear the gc.  If called directly and without <code>forceGarbageCollector</code> it will only calle the gc
		 * once.  It's recommend that you use <code>forceGarbageCollector</code>.
		 * 
		 * @param event
		 * 
		 */		
		private static function clearGarbageCollector( event:Event = null ):void
		{
			// works only in AIR in debug version
			System.gc();			
			
			// hack to force the gc
			try {
				new LocalConnection().connect( CONNECTION_NAME );
			}
			catch(error:*) {
			}
			
			if ( ++GarbageCollectorCounter >= 2 && main != null )
				main.removeEventListener( Event.ENTER_FRAME, clearGarbageCollector );
		}		
	}
}