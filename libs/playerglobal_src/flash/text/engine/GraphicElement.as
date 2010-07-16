package flash.text.engine
{
    import flash.display.*;
    import flash.events.*;

    final public class GraphicElement extends ContentElement {

        public function GraphicElement(graphic:DisplayObject = null, elementWidth:Number = 15, elementHeight:Number = 15, elementFormat:ElementFormat = null, eventMirror:EventDispatcher = null, textRotation:String = "rotate0") {
            super(elementFormat, eventMirror, textRotation);
            this.elementWidth = elementWidth;
            this.elementHeight = elementHeight;
            this.graphic = graphic;
            return;
        }
        public function set graphic(value:DisplayObject) : void;

        public function get elementHeight() : Number;

        public function set elementWidth(value:Number) : void;

        public function set elementHeight(value:Number) : void;

        public function get graphic() : DisplayObject;

        public function get elementWidth() : Number;

    }
}
