package flash.media
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class Sound extends EventDispatcher {

        public function Sound(stream:URLRequest = null, context:SoundLoaderContext = null) {
            this.load(stream, context);
            return;
        }
        public function extract(target:ByteArray, length:Number, startPosition:Number = -1) : Number;

        private function _load(stream:URLRequest, checkPolicyFile:Boolean, bufferTime:Number) : void;

        public function load(stream:URLRequest, context:SoundLoaderContext = null) : void {
            var _loc_3:* = this._buildLoaderContext(context);
            this._load(stream, _loc_3.checkPolicyFile, _loc_3.bufferTime);
            return;
        }
        public function close() : void;

        private function _buildLoaderContext(context:SoundLoaderContext) : SoundLoaderContext {
            if (context == null){
                context = new SoundLoaderContext();
            }
            return context;
        }
        public function get url() : String;

        public function get bytesLoaded() : uint;

        public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null) : SoundChannel;

        public function get length() : Number;

        public function get id3() : ID3Info;

        public function get bytesTotal() : int;

        public function get isBuffering() : Boolean;

    }
}
