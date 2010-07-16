package flash.net
{

    final public class FileFilter extends Object {

        public function FileFilter(description:String, extension:String, macType:String = null) {
            this.description = description;
            this.extension = extension;
            this.macType = macType;
            return;
        }
        public function set macType(value:String) : void;

        public function set description(value:String) : void;

        public function get macType() : String;

        public function get description() : String;

        public function set extension(value:String) : void;

        public function get extension() : String;

    }
}
