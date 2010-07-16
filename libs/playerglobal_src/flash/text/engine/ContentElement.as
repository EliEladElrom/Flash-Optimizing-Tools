package flash.text.engine
{
    import flash.events.*;

    public class ContentElement extends Object {
        public var userData:Object;
        public static const GRAPHIC_ELEMENT:uint = 65007;

        public function ContentElement(elementFormat:ElementFormat = null, eventMirror:EventDispatcher = null, textRotation:String = "rotate0") {
            if (getQualifiedClassName(this) == "flash.text.engine::ContentElement"){
                Error.throwError(ArgumentError, 2012, "ContentElement");
            }
            this.elementFormat = elementFormat;
            this.eventMirror = eventMirror;
            this.textRotation = textRotation;
            return;
        }
        public function get textBlock() : TextBlock;

        public function set elementFormat(value:ElementFormat) : void;

        public function get textBlockBeginIndex() : int;

        public function get textRotation() : String;

        public function get text() : String;

        public function set eventMirror(value:EventDispatcher) : void;

        public function get elementFormat() : ElementFormat;

        public function set textRotation(value:String) : void;

        public function get eventMirror() : EventDispatcher;

        public function get rawText() : String;

        public function get groupElement() : GroupElement;

    }
}
