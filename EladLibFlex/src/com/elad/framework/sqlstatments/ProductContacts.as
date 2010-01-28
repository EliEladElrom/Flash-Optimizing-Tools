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
	 * This class implements the Product interface.
	 * 	
	 */		
	public class ProductContacts implements ICrud 
	{
		public function SQLCommands(vars:Array):Array {
			var array: Array = new Array();
			array.push( Create("Contacts", "'"+vars[0].fname+"','"+vars[0].lname+"','"+vars[0].email+"'") );
			return array;
		}
		
		public function Create(table_name:String, str:String):String
		{
			return "INSERT INTO "+table_name+" VALUES ("+str+")";
		}
		public function Read(table_name:String, str:String):String
		{
			return "SELECT FROM "+table_name+" WHERE "+str;
		} 		
		public function Update(table_name:String, str:String):String
		{
			return "UPDATE  "+table_name+" "+str;
		}		
		public function Delete(table_name:String, str:String):String
		{
			return "DELETE FROM  "+table_name+"  WHERE "+str;
		}
	}
}