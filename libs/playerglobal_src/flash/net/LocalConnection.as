package flash.net
{
    import flash.events.*;

    public class LocalConnection extends EventDispatcher {

        public function LocalConnection() {
            return;
        }
        public function get domain() : String;

        public function set client(client:Object) : void;

        public function close() : void;

        public function allowInsecureDomain(... args) : void;

        public function connect(connectionName:String) : void;

        public function get client() : Object;

        public function set isPerUser(newValue:Boolean) : void;

        public function allowDomain(... args) : void;

        public function get isPerUser() : Boolean;

        public function send(connectionName:String, methodName:String, ... args) : void;

    }
}
