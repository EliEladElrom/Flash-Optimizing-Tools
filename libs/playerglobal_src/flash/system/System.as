package flash.system
{

    final public class System extends Object {
        private static var theIME:IME = null;

        public function System() {
            return;
        }
        public static function get ime() : IME {
            if (!theIME){
                IME.constructOK = true;
                theIME = new IME();
                IME.constructOK = false;
            }
            return theIME;
        }
        public static function get useCodePage() : Boolean;

        public static function get totalMemory() : uint;

        public static function set useCodePage(value:Boolean) : void;

        public static function get vmVersion() : String;

        public static function resume() : void;

        public static function setClipboard(string:String) : void;

        public static function pause() : void;

        public static function gc() : void;

        public static function exit(code:uint) : void;

    }
}
