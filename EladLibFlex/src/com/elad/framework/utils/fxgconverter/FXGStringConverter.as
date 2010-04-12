package com.elad.framework.utils.fxgconverter
{
	import flash.utils.getQualifiedClassName;
	
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.utils.StringUtil;
	
	import spark.components.Group;

	/**
	 * A Utility class to convert FXG string during runtime to component code.
	 * 
	 * Example:
	 * 
	 * <listing version="3.0" >

	 * 	var fxg:String = '<s:Group id="groupSample1"><s:Ellipse id="ellipse" width="30" height="30"><s:fill><s:SolidColor color="0x000000"></s:SolidColor></s:fill></s:Ellipse></s:Group>';
	 * 		
	 * 	var comp:Group = FXGStringConverter.convertFXGStringToComponent( fxg );
	 * 	this.addElement( comp );
	 * 
	 * </listing>
	 * 
	 * @author Elad Elrom
	 * 
	 */	
	public final class FXGStringConverter
	{
		/**
		 * Converts the fxg string to component and return a group
		 *  
		 * @param fxg	holds the FXG string
		 * @param debug	 flag to indicate weather it's in debug mode
		 * @return 
		 * 
		 */		
		public static function convertFXGStringToComponent( fxg:String, debug:Boolean = false ):Group
		{
			StringUtil.trim( fxg );
			var fxgXML:XML = convertFXGToXML( fxg, debug );
			var subComList:XMLList = new XMLList( fxgXML );
			var subSubComList:XMLList;
			
			if (fxgXML == null)
			{
				if ( debug )
					trace("WARNING: Couldn't generate XML");	
				
				return new Group;
			}			
			
			var parentComponent:Group = retrieveComponentFromXML( subComList[0], debug );
			var previousComponent:* = parentComponent;
			var subCompLen:int = 0;
			var subSubCompLen:int = 0;
			var component:*;

			subComList = new XMLList( subComList.children() );
			subCompLen = subComList.length();
			
			for (var i:int = 0; i < subCompLen; i++)
			{
				// check sub-components
				var subXMLList:XMLList = new XMLList( subComList[i] );
				component = retrieveComponentFromXML( subXMLList[0], debug );
				previousComponent = parentComponent;
				
				if ( addChildToComponent( component, previousComponent, debug ) )
				{
					previousComponent = component;
				}
				
				// check sub-sub-components
				subSubComList = new XMLList( subComList[i].children().children() );
				subSubCompLen = subSubComList.length();
				
				for (var ii:int = 0; ii < subSubCompLen; ii++)
				{
					component = retrieveComponentFromXML( subSubComList[ii], debug );
					addChildToComponent( component, previousComponent, debug );
				}
			}
			
			return parentComponent;
		}
		
		/**
		 * Take xml object and return the matching component.
		 *  
		 * @param xml	pass the FXG as xml object
		 * @param debug	 flag to indicate weather it's in debug mode
		 * @return the component that is matched with the xml string
		 * 
		 */		
		public static function retrieveComponentFromXML( xml:XML, debug:Boolean = false ):*
		{
			var currentString:String;
			
			currentString = xml.toXMLString().split(">")[0];
			currentString = currentString.substr( 0, currentString.length-1 );
			
			var splitSingleComponent:Array = currentString.split( " " );
			
			// setting class & prop
			var child:* = SupportedClassesAndProperties.settingComponentClass( (splitSingleComponent[0] as String).split("<")[1], debug );
			child = SupportedClassesAndProperties.settingComponentProperties( splitSingleComponent, child, debug );
			
			if ( child == null )
			{
				if ( debug )
					trace("WARNING: Could'nt find component from xml string, take a look: " + xml.toXMLString() );
			}
			
			return child;
		}
		
		/**
		 * Method to add the child to the component.  The child may be a component or it may just be an interface that is a property 
		 * in the componenent.
		 *
		 * @param child	holds the xml child that needs to be added to the componenent 
		 * @param previousComponent	holds the object of the previous component added to the parent
		 * @param debug  flag to indicate weather it's in debug mode
		 * @return 
		 * 
		 */		
		public static function addChildToComponent( child:*, previousComponent:*, debug:Boolean = false ):Boolean
		{
			var isUIComponent:Boolean = false;
			
			if ( child == null )
			{
				return false;
			}
			
			if ( child is SolidColor )
			{
				previousComponent.fill = child;
				isUIComponent = false;
			}
			else if ( child is SolidColorStroke )
			{
				previousComponent.stroke = child;
				isUIComponent = false;
			}
			else
			{
				previousComponent.addElement( child );
				isUIComponent = true;
			}	
			
			if ( debug )
				trace( "Adding: " + getQualifiedClassName( child ) + " to: " + getQualifiedClassName( previousComponent ) );
			
			return isUIComponent;
		}
		
		/**
		 * Method to clean FXG and convert FXG String into a xml object
		 *  
		 * @param fxg	that's an FXG string
		 * @return flag to indicate weather it's in debug mode
		 * 
		 */	
		public static function convertFXGToXML( fxg:String, debug:Boolean = false ):XML
		{
			var xml:XML;
			var newfxg:String;
			
			newfxg = replaceStringInEntireParagraph( fxg, "s:", "" );
			newfxg = replaceStringInEntireParagraph( newfxg, "d:userLabel", "d_userLabel" );	
			newfxg = replaceStringInEntireParagraph( newfxg, "ai:objID", "ai_objID" );
			newfxg = replaceStringInEntireParagraph( newfxg, "flm:knockout", "flm_knockout" );
			
			try
			{
				xml = new XML( newfxg );
			}
			catch ( error:Error )
			{
				if ( debug )
					trace( "ERROR: cannot convert string to a valid XML: " + error.message );
			}
			
			return xml;
		}
		
		/**
		 * Method to replace all the instances of a string with a new string in an entire string paragraph
		 *  
		 * @param str
		 * @param p
		 * @param repl
		 * @return 
		 * 
		 */		
		public static function replaceStringInEntireParagraph(str:String, p:*, repl:*):String
		{
			var isStringChanged:Boolean = true;
			var newfxg:String;
			
			while ( isStringChanged )
			{
				newfxg = str.replace(p, repl);
				
				if ( newfxg != str )
					str= newfxg;
				else
					isStringChanged = false;
				
			}
			
			return newfxg;
		}
	}
}