package flash.text.engine
{
    import flash.events.*;

    final public class TextElement extends ContentElement {

        public function TextElement(text:String = null, elementFormat:ElementFormat = null, eventMirror:EventDispatcher = null, textRotation:String = "rotate0") {
            super(elementFormat, eventMirror, textRotation);
            this.text = text;
            return;
        }
        public function replaceText(beginIndex:int, endIndex:int, newText:String) : void;

        public function set text(value:String) : void;

    }
}
