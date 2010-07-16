package 
{
    import Array.*;

    dynamic public class Array extends Object {
        public static const CASEINSENSITIVE:uint = 1;
        public static const length:int = 1;
        public static const NUMERIC:uint = 16;
        public static const UNIQUESORT:uint = 4;
        public static const RETURNINDEXEDARRAY:uint = 8;
        public static const DESCENDING:uint = 2;

        public function Array(... args) {
            var _loc_3:Number = NaN;
            var _loc_4:uint = 0;
            var _loc_5:uint = 0;
            args = args.length;
            if (args == 1){
            }
            if (args[0] is Number){
                _loc_3 = args[0];
                _loc_4 = _loc_3;
                if (_loc_4 != _loc_3){
                    Error.throwError(RangeError, 1005, _loc_3);
                }
                this.length = _loc_4;
            }
            else{
                this.length = args;
                _loc_5 = 0;
                while (_loc_5 < args){
                    
                    this[_loc_5] = args[_loc_5];
                    _loc_5 = _loc_5 + 1;
                }
            }
            return;
        }
        function reverse() : Array {
            return _reverse(this);
        }
        function map(callback:Function, thisObject = null) : Array {
            return _map(this, callback, thisObject);
        }
        function shift() {
            return _shift(this);
        }
        public function get length() : uint;

        function unshift(... args) : uint;

        function join(sep = ) : String {
            return _join(this, sep);
        }
        function lastIndexOf(searchElement, fromIndex = 2147483647) : int {
            return _lastIndexOf(this, searchElement, int(fromIndex));
        }
        public function set length(newLength:uint);

        function indexOf(searchElement, fromIndex = 0) : int {
            return _indexOf(this, searchElement, int(fromIndex));
        }
        function pop();

        function slice(A = 0, B = 4.29497e+09) : Array {
            return _slice(this, Number(A), Number(B));
        }
        function concat(... args) : Array {
            return _concat(this, args);
        }
        function some(callback:Function, thisObject = null) : Boolean {
            return _some(this, callback, thisObject);
        }
        function filter(callback:Function, thisObject = null) : Array {
            return _filter(this, callback, thisObject);
        }
        function forEach(callback:Function, thisObject = null) : void {
            _forEach(this, callback, thisObject);
            return;
        }
        function push(... args) : uint;

        function every(callback:Function, thisObject = null) : Boolean {
            return _every(this, callback, thisObject);
        }
        function splice(... args) {
            if (!args.length){
                return undefined;
            }
            return _splice(this, args);
        }
        function sortOn(names, options = 0, ... args) {
            return _sortOn(this, names, options);
        }
        function sort(... args) {
            return _sort(this, args);
        }
        private static function _shift(o);

        private static function _join(o, sep) : String {
            var _loc_7:* = undefined;
            var _loc_3:* = sep === undefined ? (",") : (String(sep));
            var _loc_4:String = "";
            var _loc_5:uint = 0;
            var _loc_6:* = uint(o.length);
            while (_loc_5 < _loc_6){
                
                _loc_7 = o[_loc_5];
                if (_loc_7 != null){
                    _loc_4 = _loc_4 + _loc_7;
                }
                if ((_loc_5 + 1) < _loc_6){
                    _loc_4 = _loc_4 + _loc_3;
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_4;
        }
        private static function _indexOf(o, searchElement, fromIndex:int) : int;

        private static function _pop(o);

        private static function _slice(o, A:Number, B:Number) : Array;

        private static function _lastIndexOf(o, searchElement, fromIndex:int = 0) : int;

        private static function _filter(o, callback:Function, thisObject) : Array;

        private static function _splice(o, args:Array) : Array;

        private static function _every(o, callback:Function, thisObject) : Boolean;

        private static function _map(o, callback:Function, thisObject) : Array;

        private static function _reverse(o);

        private static function _forEach(o, callback:Function, thisObject) : void;

        private static function _concat(o, args:Array) : Array;

        private static function _some(o, callback:Function, thisObject) : Boolean;

        private static function _sortOn(o, names, options);

        private static function _sort(o, args:Array);

        prototype.join = function (sep = ) : String {
            return _join(this, sep);
        }        ;
        prototype.pop = function () {
            return _pop(this);
        }        ;
        prototype.toString = function () : String {
            var _loc_1:Array = this;
            return _join(_loc_1, ",");
        }        ;
        prototype.toLocaleString = function () : String {
            var _loc_5:* = undefined;
            var _loc_1:Array = this;
            var _loc_2:String = "";
            var _loc_3:uint = 0;
            var _loc_4:* = _loc_1.length;
            while (_loc_3 < _loc_4){
                
                _loc_5 = _loc_1[_loc_3];
                if (_loc_5 != null){
                    _loc_2 = _loc_2 + _loc_5.toLocaleString();
                }
                if ((_loc_3 + 1) < _loc_4){
                    _loc_2 = _loc_2 + ",";
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }        ;
        prototype.push = function (... args) : uint {
            args = uint(this.length);
            var _loc_3:uint = 0;
            var _loc_4:* = args.length;
            while (_loc_3 < _loc_4){
                
                var _loc_5:* = args + 1;
                this[_loc_5] = args[_loc_3];
                _loc_3 = _loc_3 + 1;
            }
            this.length = _loc_2;
            return _loc_2;
        }        ;
        prototype.reverse = function () {
            return _reverse(this);
        }        ;
        prototype.concat = function (... args) : Array {
            return _concat(this, args);
        }        ;
        prototype.shift = function () {
            return _shift(this);
        }        ;
        prototype.slice = function (A = 0, B = 4.29497e+09) : Array {
            return _slice(this, Number(A), Number(B));
        }        ;
        prototype.unshift = function (... args) : uint {
            var _loc_4:uint = 0;
            var _loc_6:uint = 0;
            args = uint(this.length);
            var _loc_3:* = args.length;
            _loc_4 = args;
            while (_loc_4 > 0){
                
                _loc_4 = _loc_4 - 1;
                _loc_6 = _loc_4 + _loc_3;
                if (_loc_4 in this){
                    this[_loc_6] = this[_loc_4];
                    continue;
                }
                delete this[_loc_6];
            }
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_3){
                
                var _loc_7:* = _loc_4 + 1;
                this[_loc_7] = args[_loc_5];
                _loc_5 = _loc_5 + 1;
            }
            args = args + _loc_3;
            this.length = args;
            return args;
        }        ;
        prototype.splice = function (... args) {
            if (!args.length){
                return undefined;
            }
            return _splice(this, args);
        }        ;
        prototype.sort = function (... args) {
            return _sort(this, args);
        }        ;
        prototype.sortOn = function (names, options = 0, ... args) {
            return _sortOn(this, names, options);
        }        ;
        prototype.indexOf = function (searchElement, fromIndex = 0) : int {
            return _indexOf(this, searchElement, int(fromIndex));
        }        ;
        prototype.lastIndexOf = function (searchElement, fromIndex = 2147483647) : int {
            return _lastIndexOf(this, searchElement, int(fromIndex));
        }        ;
        prototype.every = function (callback:Function, thisObject = null) : Boolean {
            return _every(this, callback, thisObject);
        }        ;
        prototype.filter = function (callback:Function, thisObject = null) : Array {
            return _filter(this, callback, thisObject);
        }        ;
        prototype.forEach = function (callback:Function, thisObject = null) : void {
            _forEach(this, callback, thisObject);
            return;
        }        ;
        prototype.map = function (callback:Function, thisObject = null) : Array {
            return _map(this, callback, thisObject);
        }        ;
        prototype.some = function (callback:Function, thisObject = null) : Boolean {
            return _some(this, callback, thisObject);
        }        ;
        _dontEnumPrototype(prototype);
    }
}
