package 
{
    import Function.*;

    dynamic public class Function extends Object {
        public static const length:int = 1;

        public function Function() {
            return;
        }
        public function get prototype();

        public function set prototype(p);

        function call(thisArg = , ... args);

        public function get length() : int;

        function apply(thisArg = , argArray = );

        private static function emptyCtor() {
            return function () {
                return;
            }            ;
        }
        var _loc_1:* = function () : String {
            var _loc_1:* = this;
            return "function Function() {}";
        }        ;
        prototype.toString = function () : String {
            var _loc_1:* = this;
            return "function Function() {}";
        }        ;
        prototype.toLocaleString = _loc_1;
        prototype.call = function (thisArg = , ... args) {
            args = this;
            return args.apply(thisArg, args);
        }        ;
        prototype.apply = function (thisArg = , argArray = ) {
            var _loc_3:Function = this;
            return _loc_3.apply(thisArg, argArray);
        }        ;
        _dontEnumPrototype(prototype);
    }
}
