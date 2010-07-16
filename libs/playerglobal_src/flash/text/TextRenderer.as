package flash.text
{

    final public class TextRenderer extends Object {

        public function TextRenderer() {
            return;
        }
        public static function set maxLevel(value:int) : void;

        public static function get displayMode() : String;

        public static function setAdvancedAntiAliasingTable(fontName:String, fontStyle:String, colorType:String, advancedAntiAliasingTable:Array) : void;

        public static function get maxLevel() : int;

        public static function get antiAliasType() : String;

        public static function set displayMode(value:String) : void;

        public static function set antiAliasType(value:String) : void;

    }
}
