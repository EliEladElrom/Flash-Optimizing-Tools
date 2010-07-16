package 
{
    import Object.*;

    dynamic public class Object {
        public static const length:int = 1;

        public function Object() {
            return;
        }
        function hasOwnProperty(V = ) : Boolean {
            return _hasOwnProperty(this, V);
        }
        function propertyIsEnumerable(V = ) : Boolean {
            return _propertyIsEnumerable(this, V);
        }
        function isPrototypeOf(V = ) : Boolean {
            return _isPrototypeOf(this, V);
        }
        private static function _hasOwnProperty(o, V:String) : Boolean;

        static function _dontEnumPrototype(proto:Object) : void {
            var _loc_2:String = null;
            for (_loc_2 in proto){
                
                _setPropertyIsEnumerable(proto, _loc_2, false);
            }
            return;
        }
        private static function _propertyIsEnumerable(o, V:String) : Boolean;

        private static function _isPrototypeOf(o, V) : Boolean;

        static function _setPropertyIsEnumerable(o, V:String, enumerable:Boolean) : void;

        private static function _toString(o) : String;

        static function init() {
            prototype.hasOwnProperty = function (V = ) : Boolean {
                return this.hasOwnProperty(V);
            }            ;
            prototype.propertyIsEnumerable = function (V = ) {
                return this.propertyIsEnumerable(V);
            }            ;
            prototype.setPropertyIsEnumerable = function (name:String, enumerable:Boolean) : void {
                _setPropertyIsEnumerable(this, name, enumerable);
                return;
            }            ;
            prototype.isPrototypeOf = function (V = ) : Boolean {
                return this.isPrototypeOf(V);
            }            ;
            var _loc_2:* = function () : String {
                return _toString(this);
            }            ;
            prototype.toLocaleString = function () : String {
                return _toString(this);
            }            ;
            prototype.toString = _loc_2;
            prototype.valueOf = function () {
                return this;
            }            ;
            _dontEnumPrototype(prototype);
            return;
        }
    }
}
