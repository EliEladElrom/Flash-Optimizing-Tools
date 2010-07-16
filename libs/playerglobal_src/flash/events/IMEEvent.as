package flash.events
{

    public class IMEEvent extends TextEvent {
        public static const IME_COMPOSITION:String = "imeComposition";

        public function IMEEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "") {
            super(type, bubbles, cancelable, text);
            return;
        }
        override public function toString() : String {
            return formatToString("IMEEvent", "type", "bubbles", "cancelable", "eventPhase", "text");
        }
        override public function clone() : Event {
            return new IMEEvent(type, bubbles, cancelable, text);
        }
    }
}
