package flash.ui
{
    import flash.events.*;

    final public class ContextMenuItem extends EventDispatcher {

        public function ContextMenuItem(caption:String, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true) {
            this.caption = caption;
            this.separatorBefore = separatorBefore;
            this.enabled = enabled;
            this.visible = visible;
            return;
        }
        public function get enabled() : Boolean;

        public function set enabled(value:Boolean) : void;

        public function get separatorBefore() : Boolean;

        public function get caption() : String;

        public function set separatorBefore(value:Boolean) : void;

        public function get visible() : Boolean;

        public function set visible(value:Boolean) : void;

        public function set caption(value:String) : void;

        public function clone() : ContextMenuItem {
            var _loc_1:* = new ContextMenuItem(this.caption, this.separatorBefore, this.enabled, this.visible);
            return _loc_1;
        }
    }
}
