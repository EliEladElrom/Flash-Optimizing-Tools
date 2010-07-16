package flash.display
{
    import flash.accessibility.*;
    import flash.events.*;
    import flash.geom.*;

    public class DisplayObject extends EventDispatcher implements IBitmapDrawable {

        public function DisplayObject() {
            return;
        }
        public function get visible() : Boolean;

        public function get rotation() : Number;

        private function _hitTest(use_xy:Boolean, x:Number, y:Number, useShape:Boolean, hitTestObject:DisplayObject) : Boolean;

        public function localToGlobal(point:Point) : Point;

        public function get name() : String;

        public function set width(value:Number) : void;

        public function globalToLocal(point:Point) : Point;

        public function get blendMode() : String;

        public function get scale9Grid() : Rectangle;

        public function set name(value:String) : void;

        public function get rotationX() : Number;

        public function get rotationY() : Number;

        public function set scaleX(value:Number) : void;

        public function set scaleY(value:Number) : void;

        public function set scaleZ(value:Number) : void;

        public function get accessibilityProperties() : AccessibilityProperties;

        public function set scrollRect(value:Rectangle) : void;

        public function get rotationZ() : Number;

        public function get height() : Number;

        public function set blendMode(value:String) : void;

        public function set scale9Grid(innerRectangle:Rectangle) : void;

        public function getBounds(targetCoordinateSpace:DisplayObject) : Rectangle;

        public function set blendShader(value:Shader) : void;

        public function get opaqueBackground() : Object;

        public function get parent() : DisplayObjectContainer;

        public function get cacheAsBitmap() : Boolean;

        public function set rotationX(value:Number) : void;

        public function set rotationY(value:Number) : void;

        public function set rotationZ(value:Number) : void;

        public function local3DToGlobal(point3d:Vector3D) : Point;

        public function set alpha(value:Number) : void;

        public function globalToLocal3D(point:Point) : Vector3D;

        public function set accessibilityProperties(value:AccessibilityProperties) : void;

        public function get width() : Number;

        public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false) : Boolean {
            return this._hitTest(true, x, y, shapeFlag, null);
        }
        public function set cacheAsBitmap(value:Boolean) : void;

        public function get scaleX() : Number;

        public function get scaleY() : Number;

        public function get scaleZ() : Number;

        public function get scrollRect() : Rectangle;

        public function get mouseX() : Number;

        public function get mouseY() : Number;

        public function set height(value:Number) : void;

        public function set mask(value:DisplayObject) : void;

        public function getRect(targetCoordinateSpace:DisplayObject) : Rectangle;

        public function get alpha() : Number;

        public function set transform(value:Transform) : void;

        public function get loaderInfo() : LoaderInfo;

        public function get root() : DisplayObject;

        public function set visible(value:Boolean) : void;

        public function set opaqueBackground(value:Object) : void;

        public function hitTestObject(obj:DisplayObject) : Boolean {
            return this._hitTest(false, 0, 0, false, obj);
        }
        public function get mask() : DisplayObject;

        public function set x(value:Number) : void;

        public function set y(value:Number) : void;

        public function get transform() : Transform;

        public function set z(value:Number) : void;

        public function set filters(value:Array) : void;

        public function get x() : Number;

        public function get y() : Number;

        public function get z() : Number;

        public function get filters() : Array;

        public function set rotation(value:Number) : void;

        public function get stage() : Stage;

    }
}
