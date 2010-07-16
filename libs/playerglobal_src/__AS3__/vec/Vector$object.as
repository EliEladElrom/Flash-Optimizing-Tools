package __AS3__.vec
{

    final dynamic class Vector$object extends Object {

        function Vector$object(length:uint = 0, fixed:Boolean = false) {
            this.length = length;
            this.fixed = fixed;
            return;
        }
        private function _shift() {
            if (this.fixed){
                Error.throwError(RangeError, 1126);
            }
            if (this.length == 0){
                return undefined;
            }
            var _loc_1:* = this[0];
            this._spliceHelper(0, 0, 1, null, 0);
            return _loc_1;
        }
        function reverse() : Vector$object {
            this._reverse();
            return this;
        }
        function unshift(... args) : uint;

        private function clamp(val:Number, len:uint) : uint {
            var _loc_3:uint = 0;
            if (val < 0){
                if (val + len < 0){
                    _loc_3 = 0;
                }
                else{
                    _loc_3 = uint(val + len);
                }
            }
            else if (val > len){
                _loc_3 = this.length;
            }
            else if (val != val){
                _loc_3 = 0;
            }
            else{
                _loc_3 = uint(val);
            }
            return _loc_3;
        }
        public function set length(value:uint);

        function indexOf(value:Object, from:Number = 0) : Number {
            var _loc_3:* = this.clamp(from, this.length);
            var _loc_4:* = _loc_3;
            var _loc_5:* = this.length;
            while (_loc_4 < _loc_5){
                
                if (this[_loc_4] === value){
                    return _loc_4;
                }
                _loc_4 = _loc_4 + 1;
            }
            return -1;
        }
        function pop();

        function slice(start:Number = 0, end:Number = 2147483647) : Vector$object {
            return this._slice(start, end);
        }
        private function _slice(start:Number = 0, end:Number = 2147483647) {
            var _loc_3:* = this.clamp(start, this.length);
            var _loc_4:* = this.clamp(end, this.length);
            var _loc_5:* = this.newThisType();
            _loc_5._spliceHelper(0, _loc_4 - _loc_3, 0, this, _loc_3);
            return _loc_5;
        }
        function concat(... args) : Vector$object {
            return this._concat(args);
        }
        public function get fixed() : Boolean;

        private function _filter(callback:Function, thisObject);

        function push(... args) : uint;

        function every(checker:Function, thisObj:Object = null) : Boolean {
            return _every(this, checker, thisObj is Object ? (thisObj) : (null));
        }
        function map(mapper:Function, thisObj:Object = null) {
            this._map(mapper, thisObj is Object ? (thisObj) : (null));
            return;
        }
        private function _map(callback:Function, thisObject);

        function sort(comparefn) : Vector$object {
            var _loc_2:Array = [comparefn];
            _sort(this, _loc_2);
            return this;
        }
        private function _splice(start, deleteCount, items:Array) {
            var _loc_4:* = this.clamp(start, this.length);
            var _loc_5:* = this.clamp(deleteCount, this.length - _loc_4);
            var _loc_6:* = this.newThisType();
            _loc_6._spliceHelper(0, _loc_5, 0, this, _loc_4);
            this._spliceHelper(_loc_4, items.length, _loc_5, items, 0);
            return _loc_6;
        }
        private function _reverse() : void;

        function shift() {
            return this._shift();
        }
        public function get length() : uint;

        public function set fixed(f:Boolean);

        private function _spliceHelper(insertpoint:uint, insertcount:uint, deleteCount:uint, args:Object, offset:int) : void;

        function join(separator:String = ",") : String {
            var _loc_5:uint = 0;
            var _loc_2:* = this.length;
            var _loc_3:String = "";
            var _loc_4:int = 0;
            if (_loc_2 > 0){
                while (true){
                    
                    _loc_5 = _loc_4;
                    _loc_3 = _loc_3 + this[_loc_5];
                    _loc_5 = _loc_4 + 1;
                    if (_loc_5 == _loc_2){
                        break;
                    }
                    _loc_3 = _loc_3 + separator;
                }
            }
            return _loc_3;
        }
        function lastIndexOf(value:Object, from:Number = 2147483647) : Number {
            var _loc_3:* = this.clamp(from, this.length);
            if (_loc_3 == this.length){
                _loc_3 = _loc_3 - 1;
            }
            var _loc_4:* = _loc_3;
            while (_loc_4 >= 0){
                
                if (this[_loc_4] === value){
                    return _loc_4;
                }
                _loc_4 = _loc_4 - 1;
            }
            return -1;
        }
        function toString() : String {
            return this.join();
        }
        function toLocaleString() : String {
            var _loc_5:* = undefined;
            var _loc_1:* = this.length;
            var _loc_2:String = ",";
            var _loc_3:String = "";
            var _loc_4:uint = 0;
            if (_loc_1 > 0){
                while (true){
                    
                    _loc_5 = this[_loc_4];
                    if (_loc_5 !== undefined){
                    }
                    if (_loc_5 !== null){
                        _loc_3 = _loc_3 + _loc_5.toLocaleString();
                    }
                    if (++_loc_4 == _loc_1){
                        break;
                    }
                    _loc_3 = _loc_3 + _loc_2;
                }
            }
            return _loc_3;
        }
        function forEach(eacher:Function, thisObj:Object = null) : void {
            _forEach(this, eacher, thisObj is Object ? (thisObj) : (null));
            return;
        }
        private function _concat(items:Array) {
            var _loc_5:* = undefined;
            var _loc_2:* = this.newThisType();
            _loc_2._spliceHelper(0, this.length, 0, this, 0);
            var _loc_3:uint = 0;
            var _loc_4:* = items.length;
            while (_loc_3 < _loc_4){
                
                _loc_5 = castToThisType(items[_loc_3]);
                _loc_2._spliceHelper(this.length, _loc_5.length, 0, _loc_5, 0);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }
        private function set type(t:Object) : void;

        private function newThisType(length:uint = 0) : Vector$object {
            var _loc_2:* = new Vector.<this.type>(length);
            return _loc_2;
        }
        private function get type() : Object;

        function some(checker, thisObj:Object = null) : Boolean {
            return _some(this, checker, thisObj is Object ? (thisObj) : (null));
        }
        function splice(start:Number, deleteCount:Number, ... args) : Vector$object {
            return this._splice(start, deleteCount, args);
        }
        function filter(checker:Function, thisObj:Object = null) : Vector$object {
            return this._filter(checker, thisObj);
        }
        private static function castToThisType(item) : Vector$object {
            return item;
        }
        private static function _forEach(o, callback:Function, thisObject) : void;

        private static function _every(o, callback:Function, thisObject) : Boolean;

        private static function _some(o, callback:Function, thisObject) : Boolean;

        private static function _sort(o, args:Array);

        prototype.toString = function () {
            return castToThisType(this).toString();
        }        ;
        prototype.toLocaleString = function () {
            return castToThisType(this).toLocaleString();
        }        ;
        prototype.join = function (separator = ) {
            return castToThisType(this).join(separator == undefined ? (",") : (String(separator)));
        }        ;
        prototype.concat = function (... args) {
            return castToThisType(this)._concat(args);
        }        ;
        prototype.every = function (checker, thisObj = ) : Boolean {
            return _every(castToThisType(this), checker, thisObj is Object ? (thisObj) : (null));
        }        ;
        prototype.filter = function (checker, thisObj = ) {
            return castToThisType(this)._filter(checker, thisObj is Object ? (thisObj) : (null));
        }        ;
        prototype.forEach = function (eacher, thisObj = ) {
            _forEach(castToThisType(this), eacher, thisObj is Object ? (thisObj) : (null));
            return;
        }        ;
        prototype.indexOf = function (value, from = ) {
            return castToThisType(this).indexOf(value, Number(from));
        }        ;
        prototype.lastIndexOf = function (value, from = ) {
            return castToThisType(this).lastIndexOf(value, from == undefined ? (Infinity) : (Number(from)));
        }        ;
        prototype.map = function (mapper, thisObj = ) {
            return castToThisType(this)._map(mapper, thisObj is Object ? (thisObj) : (null));
        }        ;
        prototype.pop = function () {
            return castToThisType(this).pop();
        }        ;
        prototype.push = function (... args) {
            return castToThisType(this).push.apply(castToThisType(this), args);
        }        ;
        prototype.reverse = function () {
            return castToThisType(this).reverse();
        }        ;
        prototype.shift = function () {
            return castToThisType(this).shift();
        }        ;
        prototype.slice = function (start = , end = ) {
            return castToThisType(this)._slice(start == undefined ? (0) : (Number(start)), end == undefined ? (2147483647) : (Number(end)));
        }        ;
        prototype.some = function (checker, thisObj = ) : Boolean {
            return _some(castToThisType(this), checker, thisObj is Object ? (thisObj) : (null));
        }        ;
        prototype.sort = function (comparefn) {
            var _loc_2:Array = [comparefn];
            return _sort(castToThisType(this), _loc_2);
        }        ;
        prototype.splice = function (start, deleteCount, ... args) {
            return castToThisType(this)._splice(Number(start), Number(deleteCount), args);
        }        ;
        prototype.unshift = function (... args) {
            return castToThisType(this).unshift.apply(this, args);
        }        ;
        _dontEnumPrototype(prototype);
    }
}
