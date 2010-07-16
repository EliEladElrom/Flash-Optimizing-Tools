package flash.net
{
    import flash.events.*;
    import flash.media.*;

    public class NetStream extends EventDispatcher {
        private static const kSetBufferTime:uint = 4;
        private static const kGetAudioCodecID:uint = 313;
        private static const kGetMaxPauseBufferTime:Object = 400;
        private static const kSetAudioCodecID:uint = 314;
        private static const kSend:uint = 3;
        private static const kSetMaxPauseBufferTime:Object = 401;
        private static const kGetTotalFrames:uint = 307;
        private static const kGetFarNonce:uint = 342;
        private static const kAttachAudio:uint = 1;
        private static const kSetTotalFrames:uint = 308;
        private static const kGetInfo:uint = 343;
        public static const CONNECT_TO_FMS:String = "connectToFMS";
        private static const kGetVideoCodecID:uint = 311;
        private static const kGetFarID:uint = 340;
        private static const kAttachVideo:uint = 2;
        private static const kClose:uint = 0;
        private static const kGetBufferLength:uint = 303;
        private static const kGetLiveDelay:uint = 304;
        private static const kSetVideoCodecID:uint = 312;
        private static const kGetTime:uint = 300;
        public static const DIRECT_CONNECTIONS:String = "directConnections";
        private static const kGetBytesTotal:uint = 306;
        private static const kGetBytesLoaded:uint = 305;
        private static const kCall:uint = 202;
        private static const kGetBufferTime:uint = 302;
        private static const kGetCurrentFps:uint = 301;
        private static const kGetNearNonce:uint = 341;

        public function NetStream(connection:NetConnection, peerID:String = "connectToFMS") {
            this.construct(connection, peerID);
            if (peerID == CONNECT_TO_FMS){
                connection.call("createStream", new Responder(this.onResult, this.onStatus));
            }
            return;
        }
        private function onStatus(info) : void {
            dispatchEvent(new NetStatusEvent("status", false, false, info));
            return;
        }
        public function set soundTransform(sndTransform:SoundTransform) : void;

        public function togglePause() : void {
            this.call(this, "pause", null, undefined, this.time * 1000);
            return;
        }
        public function set maxPauseBufferTime(pauseBufferTime:Number) : void {
            this.invoke(kSetMaxPauseBufferTime, pauseBufferTime);
            return;
        }
        public function get maxPauseBufferTime() : Number {
            return this.invoke(kGetMaxPauseBufferTime);
        }
        public function seek(offset:Number) : void {
            this.call(this, "seek", null, offset * 1000);
            return;
        }
        public function send(handlerName:String, ... args) : void {
            args.unshift(handlerName);
            this.invokeWithArgsArray(kSend, args);
            return;
        }
        public function get peerStreams() : Array;

        public function attachCamera(theCamera:Camera, snapshotMilliseconds:int = -1) : void {
            this.invoke(kAttachVideo, theCamera, snapshotMilliseconds);
            return;
        }
        public function get client() : Object;

        private function invokeWithArgsArray(index:uint, p_arguments:Array);

        public function publish(name:String = null, type:String = null) : void {
            if (type){
                this.call(this, "publish", null, name, type);
            }
            else{
                this.call(this, "publish", null, name);
            }
            return;
        }
        public function get bytesLoaded() : uint {
            return this.invoke(kGetBytesLoaded);
        }
        public function attachAudio(microphone:Microphone) : void {
            this.invoke(kAttachAudio, microphone);
            return;
        }
        public function get time() : Number {
            return this.invoke(kGetTime);
        }
        public function get bufferLength() : Number {
            return this.invoke(kGetBufferLength);
        }
        public function set client(object:Object) : void;

        private function construct(connection:NetConnection, peerID:String) : void;

        public function receiveVideo(flag:Boolean) : void {
            this.call(this, "receiveVideo", null, flag);
            return;
        }
        public function get bytesTotal() : uint {
            return this.invoke(kGetBytesTotal);
        }
        public function set bufferTime(bufferTime:Number) : void {
            this.invoke(kSetBufferTime, bufferTime);
            return;
        }
        public function get videoCodec() : uint {
            return this.invoke(kGetVideoCodecID);
        }
        private function onResult(streamId:int) : void;

        public function get soundTransform() : SoundTransform;

        private function call(stream:NetStream, command:String, responder:Responder, ... args) : void {
            args.unshift(stream, command, responder);
            this.invokeWithArgsArray(kCall, args);
            return;
        }
        public function get farNonce() : String;

        public function get audioCodec() : uint {
            return this.invoke(kGetAudioCodecID);
        }
        public function onPeerConnect(subscriber:NetStream) : Boolean {
            return true;
        }
        public function get nearNonce() : String;

        public function set checkPolicyFile(state:Boolean) : void;

        public function get bufferTime() : Number {
            return this.invoke(kGetBufferTime);
        }
        public function get info() : NetStreamInfo;

        public function get currentFPS() : Number {
            return this.invoke(kGetCurrentFps);
        }
        public function receiveVideoFPS(FPS:Number) : void {
            this.call(this, "receiveVideo", null, FPS);
            return;
        }
        public function get objectEncoding() : uint;

        public function receiveAudio(flag:Boolean) : void {
            this.call(this, "receiveAudio", null, flag);
            return;
        }
        public function resume() : void {
            this.call(this, "pause", null, false, this.time * 1000);
            return;
        }
        public function pause() : void {
            this.call(this, "pause", null, true, this.time * 1000);
            return;
        }
        public function get liveDelay() : Number {
            return this.invoke(kGetLiveDelay);
        }
        private function invoke(index:uint, ... args);

        public function get farID() : String;

        public function play(... args) : void;

        public function get decodedFrames() : uint {
            return this.invoke(kGetTotalFrames);
        }
        public function get checkPolicyFile() : Boolean;

        public function play2(param:NetStreamPlayOptions) : void;

        public function close() : void {
            this.invoke(kClose);
            return;
        }
    }
}
