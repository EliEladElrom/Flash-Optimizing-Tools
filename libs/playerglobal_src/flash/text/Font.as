package flash.text
{

    public class Font extends Object {

        public function Font() {
            return;
        }
        public function get fontType() : String;

        public function get fontStyle() : String;

        public function get fontName() : String;

        public function hasGlyphs(str:String) : Boolean;

        public static function enumerateFonts(enumerateDeviceFonts:Boolean = false) : Array;

        public static function registerFont(font:Class) : void;

    }
}
