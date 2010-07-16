package flash.text.engine
{

    final public class SpaceJustifier extends TextJustifier {

        public function SpaceJustifier(locale:String = "en", lineJustification:String = "unjustified", letterSpacing:Boolean = false) {
            super(locale, lineJustification);
            this.letterSpacing = letterSpacing;
            return;
        }
        public function set letterSpacing(value:Boolean) : void;

        override public function clone() : TextJustifier {
            return new SpaceJustifier(this.locale, this.lineJustification, this.letterSpacing);
        }
        public function get letterSpacing() : Boolean;

    }
}
