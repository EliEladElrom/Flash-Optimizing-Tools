package flash.events
{

    public class SyncEvent extends Event {
        private var m_changeList:Array;
        public static const SYNC:String = "sync";

        public function SyncEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, changeList:Array = null) {
            super(type, bubbles, cancelable);
            this.m_changeList = changeList;
            return;
        }
        public function set changeList(value:Array) : void {
            this.m_changeList = value;
            return;
        }
        override public function toString() : String {
            return formatToString("SyncEvent", "type", "bubbles", "cancelable", "eventPhase", "changeList");
        }
        override public function clone() : Event {
            return new SyncEvent(type, bubbles, cancelable, this.m_changeList);
        }
        public function get changeList() : Array {
            return this.m_changeList;
        }
    }
}
