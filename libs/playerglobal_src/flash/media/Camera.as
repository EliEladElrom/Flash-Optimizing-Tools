package flash.media
{
    import flash.events.*;

    final public class Camera extends EventDispatcher {

        public function Camera() {
            return;
        }
        public function get loopback() : Boolean;

        public function setMode(width:int, height:int, fps:Number, favorArea:Boolean = true) : void;

        public function get width() : int;

        public function get height() : int;

        public function get fps() : Number;

        public function get name() : String;

        public function setMotionLevel(motionLevel:int, timeout:int = 2000) : void;

        public function get muted() : Boolean;

        public function get motionLevel() : int;

        public function get currentFPS() : Number;

        public function get bandwidth() : int;

        public function get index() : int;

        public function get keyFrameInterval() : int;

        public function setLoopback(compress:Boolean = false) : void;

        public function get activityLevel() : Number;

        public function setCursor(value:Boolean) : void;

        public function get motionTimeout() : int;

        public function setKeyFrameInterval(keyFrameInterval:int) : void;

        public function setQuality(bandwidth:int, quality:int) : void;

        public function get quality() : int;

        public static function get names() : Array;

        public static function getCamera(name:String = null) : Camera;

    }
}
