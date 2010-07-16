package flash.utils
{

    public class Proxy extends Object {

        public function Proxy() {
            return;
        }
        function deleteProperty(name) : Boolean {
            Error.throwError(IllegalOperationError, 2092);
            return null;
        }
        function isAttribute(name) : Boolean;

        function callProperty(name, ... args) {
            Error.throwError(IllegalOperationError, 2090);
            return null;
        }
        function nextNameIndex(index:int) : int {
            Error.throwError(IllegalOperationError, 2105);
            return null;
        }
        function nextName(index:int) : String {
            Error.throwError(IllegalOperationError, 2106);
            return null;
        }
        function getDescendants(name) {
            Error.throwError(IllegalOperationError, 2093);
            return null;
        }
        function getProperty(name) {
            Error.throwError(IllegalOperationError, 2088);
            return;
        }
        function nextValue(index:int) {
            Error.throwError(IllegalOperationError, 2107);
            return null;
        }
        function setProperty(name, value) : void {
            Error.throwError(IllegalOperationError, 2089);
            return;
        }
        function hasProperty(name) : Boolean {
            Error.throwError(IllegalOperationError, 2091);
            return null;
        }
    }
}
