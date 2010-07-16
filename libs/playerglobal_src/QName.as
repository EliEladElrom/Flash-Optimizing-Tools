package 
{

    final public class QName extends Object {
        public static const length:Object = 2;

        public function QName(namespace = , name = ) {
            return;
        }
        function valueOf() : QName {
            return this;
        }
        function toString() : String {
            if (this.uri === ""){
                return this.localName;
            }
            return (this.uri === null ? ("*") : (this.uri)) + "::" + this.localName;
        }
        public function get uri();

        public function get localName() : String;

        prototype.toString = function () : String {
            if (prototype === this){
                return "";
            }
            if (!(this is QName)){
                Error.throwError(TypeError, 1004, "QName.prototype.toString");
            }
            var _loc_1:QName = this;
            return _loc_1.toString();
        }        ;
        _dontEnumPrototype(prototype);
    }
}
