package flash.external
{

    final public class ExternalInterface extends Object {
        public static var marshallExceptions:Boolean = false;

        public function ExternalInterface() {
            return;
        }
        private static function _objectToJS(value) : String {
            var _loc_2:* = _getPropNames(value);
            var _loc_3:String = "({";
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2.length){
                
                if (_loc_4 > 0){
                    _loc_3 = _loc_3 + ",";
                }
                _loc_3 = _loc_3 + (_loc_2[_loc_4] + ":" + _toJS(value[_loc_2[_loc_4]]));
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3 + "})";
        }
        private static function _evalJS(expression:String) : String;

        private static function _argumentsToXML(obj:Array) : String {
            var _loc_2:String = "<arguments>";
            var _loc_3:uint = 0;
            while (_loc_3 < obj.length){
                
                _loc_2 = _loc_2 + _toXML(obj[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2 + "</arguments>";
        }
        public static function addCallback(functionName:String, closure:Function) : void {
            var wrapperClosure:Function;
            var functionName:* = functionName;
            var closure:* = closure;
            if (available){
                _initJS();
                wrapperClosure = function (request:String) : String {
                return _callIn(closure, request);
            }            ;
                _addCallback(functionName, wrapperClosure);
                if (activeX == true){
                }
                if (objectID != null){
                    _evalJS("__flash__addCallback(document.getElementById(\"" + objectID + "\"), \"" + functionName + "\");");
                }
            }
            else{
                Error.throwError(Error, 2067);
            }
            return;
        }
        private static function _addCallback(functionName:String, closure:Function) : void;

        public static function get available() : Boolean;

        private static function _toAS(obj:Object) {
            var _loc_2:* = obj.name();
            if (_loc_2 == "number"){
                return Number(obj.children());
            }
            if (_loc_2 == "string"){
                return String(obj.children());
            }
            if (_loc_2 == "false"){
                return false;
            }
            if (_loc_2 == "true"){
                return true;
            }
            if (_loc_2 == "null"){
                return null;
            }
            if (_loc_2 == "undefined"){
                return undefined;
            }
            if (_loc_2 == "date"){
                return new Date(Number(obj.children()));
            }
            if (_loc_2 == "object"){
                return _objectToAS(obj);
            }
            if (_loc_2 == "array"){
                return _arrayToAS(obj);
            }
            if (_loc_2 == "class"){
                return getDefinitionByName(String(obj.children()));
            }
            if (_loc_2 == "exception"){
            }
            if (marshallExceptions){
                throw new Error(obj.children());
            }
            return undefined;
        }
        private static function _getPropNames(obj:Object) : Array;

        private static function _callIn(closure:Function, request:String) : String {
            arguments = new activation;
            var result:*;
            var closure:* = closure;
            var request:* = request;
            var arguments:* = arguments;
            var oldIgnoreWhitespace:* = XML.ignoreWhitespace;
            XML.ignoreWhitespace = false;
            var xml:* = XML();
            XML.ignoreWhitespace = ;
            try{
                result = apply(null, _argumentsToAS(arguments));
            }
            catch (e:Error){
                if (marshallExceptions){
                    result = e;
                }
                else{
                    throw e;
                }
            }
            return @returntype == "javascript" ? (_toJS()) : (_toXML());
        }
        private static function get activeX() : Boolean;

        private static function _escapeXML(s:String) : String {
            return s.replace(/&""&/g, "&amp;").replace(/<""</g, "&lt;").replace(/>"">/g, "&gt;").replace(/"""""/g, "&quot;").replace(/''""'/g, "&apos;");
        }
        private static function _callOut(request:String) : String;

        public static function get objectID() : String;

        private static function _toXML(value) : String {
            var _loc_2:* = typeof(value);
            if (_loc_2 == "string"){
                return "<string>" + _escapeXML(value) + "</string>";
            }
            if (_loc_2 == "undefined"){
                return "<undefined/>";
            }
            if (_loc_2 == "number"){
                return "<number>" + value + "</number>";
            }
            if (value == null){
                return "<null/>";
            }
            if (_loc_2 == "boolean"){
                return value ? ("<true/>") : ("<false/>");
            }
            else{
                if (value.hasOwnProperty("length")){
                    return _arrayToXML(value);
                }
                if (value is Date){
                    return "<date>" + value.time + "</date>";
                }
                if (value is Error){
                }
                if (marshallExceptions){
                    return "<exception>" + value + "</exception>";
                }
                if (_loc_2 == "object"){
                    return _objectToXML(value);
                }
                return "<null/>";
            }
        }
        private static function _objectToXML(obj) : String {
            var _loc_3:Object = null;
            var _loc_2:String = "<object>";
            for (_loc_3 in obj){
                
                _loc_2 = _loc_2 + ("<property id=\"" + _loc_3 + "\">" + _toXML(obj[_loc_3]) + "</property>");
            }
            return _loc_2 + "</object>";
        }
        private static function _toJS(value) : String {
            if (value is Error){
            }
            if (marshallExceptions){
                return "throw \"" + value + "\"";
            }
            if (typeof(value) == "string"){
                return "\"" + value.replace(/\\""""\"/g, "\\\"").replace(/\
n""\n/g, "\\n").replace(/\r""\r/g, "\\r") + "\"";
            }
            if (value === null){
                return "null";
            }
            if (value is Date){
                return "new Date (" + value.time + ")";
            }
            if (typeof(value) == "object"){
                if (value is Array){
                    return _arrayToJS(value);
                }
                return _objectToJS(value);
            }
            else{
                return String(value);
            }
        }
        public static function call(functionName:String, ... args) {
            args = null;
            var _loc_4:String = null;
            var _loc_5:Boolean = false;
            var _loc_6:uint = 0;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:Boolean = false;
            var _loc_10:XML = null;
            if (available){
                args = "";
                _initJS();
                args = args + "try { ";
                _loc_4 = objectID;
                _loc_5 = activeX;
                if (_loc_5 == true){
                }
                if (_loc_4 != null){
                    args = args + ("document.getElementById(\"" + _loc_4 + "\").SetReturnValue(");
                }
                args = args + ("__flash__toXML(" + functionName + "(");
                _loc_6 = 0;
                while (_loc_6 < args.length){
                    
                    if (_loc_6 != 0){
                        args = args + ",";
                    }
                    args = args + _toJS(args[_loc_6]);
                    _loc_6 = _loc_6 + 1;
                }
                args = args + ")) ";
                if (_loc_5 == true){
                }
                if (_loc_4 != null){
                    args = args + ")";
                }
                args = args + "; } catch (e) { ";
                if (_loc_5 == true){
                }
                if (_loc_4 != null){
                    if (marshallExceptions){
                        args = args + ("document.getElementById(\"" + _loc_4 + "\").SetReturnValue(\"<exception>\" + e + \"</exception>\");");
                    }
                    else{
                        args = args + ("document.getElementById(\"" + _loc_4 + "\").SetReturnValue(\"<undefined/>\");");
                    }
                }
                else if (marshallExceptions){
                    args = args + "\"<exception>\" + e + \"</exception>\";";
                }
                else{
                    args = args + "\"<undefined/>\";";
                }
                args = args + " }";
                _loc_7 = _evalJS(args);
                if (_loc_7 == null){
                    _loc_8 = "<invoke name=\"" + functionName + "\" returntype=\"xml\">" + _argumentsToXML(args) + "</invoke>";
                    _loc_7 = _callOut(_loc_8);
                }
                if (_loc_7 == null){
                    return null;
                }
                _loc_9 = XML.ignoreWhitespace;
                if (Capabilities.version.split(/[\ ,]""[\ ,]/)[1] > 9){
                    XML.ignoreWhitespace = false;
                }
                _loc_10 = XML(_loc_7);
                XML.ignoreWhitespace = _loc_9;
                return _toAS(_loc_10);
            }
            else{
                Error.throwError(Error, 2067);
            }
            return;
        }
        private static function _arrayToAS(obj:Object) {
            var _loc_3:Object = null;
            var _loc_2:Array = [];
            for each (_loc_3 in obj.children()){
                
                _loc_2[_loc_3.@id] = _toAS(_loc_3.children());
            }
            return _loc_2;
        }
        private static function _arrayToXML(obj:Array) : String {
            var _loc_2:String = "<array>";
            var _loc_3:int = 0;
            while (_loc_3 < obj.length){
                
                _loc_2 = _loc_2 + ("<property id=\"" + _loc_3 + "\">" + _toXML(obj[_loc_3]) + "</property>");
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2 + "</array>";
        }
        private static function _objectToAS(obj:Object) {
            var _loc_3:Object = null;
            var _loc_2:Object = {};
            for each (_loc_3 in obj.property){
                
                _loc_2[_loc_3.@id] = _toAS(_loc_3.children());
            }
            return _loc_2;
        }
        private static function _argumentsToAS(obj) : Array {
            var _loc_3:Object = null;
            var _loc_2:Array = [];
            for each (_loc_3 in obj.children()){
                
                _loc_2.push(_toAS(_loc_3));
            }
            return _loc_2;
        }
        private static function _initJS() : void;

        private static function _arrayToJS(value:Array) : String {
            var _loc_2:String = "[";
            var _loc_3:int = 0;
            while (_loc_3 < value.length){
                
                if (_loc_3 != 0){
                    _loc_2 = _loc_2 + ",";
                }
                _loc_2 = _loc_2 + _toJS(value[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2 + "]";
        }
    }
}
