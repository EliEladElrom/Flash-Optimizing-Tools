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
	 * User interface that will be used to seperate between the data and the presentation layer.
	 * 
	 * @author Elad Elrom
	 *
	 */
	 	
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	public class UIFileViewer extends AbstractFileViewer implements IUIFileViewer 
	{
		protected var component : UIComponent;

		/**
		 * The view will be sent to an output component, which can be any UIComponent.
		 * 
		 * @param	component	Any UIComponent such as Canvas, TitleWindow and more.
		 * 
		 * @see	com.elad.framework.fileviewer.IUIFileViewer
		 */		
		public function set output( component : UIComponent ) : void
		{
			this.component = component;
		}

		/**
		 * Method that will be used by UI to start the API
		 * 
		 * @param	filename	File name and extention to be checked and viewed.	
		 * 
		 * @see	com.elad.framework.fileviewer.IFileViewer
		 */		
		override public function initiate( filename : String ):void {	
			
			var abstractFileViewer : AbstractFileViewer;
			var fileparts : Array = filename.split(".");
			
			abstractFileViewer = checkFileName( fileparts[1].toString().toLowerCase() );
			this.component.addChild( UIComponent(abstractFileViewer.setProperties( filename )) );
		}

		/**
		 * Will check the file extension name and will invoke the abstractFileViewer method to set the view for the file
		 * 
		 * <p>The file extension need to be set in this method.</p>
		 * 
		 * @throws	Invalid file extention name if the extention was not set be this method.
		 * 
		 * @param	filename	File name and extention to be checked and viewed.	
		 * 
		 * @see	com.elad.framework.fileviewer.IFileViewer
		 */			
		protected function checkFileName( fileExt : String ) : AbstractFileViewer {
			
			var abstractFileViewer : AbstractFileViewer;
			
			switch ( fileExt ) {
				case "jpg":
					abstractFileViewer = new FileViewerImage( );		
				break;
				case "png":
					abstractFileViewer = new FileViewerImage( );		
				break;				
				case "flv":
					abstractFileViewer = new FileViewerMovie( );
				break;
			  	default:
					throw new Error("Invalid file extention name");
					return null;			  		
			  	break;	
			}
			
			return abstractFileViewer;		
		}
	}
}