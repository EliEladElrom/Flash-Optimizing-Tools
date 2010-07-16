package flash.display
{
    import flash.geom.*;
    import flash.text.*;

    public class DisplayObjectContainer extends InteractiveObject {

        public function DisplayObjectContainer();

        public function get mouseChildren() : Boolean;

        public function get numChildren() : int;

        public function contains(child:DisplayObject) : Boolean;

        public function swapChildrenAt(index1:int, index2:int) : void;

        public function getChildByName(name:String) : DisplayObject;

        public function removeChildAt(index:int) : DisplayObject;

        public function getChildIndex(child:DisplayObject) : int;

        public function addChildAt(child:DisplayObject, index:int) : DisplayObject;

        public function set tabChildren(enable:Boolean) : void;

        public function get textSnapshot() : TextSnapshot;

        public function swapChildren(child1:DisplayObject, child2:DisplayObject) : void;

        public function get tabChildren() : Boolean;

        public function getObjectsUnderPoint(point:Point) : Array;

        public function set mouseChildren(enable:Boolean) : void;

        public function removeChild(child:DisplayObject) : DisplayObject;

        public function getChildAt(index:int) : DisplayObject;

        public function addChild(child:DisplayObject) : DisplayObject;

        public function areInaccessibleObjectsUnderPoint(point:Point) : Boolean;

        public function setChildIndex(child:DisplayObject, index:int) : void;

    }
}
