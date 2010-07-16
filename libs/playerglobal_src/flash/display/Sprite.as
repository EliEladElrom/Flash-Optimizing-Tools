package flash.display
{
    import flash.geom.*;
    import flash.media.*;

    public class Sprite extends DisplayObjectContainer {

        public function Sprite() {
            this.constructChildren();
            return;
        }
        public function get dropTarget() : DisplayObject;

        public function get soundTransform() : SoundTransform;

        private function constructChildren() : void;

        public function get hitArea() : Sprite;

        public function set buttonMode(value:Boolean) : void;

        public function get graphics() : Graphics;

        public function get useHandCursor() : Boolean;

        public function set hitArea(value:Sprite) : void;

        public function get buttonMode() : Boolean;

        public function stopDrag() : void;

        public function set useHandCursor(value:Boolean) : void;

        public function set soundTransform(sndTransform:SoundTransform) : void;

        public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null) : void;

    }
}
