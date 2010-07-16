package flash.accessibility
{
    import flash.display.*;

    final public class Accessibility extends Object {

        public function Accessibility() {
            return;
        }
        public static function sendEvent(source:DisplayObject, childID:uint, eventType:uint, nonHTML:Boolean = false) : void;

        public static function updateProperties() : void;

        public static function get active() : Boolean;

    }
}
