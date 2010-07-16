package flash.display
{
    import flash.utils.*;

    public class Shader extends Object {

        public function Shader(code:ByteArray = null) {
            if (code){
                this.byteCode = code;
            }
            return;
        }
        public function set byteCode(code:ByteArray) : void {
            this.data = new ShaderData(code);
            return;
        }
        public function set data(p:ShaderData) : void;

        public function get precisionHint() : String;

        public function get data() : ShaderData;

        public function set precisionHint(p:String) : void;

    }
}
