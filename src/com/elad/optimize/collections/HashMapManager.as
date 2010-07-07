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
    /**
     *
     * A Singleton utility class to capture global variables for flex and pure Action script and store
     * them for future needs.  The class extends the <code>HashMapCollection</code> API, which allow creation 
     * of pairs of keys and values
     *
     * @see com.nbcuni.outlet.extensions.imp.widgettester.IWidgetTester
     * @see com.elad.framework.utils.collections.HashMapCollection
     *
     */	
	public class HashMapManager extends HashMapCollection
	{
	    //--------------------------------------------------------------------------
	    //
	    //  Variables
	    //
	    //--------------------------------------------------------------------------

		/**
		 * Singleton instance.
		 */	
		protected static var instance:HashMapManager;
		

	    //--------------------------------------------------------------------------
	    //
	    //  Constructor
	    //
	    //--------------------------------------------------------------------------
		
		/**
		 * Method needs to enforce that class is only created once
		 *  
		 * @param enforcer
		 * 
		 */
		public function HashMapManager(enforcer:AccessRestriction) 
		{
			if (enforcer == null)
				throw new Error("Error enforcer input param is undefined" );
				
		}		
		
		/**
		 * Method to set the flash vars variables
		 * 
		 * @example The following example sets the flash vars in Flex
		 * 
		 * <listing version="3.0">
	     * 		private var flashvar:GlobalVariables = GlobalVariables.getInstance();
	     * 		flashvar.setFlashVars(Application.application.parameters); 
		 * 		var str:String = flashvar.getItemValue("configUrl");
		 * </listing>
		 * 
		 * @example The following example sets the flash vars in Pure Action Script
		 * 
		 * <listing version="3.0">
	     * 		private var flashvar:GlobalVariables = GlobalVariables.getInstance();
	     * 		flashvar.setFlashVars(LoaderInfo(this.root.loaderInfo).parameters); 
		 * 		var str:String = flashvar.getItemValue("configUrl");
		 * </listing>
		 * 
		 * @param parameters
		 * 
		 */		
		public function setFlashVars(parameters:Object):void
		{
		    var key:String;
		    var value:String;
		    
		    for (key in parameters) 
		    {
		        value = String(parameters[key]);
		        this.addItem(key,value);
		    }
		}
		
		/**
		 * Method function to retrieve instance of the class
		 *  
		 * @return The same instance of the class
		 * 
		 */
		public static function getInstance():HashMapManager
		{
			if( instance == null )
				instance = new  HashMapManager(new AccessRestriction());
			
			return instance;
		}
		
	}
}

class AccessRestriction {}