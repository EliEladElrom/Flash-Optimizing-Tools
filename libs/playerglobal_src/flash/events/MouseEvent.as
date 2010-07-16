package flash.events
{
    import flash.display.*;

    public class MouseEvent extends Event {
        private var m_buttonDown:Boolean;
        private var m_altKey:Boolean;
        private var m_shiftKey:Boolean;
        private var m_ctrlKey:Boolean;
        private var m_delta:int;
        private var m_isRelatedObjectInaccessible:Boolean;
        private var m_relatedObject:InteractiveObject;
        public static const MOUSE_WHEEL:String = "mouseWheel";
        public static const MOUSE_MOVE:String = "mouseMove";
        public static const ROLL_OUT:String = "rollOut";
        public static const MOUSE_OVER:String = "mouseOver";
        public static const CLICK:String = "click";
        public static const MOUSE_OUT:String = "mouseOut";
        public static const MOUSE_UP:String = "mouseUp";
        public static const DOUBLE_CLICK:String = "doubleClick";
        public static const MOUSE_DOWN:String = "mouseDown";
        public static const ROLL_OVER:String = "rollOver";

        public function MouseEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, localX:Number = , localY:Number = , relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0) {
            super(type, bubbles, cancelable);
            this.localX = localX;
            this.localY = localY;
            this.m_relatedObject = relatedObject;
            this.m_ctrlKey = ctrlKey;
            this.m_altKey = altKey;
            this.m_shiftKey = shiftKey;
            this.m_buttonDown = buttonDown;
            this.m_delta = delta;
            return;
        }
        public function get isRelatedObjectInaccessible() : Boolean {
            return this.m_isRelatedObjectInaccessible;
        }
        public function get buttonDown() : Boolean {
            return this.m_buttonDown;
        }
        public function set isRelatedObjectInaccessible(value:Boolean) : void {
            this.m_isRelatedObjectInaccessible = value;
            return;
        }
        public function updateAfterEvent() : void;

        public function get relatedObject() : InteractiveObject {
            return this.m_relatedObject;
        }
        public function get localX() : Number;

        public function get localY() : Number;

        private function getStageY() : Number;

        public function set relatedObject(value:InteractiveObject) : void {
            this.m_relatedObject = value;
            return;
        }
        private function getStageX() : Number;

        public function set localX(value:Number) : void;

        public function get stageY() : Number {
            if (!isNaN(this.localX)){
                isNaN(this.localX);
            }
            if (isNaN(this.localY)){
                return Number.NaN;
            }
            return this.getStageY();
        }
        public function set localY(value:Number) : void;

        override public function clone() : Event {
            return new MouseEvent(type, bubbles, cancelable, this.localX, this.localY, this.m_relatedObject, this.m_ctrlKey, this.m_altKey, this.m_shiftKey, this.m_buttonDown, this.m_delta);
        }
        public function get stageX() : Number {
            if (!isNaN(this.localX)){
                isNaN(this.localX);
            }
            if (isNaN(this.localY)){
                return Number.NaN;
            }
            return this.getStageX();
        }
        public function set ctrlKey(value:Boolean) : void {
            this.m_ctrlKey = value;
            return;
        }
        override public function toString() : String {
            return formatToString("MouseEvent", "type", "bubbles", "cancelable", "eventPhase", "localX", "localY", "stageX", "stageY", "relatedObject", "ctrlKey", "altKey", "shiftKey", "buttonDown", "delta");
        }
        public function set buttonDown(value:Boolean) : void {
            this.m_buttonDown = value;
            return;
        }
        public function get ctrlKey() : Boolean {
            return this.m_ctrlKey;
        }
        public function get altKey() : Boolean {
            return this.m_altKey;
        }
        public function set delta(value:int) : void {
            this.m_delta = value;
            return;
        }
        public function set shiftKey(value:Boolean) : void {
            this.m_shiftKey = value;
            return;
        }
        public function set altKey(value:Boolean) : void {
            this.m_altKey = value;
            return;
        }
        public function get shiftKey() : Boolean {
            return this.m_shiftKey;
        }
        public function get delta() : int {
            return this.m_delta;
        }
    }
}
