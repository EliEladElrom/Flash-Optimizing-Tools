package flash.xml
{

    final class XMLTag extends Object {

        function XMLTag() {
            return;
        }
        public function get value() : String;

        public function set value(v:String) : void;

        public function set type(value:uint) : void;

        public function get type() : uint;

        public function set empty(value:Boolean) : void;

        public function set attrs(value:Object) : void;

        public function get empty() : Boolean;

        public function get attrs() : Object;

    }
}
