package flash.desktop
{
    import flash.utils.*;

    public class Clipboard extends Object {
        private static var _toFlash:Dictionary;
        private static var _fromFlash:Dictionary;
        private static const WRITE_ACCESS_ERROR:String = "Writing to clipboard not permitted in this context";
        private static const LIFETIME_ERROR:String = "Attempt to access a dead clipboard";
        private static const READ_ACCESS_ERROR:String = "Reading from clipboard not permitted in this context";
        private static var _wasFormatMapInitialized:Boolean = false;

        public function Clipboard() {
            initFormatMap();
            return;
        }
        private function get canReadContents() : Boolean;

        private function getHTML() : String;

        private function getOriginal(format:String) : Object {
            return this.convertNativeFormat(REFERENCE_PREFIX + format);
        }
        private function convertNativeFormat(format:String) : Object {
            var _loc_2:* = _toFlash[format];
            if (_loc_2){
                return this._loc_2(this);
            }
            var _loc_3:* = REFERENCE_PREFIX == format.substr(0, REFERENCE_PREFIX.length);
            var _loc_4:* = SERIALIZATION_PREFIX == format.substr(0, SERIALIZATION_PREFIX.length);
            if (_loc_3){
                return this.getObjectReference(format);
            }
            if (_loc_4){
                return this.getDeserialization(format);
            }
            return undefined;
        }
        private function checkAccess(requestRead:Boolean, requestWrite:Boolean) : void {
            if (!this.alive){
                throw new IllegalOperationError(LIFETIME_ERROR);
            }
            if (requestRead){
            }
            if (!this.canReadContents){
                throw new SecurityError(READ_ACCESS_ERROR);
            }
            if (requestWrite){
            }
            if (!this.canWriteContents){
                throw new SecurityError(WRITE_ACCESS_ERROR);
            }
            return;
        }
        private function get alive() : Boolean;

        private function getString() : String;

        private function putString(s:String) : void;

        public function clear() : void;

        private function putRTF(rtf:ByteArray) : void;

        private function getObjectReference(format:String) : Object;

        public function clearData(format:String) : void;

        private function getDeserialization(format:String) : Object {
            var _loc_2:* = this.getByteArray(format);
            if (!_loc_2){
                return null;
            }
            return _loc_2.readObject();
        }
        private function convertFlashFormat(flashFormat:String, data:Object, serializable:Boolean) : Boolean {
            var _loc_4:* = undefined;
            if (isSystemFormat(flashFormat)){
                _loc_4 = _fromFlash[flashFormat];
                if (_loc_4){
                    this._loc_4(this, data);
                    return true;
                }
                return false;
            }
            this.putObjectReference(REFERENCE_PREFIX + flashFormat, data);
            if (serializable){
                this.putSerialization(SERIALIZATION_PREFIX + flashFormat, data);
            }
            return true;
        }
        public function get formats() : Array;

        public function getData(format:String, transferMode:String = "originalPreferred") : Object {
            var _loc_3:Object = null;
            this.checkAccess(true, false);
            _loc_3 = this.convertNativeFormat(format);
            if (_loc_3){
                return _loc_3;
            }
            switch(transferMode){
                case ORIGINAL_PREFERRED:{
                    _loc_3 = this.getOriginal(format);
                    if (_loc_3 == undefined){
                        _loc_3 = this.getClone(format);
                    }
                    return _loc_3;
                }
                case ORIGINAL_ONLY:{
                    return this.getOriginal(format);
                }
                case CLONE_PREFERRED:{
                    _loc_3 = this.getClone(format);
                    if (_loc_3 == undefined){
                        _loc_3 = this.getOriginal(format);
                    }
                    return _loc_3;
                }
                case CLONE_ONLY:{
                    return this.getClone(format);
                }
                default:{
                    throw new Error("Illegal value for transferMode: " + transferMode);
                    break;
                }
            }
        }
        private function putSerialization(format:String, data:Object) : void {
            var _loc_3:* = new ByteArray();
            _loc_3.writeObject(data);
            this.putByteArray(format, _loc_3);
            return;
        }
        private function putByteArray(format:String, bytes:ByteArray) : void;

        private function getClone(format:String) : Object {
            return this.convertNativeFormat(SERIALIZATION_PREFIX + format);
        }
        private function get canWriteContents() : Boolean;

        public function setData(format:String, data:Object, serializable:Boolean = true) : Boolean {
            if (format == null){
                Error.throwError(TypeError, 2007, "format");
            }
            if (data == null){
                Error.throwError(TypeError, 2007, "data");
            }
            if (format != URL_FORMAT){
            }
            if (format != FILE_LIST_FORMAT){
            }
            if (format == BITMAP_FORMAT){
                return false;
            }
            this.checkAccess(false, true);
            return this.convertFlashFormat(format, data, serializable);
        }
        private function getRTF() : ByteArray;

        public function hasFormat(format:String) : Boolean {
            this.checkAccess(false, false);
            return this.formats.indexOf(format) != -1;
        }
        private function putHTML(html:String) : void;

        private function getByteArray(format:String) : ByteArray;

        private function putObjectReference(format:String, data:Object) : void;

        public function setDataHandler(format:String, handler:Function, serializable:Boolean = true) : Boolean {
            var toNative:*;
            var format:* = format;
            var handler:* = handler;
            var serializable:* = serializable;
            if (format == null){
                Error.throwError(TypeError, 2007, "format");
            }
            if (handler == null){
                Error.throwError(TypeError, 2007, "handler");
            }
            if (format != URL_FORMAT){
            }
            if (format != FILE_LIST_FORMAT){
            }
            if (format == BITMAP_FORMAT){
                return false;
            }
            this.checkAccess(false, true);
            var fullHandler:* = function () : void {
                var _loc_1:* = handler() as Object;
                setData(format, _loc_1, serializable);
                return;
            }            ;
            if (isSystemFormat(format)){
                toNative = _fromFlash[format];
                if (!toNative){
                    return false;
                }
                this.nativeSetHandler(format, fullHandler);
            }
            else{
                this.nativeSetHandler(REFERENCE_PREFIX + format, fullHandler);
                if (serializable){
                    this.nativeSetHandler(SERIALIZATION_PREFIX + format, fullHandler);
                }
            }
            return true;
        }
        private function nativeSetHandler(format:String, handler:Function) : void;

        public static function get generalClipboard() : Clipboard;

        private static function isSystemFormat(format:String) : Boolean {
            if (FLASH_PREFIX != format.substr(0, FLASH_PREFIX.length)){
            }
            return AIR_PREFIX == format.substr(0, AIR_PREFIX.length);
        }
        private static function initFormatMap() : void {
            if (!_wasFormatMapInitialized){
                _fromFlash = new Dictionary();
                _toFlash = new Dictionary();
                addFormatMapping(TEXT_FORMAT, function (clipboard:Clipboard, text:String) : void {
                clipboard.putString(text);
                return;
            }            , function (clipboard:Clipboard) : String {
                return clipboard.getString();
            }            );
                addFormatMapping(HTML_FORMAT, function (clipboard:Clipboard, html:String) : void {
                clipboard.putHTML(html);
                return;
            }            , function (clipboard:Clipboard) : String {
                return clipboard.getHTML();
            }            );
                addFormatMapping(RICH_TEXT_FORMAT, function (clipboard:Clipboard, rtf:ByteArray) : void {
                clipboard.putRTF(rtf);
                return;
            }            , function (clipboard:Clipboard) : ByteArray {
                return clipboard.getRTF();
            }            );
                _wasFormatMapInitialized = true;
            }
            return;
        }
        private static function addFormatMapping(flashFormat:String, exportFromFlash:Function, importToFlash:Function) {
            _fromFlash[flashFormat] = exportFromFlash;
            _toFlash[flashFormat] = importToFlash;
            return;
        }
    }
}
