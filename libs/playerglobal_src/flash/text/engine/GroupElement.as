package flash.text.engine
{
    import __AS3__.vec.*;
    import flash.events.*;

    final public class GroupElement extends ContentElement {

        public function GroupElement(elements:Vector.<ContentElement> = null, elementFormat:ElementFormat = null, eventMirror:EventDispatcher = null, textRotation:String = "rotate0") {
            super(elementFormat, eventMirror, textRotation);
            this.setElements(elements);
            return;
        }
        public function getElementAt(index:int) : ContentElement;

        public function getElementAtCharIndex(charIndex:int) : ContentElement;

        public function get elementCount() : int;

        public function getElementIndex(element:ContentElement) : int {
            var _loc_2:int = 0;
            while (_loc_2 < this.elementCount){
                
                if (element == this.getElementAt(_loc_2)){
                    return _loc_2;
                }
                _loc_2 = _loc_2 + 1;
            }
            return -1;
        }
        public function splitTextElement(elementIndex:int, splitIndex:int) : TextElement;

        public function groupElements(beginIndex:int, endIndex:int) : GroupElement;

        public function setElements(value:Vector.<ContentElement>) : void;

        public function replaceElements(beginIndex:int, endIndex:int, newElements:Vector.<ContentElement>) : Vector.<ContentElement>;

        public function mergeTextElements(beginIndex:int, endIndex:int) : TextElement;

        public function ungroupElements(groupIndex:int) : void;

    }
}
