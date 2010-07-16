package flash.display
{

    dynamic public class MovieClip extends Sprite {

        public function MovieClip() {
            return;
        }
        public function get currentFrameLabel() : String;

        public function prevFrame() : void;

        public function stop() : void;

        public function get scenes() : Array;

        public function gotoAndPlay(frame:Object, scene:String = null) : void;

        public function set enabled(value:Boolean) : void;

        public function get totalFrames() : int;

        public function get framesLoaded() : int;

        public function get enabled() : Boolean;

        public function nextScene() : void;

        public function get currentFrame() : int;

        public function get currentScene() : Scene;

        public function gotoAndStop(frame:Object, scene:String = null) : void;

        public function addFrameScript(... args) : void;

        public function set trackAsMenu(value:Boolean) : void;

        public function prevScene() : void;

        public function nextFrame() : void;

        public function play() : void;

        public function get trackAsMenu() : Boolean;

        public function get currentLabel() : String;

        public function get currentLabels() : Array {
            return this.currentScene.labels;
        }
    }
}
