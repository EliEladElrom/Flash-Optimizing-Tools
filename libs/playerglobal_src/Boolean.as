package 
{

    final public class Boolean extends Object {
        public static const length:int = 1;

        public function Boolean(value = ) {
            return;
        }
        function valueOf() : Boolean {
            return this;
        }
        function toString() : String {
            return this ? ("true") : ("false");
        }
        prototype.toString = function () : String {
            if (prototype === this){
                return "false";
            }
            if (!(this is Boolean)){
                Error.throwError(TypeError, 1004, "Boolean.prototype.toString");
            }
            return this ? ("true") : ("false");
        }        ;
        prototype.valueOf = function () {
            if (prototype === this){
                return false;
            }
            if (!(this is Boolean)){
                Error.throwError(TypeError, 1004, "Boolean.prototype.valueOf");
            }
            return this;
        }        ;
        _dontEnumPrototype(prototype);
    }
}
