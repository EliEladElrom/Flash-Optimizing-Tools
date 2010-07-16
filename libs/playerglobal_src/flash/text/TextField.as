package flash.text
{
    import flash.display.*;
    import flash.geom.*;

    public class TextField extends InteractiveObject {
        private static var richTextFields:Array = ["font", "size", "color", "bold", "italic", "underline", "url", "target", "align", "leftMargin", "rightMargin", "indent", "leading", "blockIndent", "kerning", "letterSpacing", "display"];

        public function TextField() {
            return;
        }
        public function set alwaysShowSelection(value:Boolean) : void;

        public function replaceText(beginIndex:int, endIndex:int, newText:String) : void;

        public function set sharpness(value:Number) : void;

        public function get wordWrap() : Boolean;

        public function setTextFormat(format:TextFormat, beginIndex:int = -1, endIndex:int = -1) : void;

        public function getLineLength(lineIndex:int) : int;

        function pasteRichText(richText:String) : Boolean {
            var richText:* = richText;
            try{
                this.insertXMLText(this.selectionBeginIndex, this.selectionEndIndex, richText, true);
            }
            catch (e:Error){
                return false;
            }
            return true;
        }
        public function set gridFitType(gridFitType:String) : void;

        public function getTextRuns(beginIndex:int = 0, endIndex:int = 2147483647) : Array;

        public function get caretIndex() : int;

        public function set wordWrap(value:Boolean) : void;

        public function get borderColor() : uint;

        public function set condenseWhite(value:Boolean) : void;

        public function get numLines() : int;

        public function get scrollH() : int;

        public function getLineOffset(lineIndex:int) : int;

        public function get maxScrollH() : int;

        public function set autoSize(value:String) : void;

        public function get defaultTextFormat() : TextFormat;

        public function getImageReference(id:String) : DisplayObject;

        public function get textWidth() : Number;

        public function get scrollV() : int;

        public function set backgroundColor(value:uint) : void;

        public function get embedFonts() : Boolean;

        public function get border() : Boolean;

        public function get multiline() : Boolean;

        public function get background() : Boolean;

        public function set maxChars(value:int) : void;

        public function set selectable(value:Boolean) : void;

        public function get maxScrollV() : int;

        public function set borderColor(value:uint) : void;

        public function set displayAsPassword(value:Boolean) : void;

        public function getLineText(lineIndex:int) : String;

        public function getFirstCharInParagraph(charIndex:int) : int;

        public function get mouseWheelEnabled() : Boolean;

        public function get textHeight() : Number;

        public function get restrict() : String;

        public function set scrollH(value:int) : void;

        function copyRichText() : String {
            return this.getXMLText(this.selectionBeginIndex, this.selectionEndIndex);
        }
        public function getRawText() : String;

        public function get alwaysShowSelection() : Boolean;

        public function get sharpness() : Number;

        public function getCharBoundaries(charIndex:int) : Rectangle;

        public function get gridFitType() : String;

        public function get styleSheet() : StyleSheet;

        public function get useRichTextClipboard() : Boolean;

        public function get type() : String;

        public function set defaultTextFormat(format:TextFormat) : void;

        public function replaceSelectedText(value:String) : void;

        public function get condenseWhite() : Boolean;

        public function getParagraphLength(charIndex:int) : int;

        public function get textColor() : uint;

        public function get displayAsPassword() : Boolean;

        public function get autoSize() : String;

        public function setSelection(beginIndex:int, endIndex:int) : void;

        public function set scrollV(value:int) : void;

        public function set useRichTextClipboard(value:Boolean) : void;

        public function get backgroundColor() : uint;

        public function get selectable() : Boolean;

        public function set antiAliasType(antiAliasType:String) : void;

        public function set border(value:Boolean) : void;

        public function get maxChars() : int;

        public function set multiline(value:Boolean) : void;

        public function getXMLText(beginIndex:int = 0, endIndex:int = 2147483647) : String {
            var _loc_7:TextRun = null;
            var _loc_8:TextFormat = null;
            var _loc_9:String = null;
            var _loc_10:XML = null;
            var _loc_11:uint = 0;
            var _loc_12:String = null;
            var _loc_13:* = undefined;
            var _loc_3:* = this.getTextRuns(beginIndex, endIndex);
            var _loc_4:* = this.getRawText();
            var _loc_5:* = <flashrichtext version=""1""/>")("<flashrichtext version="1"/>;
            var _loc_6:uint = 0;
            while (_loc_6 < _loc_3.length){
                
                _loc_7 = _loc_3[_loc_6];
                _loc_8 = _loc_7.textFormat;
                _loc_9 = _loc_4.substring(_loc_7.beginIndex, _loc_7.endIndex);
                _loc_9 = "(" + _loc_9 + ")";
                _loc_10 = new XML("<textformat>" + _loc_9 + "</textformat>");
                _loc_11 = 0;
                while (_loc_11 < richTextFields.length){
                    
                    _loc_12 = richTextFields[_loc_11];
                    _loc_13 = _loc_8[_loc_12];
                    if (_loc_13 != null){
                        _loc_10["@" + _loc_12] = _loc_13;
                    }
                    _loc_11 = _loc_11 + 1;
                }
                _loc_5.flashrichtext = _loc_5.flashrichtext + _loc_10;
                _loc_6 = _loc_6 + 1;
            }
            return _loc_5.toXMLString();
        }
        public function set background(value:Boolean) : void;

        public function set embedFonts(value:Boolean) : void;

        public function getCharIndexAtPoint(x:Number, y:Number) : int;

        public function set text(value:String) : void;

        public function get selectionEndIndex() : int;

        public function get selectionBeginIndex() : int;

        public function set mouseWheelEnabled(value:Boolean) : void;

        public function get length() : int;

        public function appendText(newText:String) : void {
            this.replaceText(this.text.length, this.text.length, newText);
            return;
        }
        public function get antiAliasType() : String;

        public function set styleSheet(value:StyleSheet) : void;

        public function set textColor(value:uint) : void;

        public function get selectedText() : String {
            return this.text.substring(this.selectionBeginIndex, this.selectionEndIndex);
        }
        public function set htmlText(value:String) : void;

        public function insertXMLText(beginIndex:int, endIndex:int, richText:String, pasting:Boolean = false) : void {
            var _loc_7:XML = null;
            var _loc_8:int = 0;
            var _loc_9:XMLList = null;
            var _loc_10:TextFormat = null;
            var _loc_11:XML = null;
            var _loc_12:String = null;
            var _loc_13:String = null;
            var _loc_14:String = null;
            var _loc_15:int = 0;
            var _loc_5:* = XML(richText);
            if (_loc_5.@version != "1"){
                Error.throwError(Error, 2138);
            }
            if (beginIndex > endIndex){
                _loc_8 = beginIndex;
                beginIndex = endIndex;
                endIndex = _loc_8;
            }
            var _loc_6:Boolean = true;
            for each (_loc_7 in _loc_5..textformat){
                
                _loc_9 = _loc_7.attributes();
                _loc_10 = new TextFormat();
                for each (_loc_11 in _loc_9){
                    
                    _loc_13 = _loc_11.name().localName;
                    _loc_14 = String(_loc_11);
                    if (_loc_13 != "bold"){
                    }
                    if (_loc_13 != "italic"){
                    }
                    if (_loc_13 == "underline"){
                        _loc_10[_loc_13] = _loc_14 == "true";
                        continue;
                    }
                    _loc_10[_loc_13] = _loc_14;
                }
                _loc_12 = String(_loc_7.children());
                _loc_12 = _loc_12.substring(1, (_loc_12.length - 1));
                if (this.maxChars > 0){
                }
                if (pasting == true){
                    _loc_15 = this.maxChars - this.length + (endIndex - beginIndex);
                    if (_loc_15 < _loc_12.length){
                        if (_loc_15 <= 0){
                            return;
                        }
                        _loc_12 = _loc_12.substring(0, _loc_15);
                    }
                }
                this.replaceText(beginIndex, endIndex, _loc_12);
                this.setTextFormat(_loc_10, beginIndex, beginIndex + _loc_12.length);
                beginIndex = beginIndex + _loc_12.length;
                endIndex = beginIndex;
                if (pasting){
                    this.setSelection(beginIndex, endIndex);
                }
                _loc_6 = false;
            }
            if (_loc_6){
                this.replaceText(beginIndex, endIndex, "");
            }
            return;
        }
        public function get text() : String;

        public function get thickness() : Number;

        public function getLineIndexAtPoint(x:Number, y:Number) : int;

        public function set thickness(value:Number) : void;

        public function get htmlText() : String;

        public function getLineMetrics(lineIndex:int) : TextLineMetrics;

        public function getTextFormat(beginIndex:int = -1, endIndex:int = -1) : TextFormat;

        public function set type(value:String) : void;

        public function getLineIndexOfChar(charIndex:int) : int;

        public function get bottomScrollV() : int;

        public function set restrict(value:String) : void;

        public static function isFontCompatible(fontName:String, fontStyle:String) : Boolean;

    }
}
