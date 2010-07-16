package flash.display
{
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class LoaderInfo extends EventDispatcher {

        public function LoaderInfo() {
            return;
        }
        override public function dispatchEvent(event:Event) : Boolean {
            Error.throwError(IllegalOperationError, 2118);
            return false;
        }
        private function _getArgs() : Object;

        public function get width() : int;

        public function get height() : int;

        public function get parentAllowsChild() : Boolean;

        public function get parameters() : Object {
            var _loc_3:String = null;
            var _loc_1:* = this._getArgs();
            var _loc_2:Object = {};
            for (_loc_3 in _loc_1){
                
                _loc_2[_loc_3] = _loc_1[_loc_3];
            }
            return _loc_2;
        }
        public function get bytes() : ByteArray;

        public function get frameRate() : Number;

        public function get url() : String;

        public function get bytesLoaded() : uint;

        public function get sameDomain() : Boolean;

        public function get contentType() : String;

        public function get applicationDomain() : ApplicationDomain;

        public function get swfVersion() : uint;

        public function get actionScriptVersion() : uint;

        public function get bytesTotal() : uint;

        public function get loader() : Loader;

        public function get content() : DisplayObject;

        public function get loaderURL() : String;

        public function get sharedEvents() : EventDispatcher;

        public function get childAllowsParent() : Boolean;

        public static function getLoaderInfoByDefinition(object:Object) : LoaderInfo;

    }
}
