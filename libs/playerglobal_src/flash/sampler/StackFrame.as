package flash.sampler
{

    final public class StackFrame extends Object {
        public const line:uint;
        public const name:String;
        public const file:String;

        public function StackFrame() {
            return;
        }
        public function toString() : String {
            return this.name + "()" + (this.file ? ("[" + this.file + ":" + this.line + "]") : (""));
        }
    }
}
