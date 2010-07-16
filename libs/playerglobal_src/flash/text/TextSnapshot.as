package flash.text
{

    public class TextSnapshot extends Object {

        public function TextSnapshot() {
            return;
        }
        public function getSelected(beginIndex:int, endIndex:int) : Boolean;

        public function getText(beginIndex:int, endIndex:int, includeLineEndings:Boolean = false) : String;

        public function setSelected(beginIndex:int, endIndex:int, select:Boolean) : void;

        public function setSelectColor(hexColor:uint = 16776960) : void;

        public function findText(beginIndex:int, textToFind:String, caseSensitive:Boolean) : int;

        public function get charCount() : int;

        public function hitTestTextNearPos(x:Number, y:Number, maxDistance:Number = 0) : Number;

        public function getTextRunInfo(beginIndex:int, endIndex:int) : Array;

        public function getSelectedText(includeLineEndings:Boolean = false) : String;

    }
}
