package flash.net
{
    import flash.events.*;

    public class SharedObject extends EventDispatcher {
        private static const kClear:uint = 6;
        private static const kSetFps:uint = 5;
        private static const kGetSize:uint = 4;
        private static const kClose:uint = 3;
        private static const kFlush:uint = 2;
        private static const kSend:uint = 1;
        private static const kConnect:uint = 0;

        public function SharedObject() {
            return;
        }
        public function get size() : uint {
            return uint(this.invoke(kGetSize));
        }
        public function flush(minDiskSpace:int = 0) : String {
            var _loc_2:* = this.invoke(kFlush, minDiskSpace);
            if (_loc_2 == true){
                return SharedObjectFlushStatus.FLUSHED;
            }
            if (_loc_2 == "pending"){
                return SharedObjectFlushStatus.PENDING;
            }
            Error.throwError(Error, 2130);
            return null;
        }
        public function send(... args) : void {
            this.invokeWithArgsArray(kSend, args);
            return;
        }
        public function get data() : Object;

        public function get client() : Object;

        public function clear() : void {
            this.invoke(kClear);
            return;
        }
        public function setDirty(propertyName:String) : void;

        public function connect(myConnection:NetConnection, params:String = null) : void {
            if (!Boolean(this.invoke(kConnect, myConnection, params))){
                Error.throwError(Error, 2139);
            }
            return;
        }
        public function set fps(updatesPerSecond:Number) : void {
            this.invoke(kSetFps, updatesPerSecond);
            return;
        }
        public function set objectEncoding(version:uint) : void;

        public function set client(object:Object) : void;

        public function setProperty(propertyName:String, value:Object = null) : void {
            if (this.data[propertyName] != value){
                this.data[propertyName] = value;
                this.setDirty(propertyName);
            }
            return;
        }
        public function close() : void {
            this.invoke(kClose);
            return;
        }
        public function get objectEncoding() : uint;

        private function invokeWithArgsArray(index:uint, args:Array);

        private function invoke(index:uint, ... args);

        public static function set defaultObjectEncoding(version:uint) : void;

        public static function getDiskUsage(url:String) : int;

        public static function get defaultObjectEncoding() : uint;

        public static function getLocal(name:String, localPath:String = null, secure:Boolean = false) : SharedObject;

        public static function deleteAll(url:String) : int;

        public static function getRemote(name:String, remotePath:String = null, persistence:Object = false, secure:Boolean = false) : SharedObject;

    }
}
