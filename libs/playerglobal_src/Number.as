package 
{
    import Number.*;

    final public class Number extends Object {
        public static const MIN_VALUE:Number = 4.94066e-324;
        public static const length:int = 1;
        private static const DTOSTR_FIXED:int = 1;
        public static const POSITIVE_INFINITY:Number = inf;
        private static const DTOSTR_PRECISION:int = 2;
        public static const NEGATIVE_INFINITY:Number = -inf;
        public static const MAX_VALUE:Number = 1.79769e+308;
        private static const DTOSTR_EXPONENTIAL:int = 3;
        public static const NaN:Number = NaN;

        public function Number(value = 0) {
            return;
        }
        function toPrecision(p = 0) : String {
            if (p == undefined){
                return this.toString();
            }
            return _convert(this, int(p), DTOSTR_PRECISION);
        }
        function valueOf() : Number {
            return this;
        }
        function toFixed(p = 0) : String {
            return _convert(this, int(p), DTOSTR_FIXED);
        }
        function toExponential(p = 0) : String {
            return _convert(this, int(p), DTOSTR_EXPONENTIAL);
        }
        function toString(radix = 10) : String {
            return _toString(this, radix);
        }
        private static function _convert(n:Number, precision:int, mode:int) : String;

        private static function _toString(n:Number, radix:int) : String;

        var _loc_1:* = function (radix = 10) : String {
            if (prototype === this){
                return "0";
            }
            if (!(this is Number)){
                Error.throwError(TypeError, 1004, "Number.prototype.toString");
            }
            return _toString(this, radix);
        }        ;
        prototype.toString = function (radix = 10) : String {
            if (prototype === this){
                return "0";
            }
            if (!(this is Number)){
                Error.throwError(TypeError, 1004, "Number.prototype.toString");
            }
            return _toString(this, radix);
        }        ;
        prototype.toLocaleString = _loc_1;
        prototype.valueOf = function () {
            if (prototype === this){
                return 0;
            }
            if (!(this is Number)){
                Error.throwError(TypeError, 1004, "Number.prototype.valueOf");
            }
            return this;
        }        ;
        prototype.toExponential = function (p = 0) : String {
            return _convert(Number(this), int(p), DTOSTR_EXPONENTIAL);
        }        ;
        prototype.toPrecision = function (p = 0) : String {
            if (p == undefined){
                return this.toString();
            }
            return _convert(Number(this), int(p), DTOSTR_PRECISION);
        }        ;
        prototype.toFixed = function (p = 0) : String {
            return _convert(Number(this), int(p), DTOSTR_FIXED);
        }        ;
        _dontEnumPrototype(prototype);
    }
}
