/*
 
 	Copyright (c) 2008 Elad Elrom.  Elrom LLC. All rights reserved. 
	
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
 	@contact elad@elromdesign.com

 */
 
package com.elad.framework.sqlstatments
{

	/**
	 * Sqlstatments API let you create different CRUD (Create, Read, Update and Delete) statements 
	 * for each form and you have one place where all your SQL commands are located so once it’s time to change them or 
	 * update your database design
	 * 
	 * @author Elad Elrom
	 *
	 */	
	import flash.errors.IllegalOperationError;
	// import flash.errors.IllegalOperationError;
		
	public class AbstractDataServicesManager
	{
		
		/**
		 * Factory method will be used to navigate between the different ConcreteProduct objects.
		 * 	
		 * 
		 * @return	ICrud	return the ConcreteProduct object.
		 * 
		 * 
		 */				
		protected function factoryMethod():ICrud
		{
			throw new IllegalOperationError("Abstract method: must be overridden in a subclass");			
			return null;	
		}

		/**
		 * getSQLStatments method is used to submit the list of arguments and return the SQL statments
		 * 
		 * @param	array	The array will include the list of arguments to submit.		
		 * 
		 * @return	The SQL statments.	
		 * 
		 */			
		public function getSQLStatments(array:Array):Array
		{
			var product : ICrud = this.factoryMethod( );
			return product.SQLCommands(array);
		}
	}
}