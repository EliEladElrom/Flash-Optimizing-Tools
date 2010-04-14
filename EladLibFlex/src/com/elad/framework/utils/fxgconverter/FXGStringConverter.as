package com.elad.framework.utils.fxgconverter
{
	import flash.utils.getQualifiedClassName;
	
	import mx.graphics.GradientEntry;
	import mx.graphics.LinearGradient;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.utils.StringUtil;
	
	import spark.components.Group;
	import spark.primitives.Path;

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
					
					// Use case for gradients
					if ( component is LinearGradient )
						(component as LinearGradient).entries = getGradients( subComList[i].children().children().children(), debug );;
					
					addChildToComponent( component, previousComponent, debug );
				}
			}
			
			return parentComponent;
		}
		
		/**
		 * Retrive component's gradients
		 *  
		 * @param xml
		 * @param debug
		 * @return 
		 * 
		 */		
		public static function getGradients( xml:XMLList, debug:Boolean ):Array
		{
			var componentChild:*;
			var subSubSubCompLen:int = 0;
			var subSubSubComList:XMLList;
			
			// check sub-sub-sub components
			subSubSubComList = new XMLList( xml );
			subSubSubCompLen = subSubSubComList.length();
			var gradients:Array = [];
			
			for (var i:int = 0; i < subSubSubCompLen; i++)
			{
				componentChild = retrieveComponentFromXML( subSubSubComList[i], debug );
				gradients.push( componentChild );
			}
			
			return gradients;
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
			var isUIComponent:Boolean = true;
			var message:String = "Adding: ";
			
			if ( child == null )
			{
				return false;
			}
			
			if ( child is SolidColor || ( child is LinearGradient && previousComponent is Path ) )
			{
				previousComponent.fill = child;
				isUIComponent = false;
				
				if ( debug )
					message = "Adding fill: " ;		
			}

			if ( child is SolidColorStroke )
			{
				previousComponent.stroke = child;
				isUIComponent = false;
				
				if ( debug )
					message = "Adding stroke: ";					
			}

			if ( previousComponent is LinearGradient && child is GradientEntry )
			{
				( previousComponent as LinearGradient ).entries.push( child );
				isUIComponent = false;
				
				if ( debug )
					message = "Adding entries: ";			
			}

			if ( isUIComponent )
			{
				try {
					previousComponent.addElement( child );
					isUIComponent = true;				
				}
				catch (error:Error)
				{
					trace( "FAIL: Couldn't add child: " + error.message );
				}
			}
			
			if ( debug )
				trace( message + getQualifiedClassName( child ) + " to: " + getQualifiedClassName( previousComponent ) );
			
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
			newfxg = replaceStringInEntireParagraph( newfxg, "d:id", "d_id" );
			newfxg = replaceStringInEntireParagraph( newfxg, "flm:variant", "flm_variant" );
			
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