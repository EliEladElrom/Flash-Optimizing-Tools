package com.adobe.utils
{
 import flash.display.DisplayObjectContainer;
 import flash.events.Event;
 import flash.events.EventDispatcher;
 import flash.events.KeyboardEvent;
 import flash.events.MouseEvent;
 import flash.utils.getTimer;
 import mx.core.UIComponent;
 import mx.managers.ISystemManager;
 
 public class PseudoThread extends EventDispatcher
 {
	 public function PseudoThread(sm:ISystemManager, threadFunction:Function, threadObject:Object)
	 {
		 fn = threadFunction;
		 obj = threadObject;

		 // add high priority listener for ENTER_FRAME
		 sm.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 100);
		 sm.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		 sm.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		 
		 thread = new UIComponent();
		 sm.addChild(thread);
		 thread.addEventListener(Event.RENDER, renderHandler);
	 }

	 // number of milliseconds we think it takes to render the screen
	 public var RENDER_DEDUCTION:int = 10;

	 private var fn:Function;
	 private var obj:Object;
	 private var thread:UIComponent;
	 private var start:Number;
	 private var due:Number;

	 private var mouseEvent:Boolean;
	 private var keyEvent:Boolean;

	 private function enterFrameHandler(event:Event):void
	 {
		start = getTimer();
		var fr:Number = Math.floor(1000 / thread.systemManager.stage.frameRate);
		due = start + fr;

		thread.systemManager.stage.invalidate();
		thread.graphics.clear();
		thread.graphics.moveTo(0, 0);
		thread.graphics.lineTo(0, 0);	
	 }

	 private function renderHandler(event:Event):void
	 {
		 if (mouseEvent || keyEvent)
			 due -= RENDER_DEDUCTION;

		 while (getTimer() < due)
		 {
			if (!fn(obj))
			{
				if (!thread.parent)
					return;

				var sm:ISystemManager = thread.systemManager;
				sm.stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				sm.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				sm.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				sm.removeChild(thread);
				thread.removeEventListener(Event.RENDER, renderHandler);
				dispatchEvent(new Event("threadComplete"));
			}
		 }

		 mouseEvent = false;
		 keyEvent = false;
	 }

	 private function mouseMoveHandler(event:Event):void
	 {
		mouseEvent = true;
	 }

	 private function keyDownHandler(event:Event):void
	 {
		keyEvent = true;
	 }
 } 
}
