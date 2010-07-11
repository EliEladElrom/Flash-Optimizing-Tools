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
	import flash.display.Sprite;
	import flash.net.SharedObject;

	public final class MemoryInfo
	{

		/**
		 * Method that creates a temporary <code>SharedObject</code> which allows you to find out the size of any object in bytes.
		 * Once we find out the size of the object we can clear the <code>SharedObject</code> since we have no need to store it anymore.
		 * 
		 * @param object
		 * @return The current size of an object, in bytes.
		 * 
		 */		
		public static function getObjectMemorySize( object:* ):Number
		{
			var sharedObject:SharedObject = SharedObject.getLocal("MEMORY_CHECK");
			sharedObject.data.object = object;
			
			var objectSizeInBytes:int = sharedObject.size;
			sharedObject.clear();
			
			return objectSizeInBytes;
		}
	}
}