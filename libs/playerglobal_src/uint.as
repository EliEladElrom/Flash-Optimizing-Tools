package 
{

    final public class uint extends Object {
        public static const MIN_VALUE:uint = 0;
        public static const length:int = 1;
        public static const MAX_VALUE:uint = 4.29497e+09;

        public function uint(value = 0) {
            return;
        }
        function toPrecision(p = 0) : String {
            return Number(this).toPrecision(p);
        }
        function valueOf() : uint {
            return this;
        }
        function toFixed(p = 0) : String {
            return Number(this).toFixed(p);
        }
        function toExponential(p = 0) : String {
            return Number(this).toExponential(p);
        }
        function toString(radix = 10) : String {
            return Number(this).toString(radix);
        }
        with ({}){
            {}.toString = function (radix = 10) : String {
            if (prototype === this){
                return "0";
            }
            if (!(this is Number)){
                Error.throwError(TypeError, 1004, "uint.prototype.toString");
            }
            return Number(this).toString(radix);
        }        ;
        }
        var _loc_1:* = function (radix = 10) : String {
            if (prototype === this){
                return "0";
            }
            if (!(this is Number)){
                Error.throwError(TypeError, 1004, "uint.prototype.toString");
            }
            return Number(this).toString(radix);
        }        ;
        prototype.toString = function (radix = 10) : String {
            if (prototype === this){
                return "0";
            }
            if (!(this is Number)){
                Error.throwError(TypeError, 1004, "uint.prototype.toString");
            }
            return Number(this).toString(radix);
        }        ;
        prototype.toLocaleString = _loc_1;
        prototype.valueOf = function () {
            if (prototype === this){
                return 0;
            }
            if (!(this is uint)){
                Error.throwError(TypeError, 1004, "uint.prototype.valueOf");
            }
            return this;
        }        ;
        prototype.toExponential = function (p = 0) : String {
            return Number(this).toExponential(p);
        }        ;
        prototype.toPrecision = function (p = 0) : String {
            return Number(this).toPrecision(p);
        }        ;
        prototype.toFixed = function (p = 0) : String {
            return Number(this).toFixed(p);
        }        ;
        _dontEnumPrototype(prototype);
    }
}
