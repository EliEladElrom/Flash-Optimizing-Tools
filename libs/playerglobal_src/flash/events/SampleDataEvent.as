package flash.events
{
    import flash.utils.*;

    public class SampleDataEvent extends Event {
        private var m_position:Number;
        private var m_data:ByteArray;
        public static const SAMPLE_DATA:String = "sampleData";

        public function SampleDataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, theposition:Number = 0, thedata:ByteArray = null) {
            super(type, bubbles, cancelable);
            this.m_position = theposition;
            this.m_data = thedata;
            return;
        }
        public function set position(theposition:Number) {
            this.m_position = theposition;
            return;
        }
        public function set data(thedata:ByteArray) {
            this.m_data = thedata;
            return;
        }
        public function get position() : Number {
            return this.m_position;
        }
        public function get data() : ByteArray {
            return this.m_data;
        }
        override public function toString() : String {
            return formatToString("SampleDataEvent", "type", "bubbles", "cancelable", "eventPhase", "position", "data");
        }
        override public function clone() : Event {
            return new SampleDataEvent(type, bubbles, cancelable, this.position, this.data);
        }
    }
}
