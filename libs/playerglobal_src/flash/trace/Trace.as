package flash.trace
{

    public class Trace extends Object {
        public static const METHODS_AND_LINES_WITH_ARGS:int = 4;
        public static const METHODS_AND_LINES:int = 3;
        public static const OFF:int = 0;
        public static const METHODS_WITH_ARGS:int = 2;
        public static const METHODS:int = 1;
        public static const LISTENER:Object = 2;
        public static const FILE:Object = 1;

        public function Trace() {
            return;
        }
        public static function getListener() : Function;

        public static function getLevel(target:int = 2) : int;

        public static function setLevel(l:int, target:int = 2);

        public static function setListener(f:Function);

    }
}
