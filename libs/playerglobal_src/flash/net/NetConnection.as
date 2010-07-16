package flash.net
{
    import flash.events.*;

    public class NetConnection extends EventDispatcher {
        private static const kAddHeader:uint = 3;
        private static const kGetProtocol:uint = 6;
        private static const kGetFarID:uint = 8;
        private static const kCall:uint = 2;
        private static const kGetConnectedProxyType:uint = 4;
        private static const kGetNearNonce:uint = 9;
        private static const kGetNearID:uint = 7;
        private static const kGetFarNonce:uint = 10;
        private static const kGetUsingTLS:uint = 5;
        private static const kClose:uint = 1;
        private static const kConnect:uint = 0;

        public function NetConnection() {
            return;
        }
        public function get unconnectedPeerStreams() : Array;

        public function get nearID() : String;

        public function set objectEncoding(version:uint) : void;

        public function set maxPeerConnections(maxPeers:uint) : void;

        public function get protocol() : String;

        public function get proxyType() : String;

        public function get connected() : Boolean;

        public function connect(command:String, ... args) : void;

        public function get client() : Object;

        public function get uri() : String;

        private function invokeWithArgsArray(index:uint, args:Array);

        public function addHeader(operation:String, mustUnderstand:Boolean = false, param:Object = null) : void {
            var _loc_4:* = new Array(operation, mustUnderstand, param);
            this.invokeWithArgsArray(kAddHeader, _loc_4);
            return;
        }
        public function get maxPeerConnections() : uint;

        public function set proxyType(ptype:String) : void;

        private function invoke(index:uint, ... args);

        public function get objectEncoding() : uint;

        public function get nearNonce() : String;

        public function set client(object:Object) : void;

        public function get usingTLS() : Boolean;

        public function close() : void {
            this.invoke(kClose);
            return;
        }
        public function get farID() : String;

        public function get farNonce() : String;

        public function call(command:String, responder:Responder, ... args) : void {
            args.unshift(command, responder);
            this.invokeWithArgsArray(kCall, args);
            return;
        }
        public function get connectedProxyType() : String;

        public static function set defaultObjectEncoding(version:uint) : void;

        public static function get defaultObjectEncoding() : uint;

    }
}
