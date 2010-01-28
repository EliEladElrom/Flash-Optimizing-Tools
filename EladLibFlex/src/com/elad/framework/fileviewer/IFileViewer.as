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

package com.elad.framework.fileviewer
{
	
	/**
	 * File Viewer interface to set the methods needs to be implemented.
	 * 
	 * @author Elad Elrom
	 *
	 */	
	import com.elad.framework.fileviewer.view.IView;
	
	public interface IFileViewer
	{
		
		/**
		 * This will set all the properties that are needed in the view layer.
		 * 
		 * @param	filename	File name and extention.	
		 * 
		 * @return	IView	Return the view components.
		 */			
		function setProperties( filename : String ): IView
		
		/**
		 * Method that will be used by UI to start the API
		 * 
		 * @param	filename	File name and extention to be checked and viewed.	
		 * 
		 */		
		function initiate( filename : String ):void
		
	}
}