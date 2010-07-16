package 
{

    dynamic public class RegExp extends Object {
        public static const length:int = 1;

        public function RegExp(pattern = , options = ) {
            return;
        }
        function exec(s:String = "");

        public function get ignoreCase() : Boolean;

        public function get global() : Boolean;

        public function set lastIndex(i:int);

        public function get extended() : Boolean;

        function test(s:String = "") : Boolean {
            return this.exec(s) != null;
        }
        public function get source() : String;

        public function get lastIndex() : int;

        public function get multiline() : Boolean;

        public function get dotall() : Boolean;

        prototype.toString = function () : String {
            var _loc_1:RegExp = this;
            var _loc_2:* = "/" + _loc_1.source + "/";
            if (_loc_1.global){
                _loc_2 = _loc_2 + "g";
            }
            if (_loc_1.ignoreCase){
                _loc_2 = _loc_2 + "i";
            }
            if (_loc_1.multiline){
                _loc_2 = _loc_2 + "m";
            }
            if (_loc_1.dotall){
                _loc_2 = _loc_2 + "s";
            }
            if (_loc_1.extended){
                _loc_2 = _loc_2 + "x";
            }
            return _loc_2;
        }        ;
        prototype.exec = function (s = "") {
            var _loc_2:RegExp = this;
            return _loc_2.exec(String(s));
        }        ;
        prototype.test = function (s = "") : Boolean {
            var _loc_2:RegExp = this;
            return _loc_2.test(String(s));
        }        ;
        _dontEnumPrototype(prototype);
    }
}
