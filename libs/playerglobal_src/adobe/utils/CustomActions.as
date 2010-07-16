package adobe.utils
{

    final public class CustomActions extends Object {

        public function CustomActions() {
            return;
        }
        public static function installActions(name:String, data:String) : void;

        public static function uninstallActions(name:String) : void;

        public static function get actionsList() : Array;

        public static function getActions(name:String) : String;

    }
}
