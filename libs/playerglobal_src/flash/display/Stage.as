package flash.display
{
    import flash.accessibility.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;

    public class Stage extends DisplayObjectContainer {

        public function Stage() {
            return;
        }
        override public function set tabIndex(value:int) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function set stageFocusRect(on:Boolean) : void;

        public function get align() : String;

        override public function willTrigger(type:String) : Boolean {
            this.requireOwnerPermissions();
            return super.willTrigger(type);
        }
        override public function set mouseChildren(value:Boolean) : void {
            this.requireOwnerPermissions();
            super.mouseChildren = value;
            return;
        }
        public function isFocusInaccessible() : Boolean;

        public function set stageHeight(value:int) : void;

        override public function hasEventListener(type:String) : Boolean {
            this.requireOwnerPermissions();
            return super.hasEventListener(type);
        }
        public function get scaleMode() : String;

        override public function addChildAt(child:DisplayObject, index:int) : DisplayObject {
            this.requireOwnerPermissions();
            return super.addChildAt(child, index);
        }
        public function get showDefaultContextMenu() : Boolean;

        override public function set width(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function set showDefaultContextMenu(value:Boolean) : void;

        override public function set name(value:String) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function setChildIndex(child:DisplayObject, index:int) : void {
            this.requireOwnerPermissions();
            super.setChildIndex(child, index);
            return;
        }
        public function set align(value:String) : void;

        public function set scaleMode(value:String) : void;

        override public function set scaleX(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function swapChildrenAt(index1:int, index2:int) : void;

        override public function set scaleY(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set scaleZ(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function get colorCorrection() : String;

        override public function set scrollRect(value:Rectangle) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function get numChildren() : int {
            this.requireOwnerPermissions();
            return super.numChildren;
        }
        override public function get height() : Number {
            this.requireOwnerPermissions();
            return super.height;
        }
        override public function set blendMode(value:String) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function get textSnapshot() : TextSnapshot {
            Error.throwError(IllegalOperationError, 2071);
            return null;
        }
        override public function set scale9Grid(value:Rectangle) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function get fullScreenWidth() : uint;

        public function set focus(newFocus:InteractiveObject) : void;

        public function get wmodeGPU() : Boolean;

        public function set fullScreenSourceRect(value:Rectangle) : void;

        override public function set rotationY(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function set quality(value:String) : void;

        override public function set rotationZ(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set rotationX(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set alpha(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set focusRect(value:Object) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set accessibilityImplementation(value:AccessibilityImplementation) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function set colorCorrection(value:String) : void;

        override public function get tabChildren() : Boolean {
            this.requireOwnerPermissions();
            return super.tabChildren;
        }
        override public function get mouseChildren() : Boolean {
            this.requireOwnerPermissions();
            return super.mouseChildren;
        }
        public function get stageHeight() : int;

        override public function set cacheAsBitmap(value:Boolean) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set mouseEnabled(value:Boolean) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set accessibilityProperties(value:AccessibilityProperties) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function invalidate() : void;

        override public function removeChildAt(index:int) : DisplayObject;

        override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void {
            this.requireOwnerPermissions();
            super.addEventListener(type, listener, useCapture, priority, useWeakReference);
            return;
        }
        override public function set height(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function dispatchEvent(event:Event) : Boolean {
            this.requireOwnerPermissions();
            return super.dispatchEvent(event);
        }
        public function set stageWidth(value:int) : void;

        override public function get width() : Number {
            this.requireOwnerPermissions();
            return super.width;
        }
        private function requireOwnerPermissions() : void;

        public function get focus() : InteractiveObject;

        public function set frameRate(value:Number) : void;

        override public function set contextMenu(value:ContextMenu) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set opaqueBackground(value:Object) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set mask(value:DisplayObject) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function get fullScreenSourceRect() : Rectangle;

        public function get fullScreenHeight() : uint;

        override public function set visible(value:Boolean) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function set displayState(value:String) : void;

        override public function set transform(value:Transform) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function get stageWidth() : int;

        public function get frameRate() : Number;

        public function get colorCorrectionSupport() : String;

        public function get displayState() : String;

        override public function set x(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set y(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set z(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set filters(value:Array) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function set tabChildren(value:Boolean) : void {
            this.requireOwnerPermissions();
            super.tabChildren = value;
            return;
        }
        override public function set tabEnabled(value:Boolean) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        override public function addChild(child:DisplayObject) : DisplayObject {
            this.requireOwnerPermissions();
            return super.addChild(child);
        }
        override public function set rotation(value:Number) : void {
            Error.throwError(IllegalOperationError, 2071);
            return;
        }
        public function get stageFocusRect() : Boolean;

        public function get quality() : String;

    }
}
