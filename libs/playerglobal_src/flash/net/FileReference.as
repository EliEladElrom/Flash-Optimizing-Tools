package flash.net
{
    import flash.events.*;
    import flash.utils.*;

    public class FileReference extends EventDispatcher {

        public function FileReference() {
            return;
        }
        public function upload(request:URLRequest, uploadDataFieldName:String = "Filedata", testUpload:Boolean = false) : void;

        private function _load(dest:ByteArray) : void;

        public function load() : void {
            this._load(new ByteArray());
            return;
        }
        public function get size() : uint;

        public function get type() : String;

        public function browse(typeFilter:Array = null) : Boolean;

        public function get name() : String;

        public function get creator() : String;

        public function get creationDate() : Date;

        public function download(request:URLRequest, defaultFileName:String = null) : void;

        public function get modificationDate() : Date;

        public function get data() : ByteArray;

        public function cancel() : void;

        private function _save(data:ByteArray, defaultFileName:String) : void;

        public function save(data, defaultFileName:String = null) : void {
            var data:* = data;
            var defaultFileName:* = defaultFileName;
            var d:* = new ByteArray();
            if (data == null){
                throw new ArgumentError("data");
            }
            if (data is String){
                d.writeUTFBytes(data as String);
            }
            else if (data is XML){
                d.writeUTFBytes((data as XML).toXMLString());
            }
            else if (data is ByteArray){
                d.writeBytes(data as ByteArray);
            }
            else{
                try{
                    d.writeUTFBytes(data);
                }
                catch (e:Error){
                    throw new ArgumentError("data");
                }
            }
            d.position = 0;
            if (defaultFileName == null){
                defaultFileName;
            }
            this._save(d, defaultFileName);
            return;
        }
    }
}
