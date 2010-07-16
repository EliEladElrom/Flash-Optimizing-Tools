package flash.events
{

    public class ErrorEvent extends TextEvent {
        public static const ERROR:String = "error";

        public function ErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "") {
            super(type, bubbles, cancelable, text);
            return;
        }
        override public function toString() : String {
            return formatToString("ErrorEvent", "type", "bubbles", "cancelable", "eventPhase", "text");
        }
        override public function clone() : Event {
            return new ErrorEvent(type, bubbles, cancelable, text);
        }
    }
}
