package flash.media
{
    import flash.events.*;

    final public class SoundChannel extends EventDispatcher {

        public function SoundChannel() {
            return;
        }
        public function stop() : void;

        public function get leftPeak() : Number;

        public function get position() : Number;

        public function set soundTransform(sndTransform:SoundTransform) : void;

        public function get rightPeak() : Number;

        public function get soundTransform() : SoundTransform;

    }
}
