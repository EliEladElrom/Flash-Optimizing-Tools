package flash.events
{

    public class FullScreenEvent extends ActivityEvent {
        private var m_fullScreen:Boolean;
        public static const FULL_SCREEN:String = "fullScreen";

        public function FullScreenEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, fullScreen:Boolean = false) {
            super(type, bubbles, cancelable);
            this.m_fullScreen = fullScreen;
            return;
        }
        public function get fullScreen() : Boolean {
            return this.m_fullScreen;
        }
        override public function toString() : String {
            return formatToString("FullScreenEvent", "type", "bubbles", "cancelable", "eventPhase", "fullScreen");
        }
        override public function clone() : Event {
            return new FullScreenEvent(type, bubbles, cancelable, this.fullScreen);
        }
    }
}
