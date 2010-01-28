package com.fusiox.ui
{
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import mx.core.UIComponent;
	import mx.containers.Canvas;
	import flash.display.Bitmap;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenu;
	import flash.events.ContextMenuEvent;
	import flash.geom.Point;
	
	[Event("afterVisualization")]
	[Event("beforeVisualization")]
	[Style(name="audioLineColor",type="Number",format="Color",inherit="no")]
	[Style(name="audioFillColor",type="Number",format="Color",inherit="no")]
	public class Visualization extends UIComponent 
	{
		private var _audioLineColor:uint = 0x000000;
		private var _audioFillColor:uint = 0x000000;
		private var gain:uint = 1;
		private var myContextMenu:ContextMenu;
		private var display:UIComponent = new UIComponent();
		private var spectrumData:ByteArray = new ByteArray();
		private var rc:Number = 0;
		private var rp:Number = 0;
		private var peak:Number = 0;
		
		public var type:String = "line";
		public var channel:String="mono";
		public var bars:uint = 256;
		public var bitmapData:BitmapData = new BitmapData(1, 1, true, 0x00000000);
		public var bitmap:Bitmap = new Bitmap(bitmapData);           
		
		public function Visualization() 
		{
			addEventListener(Event.ENTER_FRAME, enterFrameListener);
			
			myContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			var defaultItems:ContextMenuBuiltInItems = myContextMenu.builtInItems;
			defaultItems.print = true;
			
			var item1:ContextMenuItem = new ContextMenuItem("Line");
			var item2:ContextMenuItem = new ContextMenuItem("Wave");
			var item3:ContextMenuItem = new ContextMenuItem("Bars");
			myContextMenu.customItems.push(item1);
			myContextMenu.customItems.push(item2);
			myContextMenu.customItems.push(item3);
			
			myContextMenu.customItems.push(item3);
			
			item1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			item2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			item3.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			this.contextMenu = myContextMenu;
		}
		
		private function menuItemSelectHandler(event:ContextMenuEvent):void 
		{
			setType(event.target.caption);
		}
		
		private function setType( t:String ):void 
		{
			type = t.toLowerCase();
		}
		
		override protected function createChildren():void 
		{
			addChild(bitmap);
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void 
		{
			super.updateDisplayList(w, h);
			var bt:uint = getStyle("borderThickness")*2;
			
			if(w-bt>0 && h-bt>1) 
			{
				bitmapData = new BitmapData(w-bt, h-bt, true, 0x0);
			}
			
			bitmap.bitmapData = bitmapData;
			_audioLineColor = getStyle("audioLineColor");
			_audioFillColor = getStyle("audioFillColor");
			rc = (h-bt)/2;
			rp = (w-bt)/256;
		}
		
		private function enterFrameListener(e:Event):void 
		{
			var rect:Rectangle = bitmapData.rect
				SoundMixer.computeSpectrum(spectrumData, type=="bars", 0);
			dispatchEvent( new Event("beforeVisualization",true) );
			
			if(!hasEventListener( "beforeVisualization" )) 
			{ 
				bitmapData.fillRect( rect, 0x0); 
			}
			
			switch (channel) 
			{
				case "mono":
					toMono();
				case "left":
					if(type=="line" || type=="wave") { drawWave(1); }
					if(type=="wave") 
					{
						spectrumData.position=0;
						drawWave(-1);
					}
					if(type=="bars") 
					{
						drawEQ();
					}
					break;
				case "right":
					for (var i:int = 0; i < 256 ; i++) {spectrumData.readFloat();} // using spectrumData.position yields poor results
					if(type=="line" || type=="wave") { drawWave(1); }
					if(type=="wave") 
					{
						spectrumData.position=0;
						for (i = 0; i < 256 ; i++) {spectrumData.readFloat();}
						drawWave(-1);
					}
					if(type=="bars") 
					{
						drawEQ();
					}
					break;
				case "stereo":
					if(type=="line" || type=="wave") 
					{
						drawWave(1);
						drawWave(1);
					}
					if(type=="wave") {
						spectrumData.position=0;
						drawWave(-1);
						drawWave(-1);
					}
					if(type=="bars") {
						drawEQ();
						drawEQ();
					}
					break;
			}
			bitmapData.applyFilter( bitmapData, rect, new Point(0,0), new BlurFilter(bitmapData.width/256,bitmapData.width/256,1));
			dispatchEvent( new Event("afterVisualization",true) );
		}
		
		private function toMono():void 
		{
			spectrumData.position = 0;
			if(spectrumData.length==2048) {
				var leftData:ByteArray = new ByteArray();
				var rightData:ByteArray = new ByteArray();
				spectrumData.readBytes(leftData, 0, 1024);
				spectrumData.readBytes(rightData, 0, 1024);
				spectrumData = new ByteArray();
				for (var i:uint = 0; i < 256 ; i++) {
					spectrumData.writeFloat((leftData.readFloat()+rightData.readFloat())/2);
				}
				spectrumData.position = 0;
			}
		}
		
		private function drawWave(modifier:Number=1):void 
		{
			var v:Number;
			var lastv:Number = rc;
			peak = 0;
			for (var i:uint = 0; i < 256; i++) {
				var rf:Number = spectrumData.readFloat();
				v = rc+rf*rc*modifier*-1;
				if(type=="wave"){bitmapData.fillRect( new Rectangle(i*rp, Math.min(v,rc), rp, Math.abs(rc-v)), 0xFF000000 | _audioFillColor );}
				bitmapData.fillRect( new Rectangle(i*rp, v, rp, 1+Math.abs(lastv-v)), 0xFF000000 | _audioLineColor );
				lastv=v;
				if(Math.abs(rf)>peak) { peak = Math.abs(rf); }
			}
		}
		
		private function drawEQ():void 
		{
			var v:Number;
			var n:Number = 0;
			var nrp:Number = rp*256/bars;
			for (var i:uint = 0; i < bars; i++) {
				n = 0;
				for (var j:uint = 0; j < Math.floor(256/bars) ; j++) {
					n += spectrumData.readFloat();
					if(Math.abs(n)>peak) { peak = Math.abs(n); }
				}
				n = n/Math.floor(256/bars)
					v = Math.max(rc*2-n*rc*2*gain,5);
				
				bitmapData.fillRect( new Rectangle(nrp/8+i*nrp, v, nrp/2+nrp/4, rc*2-v), 0xFF000000 | _audioFillColor);
				bitmapData.fillRect( new Rectangle(nrp/8+i*nrp, v, nrp/2+nrp/4, 1), 0xFF000000 | _audioLineColor );
			}
		}
	}
}