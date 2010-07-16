package flash.events
{

    public class TimerEvent extends Event {
        public static const TIMER_COMPLETE:String = "timerComplete";
        public static const TIMER:String = "timer";

        public function TimerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            return;
        }
        override public function toString() : String {
            return formatToString("TimerEvent", "type", "bubbles", "cancelable", "eventPhase");
        }
        override public function clone() : Event {
            return new TimerEvent(type, bubbles, cancelable);
        }
        public function updateAfterEvent() : void;

    }
}
