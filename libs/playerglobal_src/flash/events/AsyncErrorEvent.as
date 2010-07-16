package flash.events
{

    public class AsyncErrorEvent extends ErrorEvent {
        public var error:Error;
        public static const ASYNC_ERROR:String = "asyncError";

        public function AsyncErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", error:Error = null) {
            this.error = error;
            super(type, bubbles, cancelable, text);
            return;
        }
        override public function toString() : String {
            return formatToString("AsyncErrorEvent", "type", "bubbles", "cancelable", "eventPhase", "text", "error");
        }
        override public function clone() : Event {
            return new AsyncErrorEvent(type, bubbles, cancelable, text, this.error);
        }
    }
}
