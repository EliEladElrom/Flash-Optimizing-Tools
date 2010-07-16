package 
{
    import String.*;

    final public class String extends Object {
        public static const length:int = 1;

        public function String(value = "") {
            return;
        }
        function match(p = ) : Array {
            return _match(this, p);
        }
        private function _charAt(i:int = 0) : String;

        function indexOf(s:String = "undefined", i:Number = 0) : int;

        private function _indexOf(s:String, i:int = 0) : int;

        private function _substr(start:int = 0, end:int = 2147483647) : String;

        function substring(start:Number = 0, end:Number = 2147483647) : String;

        function slice(start:Number = 0, end:Number = 2147483647) : String;

        function lastIndexOf(s:String = "undefined", i:Number = 2147483647) : int;

        private function _lastIndexOf(s:String, i:int = 2147483647) : int;

        private function _charCodeAt(i:int = 0) : Number;

        function toLowerCase() : String;

        private function _substring(start:int = 0, end:int = 2147483647) : String;

        function split(delim = , limit = 4.29497e+09) : Array {
            if (limit == undefined){
                limit = 4294967295;
            }
            return _split(this, delim, limit);
        }
        function concat(... args) : String {
            args = this;
            var _loc_3:uint = 0;
            var _loc_4:* = args.length;
            while (_loc_3 < _loc_4){
                
                args = args + String(args[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return args;
        }
        function toLocaleLowerCase() : String {
            return this.toLowerCase();
        }
        private function _slice(start:int = 0, end:int = 2147483647) : String;

        public function get length() : int;

        function search(p = ) : int {
            return _search(this, p);
        }
        function charAt(i:Number = 0) : String;

        function localeCompare(other:String = ) : int;

        function toString() : String {
            return this;
        }
        function valueOf() : String {
            return this;
        }
        function substr(start:Number = 0, len:Number = 2147483647) : String;

        function replace(p = , repl = ) : String {
            return _replace(this, p, repl);
        }
        function charCodeAt(i:Number = 0) : Number;

        function toUpperCase() : String;

        function toLocaleUpperCase() : String {
            return this.toUpperCase();
        }
        private static function _replace(s:String, p, repl) : String;

        private static function _match(s:String, p) : Array;

        private static function _search(s:String, p) : int;

        private static function _split(s:String, delim, limit:uint) : Array;

        static function fromCharCode(... args) : String;

        String.fromCharCode = function (... args) {
            return fromCharCode.apply(String, args);
        }        ;
        prototype.indexOf = function (s:String = "undefined", i:Number = 0) : int {
            return String(this).indexOf(s, i);
        }        ;
        prototype.lastIndexOf = function (s:String = "undefined", i:Number = 2147483647) : int {
            return String(this).lastIndexOf(s, i);
        }        ;
        prototype.charAt = function (i:Number = 0) : String {
            return String(this).charAt(i);
        }        ;
        prototype.charCodeAt = function (i:Number = 0) : Number {
            return String(this).charCodeAt(i);
        }        ;
        prototype.concat = function (... args) : String {
            args = String(this);
            var _loc_3:uint = 0;
            var _loc_4:* = args.length;
            while (_loc_3 < _loc_4){
                
                args = args + String(args[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return args;
        }        ;
        prototype.localeCompare = function (other:String = ) : int {
            return String(this).localeCompare(other);
        }        ;
        prototype.match = function (p = ) : Array {
            return _match(String(this), p);
        }        ;
        prototype.replace = function (p = , repl = ) : String {
            return _replace(String(this), p, repl);
        }        ;
        prototype.search = function (p = ) : int {
            return _search(String(this), p);
        }        ;
        prototype.slice = function (start:Number = 0, end:Number = 2147483647) : String {
            return String(this).slice(start, end);
        }        ;
        prototype.split = function (delim = , limit = 4.29497e+09) : Array {
            if (limit == undefined){
                limit = 4294967295;
            }
            return _split(String(this), delim, limit);
        }        ;
        prototype.substring = function (start:Number = 0, end:Number = 2147483647) : String {
            return String(this).substring(start, end);
        }        ;
        prototype.substr = function (start:Number = 0, len:Number = 2147483647) : String {
            return String(this).substr(start, len);
        }        ;
        var _loc_1:* = function () : String {
            return String(this).toLowerCase();
        }        ;
        prototype.toLocaleLowerCase = function () : String {
            return String(this).toLowerCase();
        }        ;
        prototype.toLowerCase = _loc_1;
        var _loc_1:* = function () : String {
            return String(this).toUpperCase();
        }        ;
        prototype.toLocaleUpperCase = function () : String {
            return String(this).toUpperCase();
        }        ;
        prototype.toUpperCase = _loc_1;
        prototype.toString = function () : String {
            if (prototype === this){
                return "";
            }
            if (!(this is String)){
                Error.throwError(TypeError, 1004, "String.prototype.toString");
            }
            return this;
        }        ;
        prototype.valueOf = function () {
            if (prototype === this){
                return "";
            }
            if (!(this is String)){
                Error.throwError(TypeError, 1004, "String.prototype.valueOf");
            }
            return this;
        }        ;
        _dontEnumPrototype(prototype);
    }
}
