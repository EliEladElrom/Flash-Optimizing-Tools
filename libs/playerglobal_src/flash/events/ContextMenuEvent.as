package flash.events
{
    import flash.display.*;

    public class ContextMenuEvent extends Event {
        private var m_mouseTarget:InteractiveObject;
        private var m_isMouseTargetInaccessible:Boolean;
        private var m_contextMenuOwner:InteractiveObject;
        public static const MENU_ITEM_SELECT:String = "menuItemSelect";
        public static const MENU_SELECT:String = "menuSelect";

        public function ContextMenuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, mouseTarget:InteractiveObject = null, contextMenuOwner:InteractiveObject = null) {
            super(type, bubbles, cancelable);
            this.m_mouseTarget = mouseTarget;
            this.m_contextMenuOwner = contextMenuOwner;
            return;
        }
        public function get contextMenuOwner() : InteractiveObject {
            return this.m_contextMenuOwner;
        }
        public function set isMouseTargetInaccessible(value:Boolean) : void {
            this.m_isMouseTargetInaccessible = value;
            return;
        }
        public function get isMouseTargetInaccessible() : Boolean {
            return this.m_isMouseTargetInaccessible;
        }
        public function set mouseTarget(value:InteractiveObject) : void {
            this.m_mouseTarget = value;
            return;
        }
        public function set contextMenuOwner(value:InteractiveObject) : void {
            this.m_contextMenuOwner = value;
            return;
        }
        public function get mouseTarget() : InteractiveObject {
            return this.m_mouseTarget;
        }
        override public function toString() : String {
            return formatToString("ContextMenuEvent", "type", "bubbles", "cancelable", "eventPhase", "mouseTarget", "contextMenuOwner");
        }
        override public function clone() : Event {
            return new ContextMenuEvent(type, bubbles, cancelable, this.m_mouseTarget, this.m_contextMenuOwner);
        }
    }
}
