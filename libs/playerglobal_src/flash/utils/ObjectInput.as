package flash.utils
{

    class ObjectInput extends Object implements IDataInput {

        function ObjectInput() {
            return;
        }
        public function readUnsignedInt() : uint;

        public function readByte() : int;

        public function readShort() : int;

        public function readDouble() : Number;

        public function readBoolean() : Boolean;

        public function readUnsignedByte() : uint;

        public function get objectEncoding() : uint;

        public function readObject();

        public function readUnsignedShort() : uint;

        public function get endian() : String;

        public function get bytesAvailable() : uint;

        public function set objectEncoding(version:uint) : void;

        public function readMultiByte(length:uint, charSet:String) : String;

        public function readFloat() : Number;

        public function readUTF() : String;

        public function set endian(type:String) : void;

        public function readInt() : int;

        public function readUTFBytes(length:uint) : String;

        public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void;

    }
}
