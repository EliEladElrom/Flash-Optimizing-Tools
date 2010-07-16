package flash.text.engine
{

    final public class EastAsianJustifier extends TextJustifier {

        public function EastAsianJustifier(locale:String = "ja", lineJustification:String = "allButLast", justificationStyle:String = "pushInKinsoku") {
            super(locale, lineJustification);
            this.justificationStyle = justificationStyle;
            return;
        }
        override public function clone() : TextJustifier {
            return new EastAsianJustifier(this.locale, this.lineJustification, this.justificationStyle);
        }
        public function set justificationStyle(value:String) : void;

        public function get justificationStyle() : String;

    }
}
