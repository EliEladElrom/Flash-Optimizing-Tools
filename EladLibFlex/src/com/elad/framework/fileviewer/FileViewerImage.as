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
	 * This subclass will used for an image.
	 * 
	 * @author Elad Elrom
	 *
	 */	
	
	import com.elad.framework.fileviewer.view.IView;
	import com.elad.framework.fileviewer.view.ImageViewer;
	
	public class FileViewerImage extends AbstractFileViewer
	{
		
		/**
		 * The Factory Method is an abstract method that will be overridden in the view class. 
		 * 
		 * @return	The method return a concrete object of the view.
		 * 
		 * @see	com.elad.framework.fileviewer.IFileViewer	
		 * 
		 */		
		override protected function factoryMethod( ) : IView
		{
			return new ImageViewer( );	
		}
	}
}