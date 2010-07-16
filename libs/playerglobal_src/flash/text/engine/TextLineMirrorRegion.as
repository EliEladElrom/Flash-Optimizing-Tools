package flash.text.engine
{
    import flash.events.*;
    import flash.geom.*;

    final public class TextLineMirrorRegion extends Object {

        public function TextLineMirrorRegion() {
            return;
        }
        public function get textLine() : TextLine;

        public function get bounds() : Rectangle;

        public function get nextRegion() : TextLineMirrorRegion;

        public function get previousRegion() : TextLineMirrorRegion;

        public function get element() : ContentElement;

        public function get mirror() : EventDispatcher;

    }
}
