package flash.net
{
    import flash.events.*;
    import flash.utils.*;

    public class Socket extends EventDispatcher implements IDataInput, IDataOutput {
        private var _timeoutEvent:SecurityErrorEvent;
        private var _timeout:uint;
        private var _timeoutTimer:Timer;
        private static const MIN_TIMEOUT:Object = 250;

        public function Socket(host:String = null, port:int = 0) {
            this._init();
            if (host != null){
                this.connect(host, port);
            }
            return;
        }
        private function onTimeout(event:TimerEvent) : void {
            this._timeoutTimer.stop();
            if (this.didFailureOccur()){
                dispatchEvent(this._timeoutEvent);
            }
            else if (!this.connected){
                dispatchEvent(this._timeoutEvent);
            }
            return;
        }
        public function writeUTFBytes(value:String) : void;

        public function flush() : void;

        public function writeObject(object) : void;

        public function writeByte(value:int) : void;

        public function get connected() : Boolean;

        public function readShort() : int;

        public function readUnsignedShort() : uint;

        public function readDouble() : Number;

        public function writeInt(value:int) : void;

        public function get endian() : String;

        public function set objectEncoding(version:uint) : void;

        public function get bytesAvailable() : uint;

        private function didFailureOccur() : Boolean;

        public function writeDouble(value:Number) : void;

        public function readObject();

        public function readUTF() : String;

        public function set endian(type:String) : void;

        private function internalGetSecurityErrorMessage(host:String, port:int) : String;

        public function readBoolean() : Boolean;

        public function readUTFBytes(length:uint) : String;

        private function internalClose() : void;

        public function writeFloat(value:Number) : void;

        public function set timeout(value:uint) : void {
            if (value < MIN_TIMEOUT){
                this._timeout = MIN_TIMEOUT;
            }
            else{
                this._timeout = value;
            }
            return;
        }
        public function readByte() : int;

        public function writeUTF(value:String) : void;

        public function writeBoolean(value:Boolean) : void;

        public function get objectEncoding() : uint;

        public function readUnsignedInt() : uint;

        public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void;

        public function writeMultiByte(value:String, charSet:String) : void;

        public function readUnsignedByte() : uint;

        public function get timeout() : uint {
            return this._timeout;
        }
        public function writeUnsignedInt(value:uint) : void;

        public function writeShort(value:int) : void;

        public function readFloat() : Number;

        public function connect(host:String, port:int) : void {
            this._init();
            this._timeoutEvent = new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR, false, false, this.internalGetSecurityErrorMessage(host, port));
            this._timeoutTimer.reset();
            this._timeoutTimer.delay = this._timeout;
            this._timeoutTimer.start();
            this.internalConnect(host, port);
            return;
        }
        public function readMultiByte(length:uint, charSet:String) : String;

        private function internalConnect(host:String, port:int) : void;

        private function _init() : void {
            if (this._timeoutTimer){
                return;
            }
            this._timeout = 20000;
            this._timeoutTimer = new Timer(this._timeout);
            this._timeoutTimer.addEventListener(TimerEvent.TIMER, this.onTimeout);
            return;
        }
        public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void;

        public function close() : void {
            this._init();
            this._timeoutTimer.stop();
            this._timeoutTimer.reset();
            this.internalClose();
            return;
        }
        public function readInt() : int;

    }
}
