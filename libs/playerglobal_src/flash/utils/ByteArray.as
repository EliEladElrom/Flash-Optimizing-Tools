package flash.utils
{

    public class ByteArray extends Object implements IDataInput, IDataOutput {

        public function ByteArray() {
            return;
        }
        public function writeUTFBytes(value:String) : void;

        public function readShort() : int;

        public function writeByte(value:int) : void;

        public function writeDouble(value:Number) : void;

        public function readUnsignedShort() : uint;

        public function readDouble() : Number;

        public function writeInt(value:int) : void;

        private function _uncompress(algorithm:String) : void;

        public function get endian() : String;

        public function get bytesAvailable() : uint;

        public function readObject();

        public function deflate() : void {
            this._compress("deflate");
            return;
        }
        public function get position() : uint;

        public function readBoolean() : Boolean;

        public function inflate() : void {
            this._uncompress("deflate");
            return;
        }
        public function set endian(type:String) : void;

        public function readUTF() : String;

        public function readUTFBytes(length:uint) : String;

        public function writeFloat(value:Number) : void;

        public function writeMultiByte(value:String, charSet:String) : void;

        public function readUnsignedInt() : uint;

        public function readByte() : int;

        public function get objectEncoding() : uint;

        public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void;

        public function clear() : void;

        public function writeUTF(value:String) : void;

        public function writeBoolean(value:Boolean) : void;

        public function set position(offset:uint) : void;

        private function _compress(algorithm:String) : void;

        public function readUnsignedByte() : uint;

        public function writeUnsignedInt(value:uint) : void;

        public function writeShort(value:int) : void;

        public function get length() : uint;

        public function compress() : void {
            this._compress("zlib");
            return;
        }
        public function toString() : String;

        public function set length(value:uint) : void;

        public function set objectEncoding(version:uint) : void;

        public function readFloat() : Number;

        public function readInt() : int;

        public function readMultiByte(length:uint, charSet:String) : String;

        public function uncompress() : void {
            this._uncompress("zlib");
            return;
        }
        public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void;

        public function writeObject(object) : void;

        public static function get defaultObjectEncoding() : uint;

        public static function set defaultObjectEncoding(version:uint) : void;

    }
}
