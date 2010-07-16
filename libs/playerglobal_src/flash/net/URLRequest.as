package flash.net
{

    final public class URLRequest extends Object {

        public function URLRequest(url:String = null) {
            if (url != null){
                this.url = url;
            }
            this.requestHeaders = [];
            return;
        }
        private function shouldFilterHTTPHeader(header:String) : Boolean {
            return false;
        }
        public function get method() : String;

        public function set method(value:String) : void;

        public function get digest() : String;

        public function set contentType(value:String) : void;

        public function set digest(value:String) : void;

        public function get data() : Object;

        public function set requestHeaders(value:Array) : void;

        public function get url() : String;

        public function set data(value:Object) : void;

        public function get requestHeaders() : Array;

        public function get contentType() : String;

        public function set url(value:String) : void;

    }
}
