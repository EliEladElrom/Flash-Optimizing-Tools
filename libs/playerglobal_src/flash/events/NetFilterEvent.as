package flash.events
{
    import flash.utils.*;

    public class NetFilterEvent extends Event {
        public var data:ByteArray;
        public var header:ByteArray;

        public function NetFilterEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, header:ByteArray = null, data:ByteArray = null) {
            super(type, bubbles, cancelable);
            this.data = data;
            this.header = header;
            return;
        }
        override public function toString() : String {
            return formatToString("NetTransformEvent", "type", "bubbles", "cancelable", "eventPhase", "header", "data");
        }
        override public function clone() : Event {
            return new NetFilterEvent(type, bubbles, cancelable, this.header, this.data);
        }
    }
}
