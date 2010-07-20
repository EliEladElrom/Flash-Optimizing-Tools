package com.elad.optimize.memory
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class FrameStats extends Sprite
	{
		private static var LINE_GRAPH_STARTING_POINT_X:int = 85;
		private static var WIDTH:int = 200; 
		private static var HEIGHT:int = 100;
		
		private var isShowCounters:Boolean;
		private var isDebugMode:Boolean;
		private var countSecondsSinceStart:int = 0;
		
		private var main:*;
		
		// Enter frame
		private var frameActionsExecuted:int;
		private var enterFrameCounter:int;
		private var enterFrameTime:int;
		
		// Enter frame constructed
		private var constructorCodeExecuted:int;
		private var enterFrameConstructedCounter:int;
		private var enterFrameConstructedTime:int;
		
		// exit frame
		private var exitFrameCounter:int;
		private var exitFrameTime:int;
		
		// rendering
		private var playerRendersChangesDisplayList:int;
		private var renderingCounter:int;
		private var renderingTime:int;
		
		// final code exec
		private var finalUserCodeExecuted:int;
		private var isFinalUserCodeFirstTime:Boolean = false;
		private var finalUserCodeTime:int;
		private var firstFinalUserCodeTime:int;
		
		// timer
		private var startTime:Number = getTimer();
		private var timer:Timer = new Timer(1000);
		private var mouseEventCounter:int;
		
		// charts colors
		private var colors:Vector.<uint> = new <uint>[0xe48701, 0xa5bc4e, 0x1b95d9, 0xcaca9e];		
		
		// texts
		private var pieStyle:XML;
		private var globalStyle:XML;
		private var style:StyleSheet;
		private var pieText:TextField = new TextField();
		private var globalText:TextField = new TextField();
		
		// graphs
		private var lineGraphCounter:int = 0;
		private var lineGraphs:Vector.<Sprite> = new Vector.<Sprite>;
		private var pieGraph:MovieClip = null;
		
		// charts data provider
		private var dataProvider:Vector.<Object>;

		public function FrameStats( main:*, isDebugMode:Boolean = false, isShowCounters:Boolean = false )
		{
			this.main = main;
			this.isDebugMode = isDebugMode;
			this.isShowCounters = isShowCounters;

			addEventListener(Event.ENTER_FRAME, updateDisplay);
			
			setStyles();
			addChild( drawBackground );
			addChild( pieText );
			addChild( globalText );
			drawLineGraph();
			drawRects();
			
			timer.addEventListener( TimerEvent.TIMER, function(event:TimerEvent):void {
				showResults();
			});
			
			timer.start();
			
			synthesizesFrameRate();			
		}
		
		private function get drawBackground():Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0x000025);
			sprite.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			sprite.graphics.endFill();	
			
			return sprite;
		}
		
		private function drawRects():void
		{
			var rectangle:Shape;
			var startY:Number = 66.5;
			
			colors.forEach( function callback(item:uint, index:int, vector:Vector.<uint>):void {
				startY+=6.1;
				rectangle = new Shape;
				rectangle.graphics.beginFill(item);
				rectangle.graphics.drawRect(0, 0, 5, 5);
				rectangle.graphics.endFill();
				rectangle.x = 0;
				rectangle.y = startY;
				
				addChild(rectangle);				
			});
		}
		
		private function drawLineGraph():void
		{
			var item:Sprite;
			
			for (var i:int; i<4; i++)
			{
				item = new Sprite();
				item.graphics.lineStyle(1, colors[i]);
				item.graphics.moveTo(LINE_GRAPH_STARTING_POINT_X, 0);
				
				lineGraphs.push( item );
				addChild( item );
			}
		}
		
		private function setTextProp(text:TextField, x:int, y:int, width:int, height:int):void
		{
			text.mouseEnabled = false;
			text.condenseWhite = true;
			text.selectable = false;
			text.x = x;
			text.y = y;
			text.width = width;
			text.height = height;
			text.styleSheet = style;
		}
		
		private function updateDisplay( event:Event ):void
		{
			if (dataProvider == null)
				return;
			
			var total:Number = 0;
			++lineGraphCounter;
			
			dataProvider.forEach( function callback(item:Object, index:int, vector:Vector.<Object>):void {
				total+=Number(item.time);
			});

			drawGraph( 80, 80, 25, dataProvider, total);
			updateLabels(dataProvider);
		}
		
		
		private function synthesizesFrameRate():void
		{
			main.addEventListener(MouseEvent.MOUSE_MOVE, function onMouseMove(event:MouseEvent):void {
				
				mouseEventCounter++;
				finalUserCodeTime = getTimer()-startTime;
				
				if ( renderingTime != 0 && isFinalUserCodeFirstTime )
				{
					isFinalUserCodeFirstTime = false;
					firstFinalUserCodeTime = getTimer()-startTime;
				}
				
				//stage.invalidate();
				//event.updateAfterEvent();
			});
			
			main.addEventListener(Event.ENTER_FRAME, function(event:Event):void {
				
				isFinalUserCodeFirstTime = true;
				
				enterFrameCounter++;
				enterFrameTime = getTimer()-startTime;
				
				finalUserCodeExecuted = finalUserCodeTime-firstFinalUserCodeTime;
				playerRendersChangesDisplayList = enterFrameTime-finalUserCodeTime;					
				
				if (isDebugMode) trace("Final user code executed: " + String( finalUserCodeExecuted ) );
				if (isDebugMode) trace("Player renders changes display list: " + String( playerRendersChangesDisplayList ) );
				
				if (isDebugMode) trace("Event.ENTER_FRAME");
				
				setNewDataProvider();
			});	
			
			main.addEventListener(Event.FRAME_CONSTRUCTED, function(event:Event):void {
				
				enterFrameConstructedCounter++;
				enterFrameConstructedTime = getTimer() - startTime;
				constructorCodeExecuted = enterFrameConstructedTime-enterFrameTime;
				
				if (isDebugMode) trace("Constructor code of children executed: " + String( constructorCodeExecuted ) );
			});				
			
			main.addEventListener(Event.EXIT_FRAME, function(event:Event):void {
				
				exitFrameCounter++;
				exitFrameTime = getTimer() - startTime;
				frameActionsExecuted = exitFrameTime-enterFrameConstructedTime;	
				
				if (isDebugMode) trace("frame actions & children executed: " + String( frameActionsExecuted ) );
			});
			
			main.addEventListener(Event.RENDER, function(event:Event):void {
				
				renderingCounter++;
				renderingTime = getTimer()-startTime;
				
				if (isDebugMode) trace("Event.RENDER");
			});					
		}	
		
		private function showResults():void 
		{
			++countSecondsSinceStart;
			
			if (isShowCounters)
			{
				trace("-------------- " + countSecondsSinceStart + " second ---------------");
				trace("enterFrameCounter: " + enterFrameCounter );
				trace("renderingCounter: "  + renderingCounter );
				trace("mouseEventCounter: "  + mouseEventCounter );
			}
			
			enterFrameCounter = 0;
			mouseEventCounter = 0;
			renderingCounter = 0;
		}
		
		
		private function setNewDataProvider():void
		{
			var total:int = constructorCodeExecuted + frameActionsExecuted + finalUserCodeExecuted + playerRendersChangesDisplayList;
			
			dataProvider = new <Object>[{name: "Constructor code executed", time: ( (constructorCodeExecuted/total) * 100 ).toFixed(2)  },
				{name: "frame actions executed", time: ( (frameActionsExecuted/total) * 100 ).toFixed(2) }, 
				{name: "Final user code executed", time: ( (finalUserCodeExecuted/total) * 100 ).toFixed(2) },
				{name: "Player renders changes display list", time: ( (playerRendersChangesDisplayList/total) * 100 ).toFixed(2) }
			];
		}		
		
		private function drawGraph( pieCenterX:int, pieCenterY:int, radius:int, dataProvider:Vector.<Object>, total:int ):void
		{
			if (pieGraph != null)
				removeChild( pieGraph );
				
			addChild( pieGraph = new MovieClip() );
			
			var numOfRadians:Number = 0;
			pieGraph.x = 30;
			pieGraph.y = 46;
			
			pieGraph.graphics.lineStyle( 1, 0x000000 );
			var radian:Number;
			var title:String;
			
			dataProvider.forEach( function callback(item:Object, index:int, vector:Vector.<Object>):void {

				// draw line graph
				if ( lineGraphCounter > WIDTH - LINE_GRAPH_STARTING_POINT_X )
					resetLineGraph();
					
				lineGraphs[index].graphics.lineTo( LINE_GRAPH_STARTING_POINT_X + lineGraphCounter , ( 100-dataProvider[index].time ) );
				
				radian = Number(item.time)/total*2;
				title = item.name;
				
				pieGraph.graphics.beginFill( colors[index] );
				pieGraph.graphics.moveTo( 0,0 );
				pieGraph.graphics.lineTo( Math.sin( numOfRadians * Math.PI ) * radius, Math.cos( numOfRadians * Math.PI ) * radius );
				
				for(var n:Number = 0; n <= radian; n += .0001)
					pieGraph.graphics.lineTo( Math.sin( ( numOfRadians+n ) * Math.PI ) * radius, Math.cos( ( numOfRadians+n ) * Math.PI ) * radius );
				
				numOfRadians += radian;
				pieGraph.graphics.lineTo(0,0);
				pieGraph.graphics.endFill();
				
			});
		}
		
		private function resetLineGraph():void
		{
			lineGraphCounter = 0;
			
			lineGraphs.forEach( function callback(item:Sprite, index:int, vector:Vector.<Sprite>):void {
				item.graphics.clear();	
				item.graphics.lineStyle(1, colors[index]);
				item.graphics.moveTo(LINE_GRAPH_STARTING_POINT_X, 0);				
			});
		}
		
		private function setStyles():void
		{
			pieStyle = <text/>;
			globalStyle = <text/>;			
			
			style = new StyleSheet();
			style.setStyle('text', {fontSize:'7px', fontFamily:'_sans', leading:'-2px'});
			style.setStyle('constructorCodeExecuted', {color: "#"+colors[0].toString(16)});
			style.setStyle('frameActionsExecuted', {color: "#"+colors[1].toString(16)});
			style.setStyle('finalUserCodeExecuted', {color: "#"+colors[2].toString(16)});
			style.setStyle('playerRendersChangesDisplayList', {color: "#"+colors[3].toString(16)});
			style.setStyle('fps', {color: "#FFFFFF"});
			style.setStyle('memory', {color: "#FFFFFF"});
			style.setStyle('time', {color: "#FFFFFF"});
			
			setTextProp( globalText, 4, -2, 70, 30 );
			setTextProp( pieText, 4, 70, LINE_GRAPH_STARTING_POINT_X, 30 );
		}		
		
		private function updateLabels(dataProvider:Vector.<Object>):void
		{
			pieStyle.constructorCodeExecuted = "Constructor Code: " + dataProvider[0].time; 
			pieStyle.frameActionsExecuted = "Frame Actions: " + dataProvider[1].time;
			pieStyle.finalUserCodeExecuted = "Final UserCode: " + dataProvider[2].time;
			pieStyle.playerRendersChangesDisplayList = "Display changes: " + dataProvider[3].time;
			
			globalStyle.fps = "FPS: " + stage.frameRate;
			globalStyle.memory = "MEM: " + Number( ( System.totalMemory * 0.000000954 ).toFixed(2) );
			globalStyle.time = "TIME: " + countSecondsSinceStart;
			
			globalText.htmlText = globalStyle;
			pieText.htmlText = pieStyle;
		}
	}
}