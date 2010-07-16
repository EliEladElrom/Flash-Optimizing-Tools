package 
{

    final public class Namespace extends Object {
        public static const length:Object = 2;

        public function Namespace(prefix = , uri = ) {
            return;
        }
        function valueOf() : String {
            return this.uri;
        }
        public function get prefix();

        function toString() : String {
            return this.uri;
        }
        public function get uri() : String;

        prototype.valueOf = function () : String {
            if (prototype === this){
                return "";
            }
            var _loc_1:Namespace = this;
            return _loc_1.uri;
        }        ;
        prototype.toString = function () : String {
            if (prototype === this){
                return "";
            }
            var _loc_1:Namespace = this;
            return _loc_1.uri;
        }        ;
        _dontEnumPrototype(prototype);
    }
}
