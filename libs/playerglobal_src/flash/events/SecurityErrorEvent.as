package flash.events
{

    public class SecurityErrorEvent extends ErrorEvent {
        public static const SECURITY_ERROR:String = "securityError";

        public function SecurityErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "") {
            super(type, bubbles, cancelable, text);
            return;
        }
        override public function toString() : String {
            return formatToString("SecurityErrorEvent", "type", "bubbles", "cancelable", "eventPhase", "text");
        }
        override public function clone() : Event {
            return new SecurityErrorEvent(type, bubbles, cancelable, text);
        }
    }
}
