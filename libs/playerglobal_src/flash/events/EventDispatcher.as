package flash.events
{

    public class EventDispatcher extends Object implements IEventDispatcher {

        public function EventDispatcher(target:IEventDispatcher = null);

        public function dispatchEvent(event:Event) : Boolean {
            if (event.target){
                return this.dispatchEventFunction(event.clone());
            }
            return this.dispatchEventFunction(event);
        }
        public function willTrigger(type:String) : Boolean;

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void;

        public function toString() : String {
            return Object.prototype.toString.call(this);
        }
        private function dispatchEventFunction(event:Event) : Boolean;

        public function hasEventListener(type:String) : Boolean;

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;

        private function get listeners() : Array;

    }
}
