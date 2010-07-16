package flash.text.engine
{

    final public class FontDescription extends Object {

        public function FontDescription(fontName:String = "_serif", fontWeight:String = "normal", fontPosture:String = "normal", fontLookup:String = "device", renderingMode:String = "cff", cffHinting:String = "horizontalStem") {
            this.fontName = fontName;
            this.fontWeight = fontWeight;
            this.fontPosture = fontPosture;
            this.fontLookup = fontLookup;
            this.renderingMode = renderingMode;
            this.cffHinting = cffHinting;
            return;
        }
        public function set fontLookup(value:String) : void;

        public function get fontWeight() : String;

        public function get fontLookup() : String;

        public function get locked() : Boolean;

        public function set fontWeight(value:String) : void;

        public function get renderingMode() : String;

        public function set cffHinting(value:String) : void;

        public function set fontPosture(value:String) : void;

        public function set fontName(value:String) : void;

        public function get cffHinting() : String;

        public function get fontPosture() : String;

        public function get fontName() : String;

        public function set locked(value:Boolean) : void;

        public function clone() : FontDescription {
            return new FontDescription(this.fontName, this.fontWeight, this.fontPosture, this.fontLookup, this.renderingMode, this.cffHinting);
        }
        public function set renderingMode(value:String) : void;

        public static function isFontCompatible(fontName:String, fontWeight:String, fontPosture:String) : Boolean;

    }
}
