package flash.media
{
    import flash.events.*;

    final public class Microphone extends EventDispatcher {

        public function Microphone() {
            return;
        }
        public function set rate(rate:int) : void;

        public function set soundTransform(sndTransform:SoundTransform) : void;

        public function get silenceLevel() : Number;

        public function setSilenceLevel(silenceLevel:Number, timeout:int = -1) : void;

        public function get gain() : Number;

        public function get rate() : int;

        public function setUseEchoSuppression(useEchoSuppression:Boolean) : void;

        public function get muted() : Boolean;

        public function set codec(codec:String) : void;

        public function set gain(gain:Number) : void;

        public function get useEchoSuppression() : Boolean;

        public function get silenceTimeout() : int;

        public function get encodeQuality() : int;

        public function set encodeQuality(quality:int) : void;

        public function setLoopBack(state:Boolean = true) : void;

        public function get activityLevel() : Number;

        public function get codec() : String;

        public function get index() : int;

        public function get name() : String;

        public function get soundTransform() : SoundTransform;

        public function set framesPerPacket(frames:int) : void;

        public function get framesPerPacket() : int;

        public static function getMicrophone(index:int = -1) : Microphone;

        public static function get names() : Array;

    }
}
