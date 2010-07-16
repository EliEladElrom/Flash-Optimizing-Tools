package flash.net
{
    import flash.events.*;
    import flash.utils.*;

    public class URLStream extends EventDispatcher implements IDataInput {

        public function URLStream() {
            return;
        }
        public function readUnsignedInt() : uint;

        public function readDouble() : Number;

        public function readFloat() : Number;

        public function readBoolean() : Boolean;

        public function readShort() : int;

        public function get connected() : Boolean;

        public function readUnsignedShort() : uint;

        public function readUnsignedByte() : uint;

        public function get objectEncoding() : uint;

        public function readObject();

        public function get endian() : String;

        public function get bytesAvailable() : uint;

        public function set objectEncoding(version:uint) : void;

        public function load(request:URLRequest) : void;

        public function readMultiByte(length:uint, charSet:String) : String;

        public function readUTF() : String;

        public function set endian(type:String) : void;

        public function readInt() : int;

        public function readUTFBytes(length:uint) : String;

        public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void;

        public function readByte() : int;

        public function close() : void;

    }
}
