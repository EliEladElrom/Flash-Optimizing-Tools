package flash.xml
{

    final class XMLParser extends Object {

        function XMLParser() {
            return;
        }
        public function getNext(tag:XMLTag) : int;

        public function startParse(source:String, ignoreWhite:Boolean) : void;

    }
}
