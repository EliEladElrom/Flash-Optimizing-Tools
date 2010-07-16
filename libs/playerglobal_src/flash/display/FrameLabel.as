package flash.display
{

    final public class FrameLabel extends Object {
        private var _name:String;
        private var _frame:int;

        public function FrameLabel(name:String, frame:int) {
            this._name = name;
            this._frame = frame;
            return;
        }
        public function get name() : String {
            return this._name;
        }
        public function get frame() : int {
            return this._frame;
        }
    }
}
