package flash.text.engine
{

    final public class TabStop extends Object {

        public function TabStop(alignment:String = "start", position:Number = 0, decimalAlignmentToken:String = "") {
            this.alignment = alignment;
            this.position = position;
            this.decimalAlignmentToken = decimalAlignmentToken;
            return;
        }
        public function set position(value:Number) : void;

        public function get alignment() : String;

        public function set alignment(value:String) : void;

        public function get decimalAlignmentToken() : String;

        public function get position() : Number;

        public function set decimalAlignmentToken(value:String) : void;

    }
}
