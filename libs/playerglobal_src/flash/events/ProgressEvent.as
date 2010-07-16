package flash.events
{

    public class ProgressEvent extends Event {
        private var m_bytesTotal:uint;
        private var m_bytesLoaded:uint;
        public static const PROGRESS:String = "progress";
        public static const SOCKET_DATA:String = "socketData";

        public function ProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0) {
            super(type, bubbles, cancelable);
            this.m_bytesLoaded = bytesLoaded;
            this.m_bytesTotal = bytesTotal;
            return;
        }
        public function get bytesLoaded() : uint {
            return this.m_bytesLoaded;
        }
        public function set bytesTotal(value:uint) : void {
            this.m_bytesTotal = value;
            return;
        }
        override public function toString() : String {
            return formatToString("ProgressEvent", "type", "bubbles", "cancelable", "eventPhase", "bytesLoaded", "bytesTotal");
        }
        public function set bytesLoaded(value:uint) : void {
            this.m_bytesLoaded = value;
            return;
        }
        public function get bytesTotal() : uint {
            return this.m_bytesTotal;
        }
        override public function clone() : Event {
            return new ProgressEvent(type, bubbles, cancelable, this.m_bytesLoaded, this.m_bytesTotal);
        }
    }
}
