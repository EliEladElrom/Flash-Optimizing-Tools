package 
{
    import Error.*;

    dynamic public class Error extends Object {
        private var _errorID:int;
        public var message:Object;
        public var name:Object;
        public static const length:int = 1;

        public function Error(message = "", id = 0) {
            this.message = message;
            this._errorID = id;
            this.name = prototype.name;
            return;
        }
        public function getStackTrace() : String;

        public function get errorID() : int {
            return this._errorID;
        }
        public static function throwError(type:Class, index:uint, ... args) {
            args = new activation;
            var type:* = type;
            var index:* = index;
            var rest:* = args;
            var i:*;
            var f:* = function (match, pos, string) {
                var _loc_4:* = -1;
                switch(match.charAt(1)){
                    case "1":{
                        _loc_4 = 0;
                        break;
                    }
                    case "2":{
                        _loc_4 = 1;
                        break;
                    }
                    case "3":{
                        _loc_4 = 2;
                        break;
                    }
                    case "4":{
                        _loc_4 = 3;
                        break;
                    }
                    case "5":{
                        _loc_4 = 4;
                        break;
                    }
                    case "6":{
                        _loc_4 = 5;
                        break;
                    }
                    default:{
                        break;
                    }
                }
                if (_loc_4 > -1){
                }
                if (rest.length > _loc_4){
                    return rest[_loc_4];
                }
                return "";
            }            ;
            throw new (Error.getErrorMessage().replace(/%[0-9]""%[0-9]/g, ));
        }
        public static function getErrorMessage(index:int) : String;

        prototype.name = "Error";
        prototype.message = "Error";
        prototype.toString = function () : String {
            var _loc_1:Error = this;
            return _loc_1.message !== "" ? (_loc_1.name + ": " + _loc_1.message) : (_loc_1.name);
        }        ;
        _setPropertyIsEnumerable(prototype, "toString", false);
    }
}
