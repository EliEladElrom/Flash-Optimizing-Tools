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
 
package com.elad.framework.binding
{
	import mx.events.PropertyChangeEvent;

	public class TurboBinding
	{
		import flash.events.IEventDispatcher;
		import flash.system.ApplicationDomain;
		import flash.utils.describeType;
		import flash.utils.getQualifiedClassName;
		import flash.utils.getQualifiedSuperclassName;
		import mx.binding.utils.ChangeWatcher;
		import mx.utils.DescribeTypeCache;
		import mx.core.EventPriority;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
	
		/**
		 *  @private
		 *  Holds only static methods.
		 *  We don't create instances of BindingUtilHelper.
		 */			
		public function TurboBinding()
		{
			super();
		}
		
		private static var bindingCollection:Array = [];

		/**
		 * Method to be called when host component is created to read the metadata
		 * information 
		 *  
		 * @param host
		 * 
		 */		
		public static function setup(host:Object):void
		{
			var className:String = getQualifiedClassName(host);
			var collection:Array = extractMetaDataInfo(className, "TurboBinding", 
				new Array("source", "destination", "twoWay", "unwatchCounter", "callback"));
			
			var source:String;
			var destination:String; 
			var callback:String;
			var unwatchCounter:int;
			var twoWay:String;
			var bindingCollectionIndx:int;
			var sourceParentType:String;
			var bindingOb:BindingObject;
			var len:int = collection.length;
			
			for (var i:int = 0; i < len; i++)
			{
				source = collection[i][0].value;
				destination = collection[i][1].value;
				callback = collection[i][4].value;
				unwatchCounter = (collection[i][3].value != "") ? int(collection[i][3].value)-1 : -1;
				twoWay = collection[i][2].value;
				bindingCollectionIndx = bindingCollection.length;
				sourceParentType = collection[i][5].sourceParentType;
				
				if (sourceParentType == "method" && callback == "")
				{
					callback = collection[i][5].parentName;
				}
				
				if (source == "")
				{
					source = collection[i][5].parentName;
				}
				
				bindingOb = new BindingObject();
				bindingCollection.push( bindingOb );
				
				bindingCollection[i].sourceWatcher = setBinding(host, source, destination, bindingCollectionIndx, callback, sourceParentType );
				bindingCollection[i].destWatcher = (twoWay == "true") ? setBinding(host, destination, source, bindingCollectionIndx, callback, sourceParentType) : null;
				bindingCollection[i].unwatchCounter = unwatchCounter;
				bindingCollection[i].sourceParentType = sourceParentType;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
			
		/**
		 * Switch to handle different type of metadata
		 *  
		 * @param host
		 * @param source
		 * @param destination
		 * @param bindingCollectionIndex
		 * @param callback
		 * @param sourceParentType
		 * @return 
		 * 
		 */			
		private static function setBinding(host:Object, source:String, destination:String, 
			bindingCollectionIndex:int, callback:String, sourceParentType:String):Object
		{
			var retVal:Object;
			
			if (sourceParentType == "method")
				retVal = setMethodBinding(host, source, destination, bindingCollectionIndex, callback);
			else
				retVal = setVariableBinding(host, source, destination, bindingCollectionIndex, callback);
			
			return retVal;
		}
		
		/**
		 * Sets a watcher for a variable metadata
		 *  
		 * @param host
		 * @param source
		 * @param destination
		 * @param bindingCollectionIndex
		 * @param callback
		 * @return 
		 * 
		 */
		private static function setVariableBinding(host:Object, source:String, destination:String, 
			bindingCollectionIndex:int, callback:String):Object
		{
			var callbackFunction:Function = (callback != "") ? host[callback] : null;
			var srcObjects:Array = source.split(".");
			var bindSrc:Object = host[srcObjects[0]];
			var handler:Function;
			var bindingOb:BindingObject = bindingCollection[bindingCollectionIndex] as BindingObject;
			
			if (callback != "")
			{
				handler = function(event:*):void
				{
					var destObjects:Array = destination.split(".");
					host[destObjects.shift()][destObjects.shift()] = event.newValue;
					
					callbackFunction( event.newValue );
					unwatchCheck(bindingCollectionIndex);
				};			
			}
			else
			{
				handler = function(event:*):void
				{
					var destObjects:Array = destination.split(".");
					host[destObjects.shift()][destObjects.shift()] = event.newValue;
				};
			}
			
			// watch changes
			bindSrc.addEventListener( PropertyChangeEvent.PROPERTY_CHANGE, handler);
			
			// set handler
			bindingOb.bindingHandler = handler;
			
			return bindSrc;
		}
		
		/**
		 * Sets a watcher for a method metadata
		 *  
		 * @param host
		 * @param source
		 * @param destination
		 * @param bindingCollectionIndex
		 * @param callback
		 * @return 
		 * 
		 */		
		private static function setMethodBinding(host:Object, source:String, destination:String, 
			bindingCollectionIndex:int, callback:String):Object
		{
			var canWatch:Boolean = ChangeWatcher.canWatch( host, source.split(".")[0] );
			var handler:Function;
			
			if (!canWatch)
			{
				trace("Cannot bind source: "+source);	
			}
			
			var watcher:ChangeWatcher;
			var callbackFunction:Function = (callback != "") ? host[callback] : null;
			
			if (callback != "")
			{
				handler = function(event:*):void
				{
					var destObjects:Array = destination.split(".");
					var bindDest:Object = host[destObjects.shift()];
					var srcObjects:Array = source.split(".");
					var bindSrc:Object = host[srcObjects.shift()];
					
					if (bindDest[destObjects] != bindSrc[srcObjects])
					{
						bindDest[destObjects.shift()] = event.target.text;
						
						callbackFunction(event.target.text);
						unwatchCheck(bindingCollectionIndex);					
					}
				}				
			}
			else
			{
				handler = function(event:*):void
				{
					var destObjects:Array = destination.split(".");
					host[destObjects.shift()][destObjects.shift()] = event.target.text;
				}				
			}
			
			watcher = ChangeWatcher.watch( host, source.split("."), handler );
			
			return watcher as Object;
		}			
		
		/**
		 * Checks how many times change was made and unwatch when needed
		 *  
		 * @param index
		 * 
		 */		
		private static function unwatchCheck(index:int):void
		{
			var bindingOb:BindingObject = bindingCollection[index] as BindingObject;
			
			//trace("unwatchCounter: "+bindingOb.unwatchCounter);
			
			if (--bindingOb.unwatchCounter == -1)
			{
				if (bindingOb.destWatcher != null)
					(bindingOb.destWatcher as ChangeWatcher).unwatch();
				
				if (bindingOb.sourceParentType == "method")
				{
					(bindingOb.sourceWatcher as ChangeWatcher).unwatch();
				}
				else
				{
					bindingOb.sourceWatcher.removeEventListener( PropertyChangeEvent.PROPERTY_CHANGE, bindingOb.bindingHandler );
				}
				
				bindingOb.destWatcher = null;
				bindingOb.sourceWatcher = null;
			}
		}
		
		/**
		 * Extract metadata information from the host
		 *  
		 * @param className
		 * @param metadataName
		 * @param argumentsList
		 * @return 
		 * 
		 */		
		private static function extractMetaDataInfo(className:String, metadataName:String, argumentsList:Array):Array
		{
			var classValues:Class = ApplicationDomain.currentDomain.getDefinition(className) as Class;				
			var describeType:XML = flash.utils.describeType(classValues);
			var i:int;
			var metadata:XMLList;
			var collection:Array = new Array();
			
			// handles variable metadata 
			metadata = describeType.factory.variable.metadata.(@name == metadataName);				
			for (i = 0; i < metadata.length(); i++)
			{
				var item:Array = [];
				var argument:Object;

				for (var counter:int = 0; counter<argumentsList.length; counter++)
				{
					argument = new Object();
					argument.name = argumentsList[counter];
					argument.value = String(metadata[i].arg.(@key == argumentsList[counter]).@value);
					item.push(argument);
				}
				
				argument = new Object();
				argument.parentName = String(metadata[i].parent().@name);
				argument.sourceParentType = "variable";
				item.push(argument);
								
				collection.push( item );
			}
						
			// handles methods
			metadata = describeType.factory.method.metadata.(@name == metadataName);
			for (i = 0; i < metadata.length(); i++)
			{
				item = [];
				
				for (counter = 0; counter<argumentsList.length; counter++)
				{
					argument = new Object();
					argument.name = argumentsList[counter];
					argument.value = String(metadata[i].arg.(@key == argumentsList[counter]).@value);
					item.push(argument);
				}
				
				argument = new Object();
				argument.parentName = String(metadata[i].parent().@name);
				argument.sourceParentType = "method";
				item.push(argument);
				
				collection.push( item );
			}
			
			return collection;
		}											
	}
}

import mx.binding.utils.ChangeWatcher;

class BindingObject
{
	public var sourceWatcher:Object;
	public var destWatcher:Object;
	public var unwatchCounter:int;
	public var sourceParentType:String;
	public var bindingHandler:Function;
	
	public function BindingObject() {
	}
}