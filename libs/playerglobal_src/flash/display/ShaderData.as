package flash.display
{
    import flash.utils.*;

    final dynamic public class ShaderData extends Object {

        public function ShaderData(byteCode:ByteArray) {
            this._setByteCode(byteCode);
            return;
        }
        private function _setByteCode(code:ByteArray) : void;

    }
}
