package flash.text.engine
{
    import __AS3__.vec.*;

    final public class TextBlock extends Object {
        public var userData:Object;

        public function TextBlock(content:ContentElement = null, tabStops:Vector.<TabStop> = null, textJustifier:TextJustifier = null, lineRotation:String = "rotate0", baselineZero:String = "roman", bidiLevel:int = 0, applyNonLinearFontScaling:Boolean = true, baselineFontDescription:FontDescription = null, baselineFontSize:Number = 12) {
            if (content){
                this.content = content;
            }
            if (tabStops){
                this.tabStops = tabStops;
            }
            this.textJustifier = textJustifier ? (textJustifier) : (TextJustifier.getJustifierForLocale("en"));
            this.lineRotation = lineRotation;
            if (baselineZero){
                this.baselineZero = baselineZero;
            }
            this.bidiLevel = bidiLevel;
            this.applyNonLinearFontScaling = applyNonLinearFontScaling;
            if (baselineFontDescription){
                this.baselineFontDescription = baselineFontDescription;
                this.baselineFontSize = baselineFontSize;
            }
            return;
        }
        public function get textJustifier() : TextJustifier {
            return this.getTextJustifier().clone();
        }
        public function getTextLineAtCharIndex(charIndex:int) : TextLine;

        public function get firstLine() : TextLine;

        public function set textJustifier(value:TextJustifier) : void {
            var _loc_2:* = value ? (value.clone()) : (null);
            this.setTextJustifier(_loc_2);
            return;
        }
        public function get content() : ContentElement;

        private function getTextJustifier() : TextJustifier;

        public function findPreviousAtomBoundary(beforeCharIndex:int) : int;

        public function get baselineZero() : String;

        public function findNextAtomBoundary(afterCharIndex:int) : int;

        public function findNextWordBoundary(afterCharIndex:int) : int;

        public function set baselineFontDescription(value:FontDescription) : void;

        public function get lineRotation() : String;

        public function findPreviousWordBoundary(beforeCharIndex:int) : int;

        public function get applyNonLinearFontScaling() : Boolean;

        public function get bidiLevel() : int;

        private function getTabStops() : Vector.<TabStop>;

        public function set baselineZero(value:String) : void;

        public function get baselineFontSize() : Number;

        public function createTextLine(previousLine:TextLine = null, width:Number = 1000000, lineOffset:Number = 0, fitSomething:Boolean = false) : TextLine {
            if (this.content == null){
                return null;
            }
            if (previousLine != null){
            }
            if (previousLine.validity != TextLineValidity.VALID){
                Error.throwError(ArgumentError, 2004, "previousLine");
            }
            if (width < 0){
            }
            if (fitSomething != false){
            }
            if (width > TextLine.MAX_LINE_WIDTH){
                Error.throwError(ArgumentError, 2004, "width");
            }
            if (width == 0){
            }
            if (fitSomething == false){
                return null;
            }
            return this.DoCreateTextLine(previousLine, width, lineOffset, fitSomething);
        }
        private function setTabStops(value:Vector.<TabStop>) : void;

        public function get tabStops() : Vector.<TabStop> {
            var _loc_3:uint = 0;
            var _loc_4:TabStop = null;
            var _loc_5:TabStop = null;
            var _loc_1:* = this.getTabStops();
            var _loc_2:Vector.<TabStop> = null;
            if (_loc_1){
                _loc_2 = new Vector.<TabStop>;
                _loc_3 = 0;
                while (_loc_3 < _loc_1.length){
                    
                    _loc_4 = _loc_1[_loc_3];
                    _loc_5 = new TabStop(_loc_4.alignment, _loc_4.position, _loc_4.decimalAlignmentToken);
                    _loc_2.push(_loc_4);
                    _loc_3 = _loc_3 + 1;
                }
            }
            return _loc_2;
        }
        public function set lineRotation(value:String) : void;

        public function set applyNonLinearFontScaling(value:Boolean) : void;

        public function get lastLine() : TextLine;

        public function get baselineFontDescription() : FontDescription;

        public function set bidiLevel(value:int) : void;

        public function set baselineFontSize(value:Number) : void;

        public function set content(value:ContentElement) : void;

        public function dump() : String;

        private function DoCreateTextLine(previousLine:TextLine, width:Number, lineOffset:Number = 0, fitSomething:Boolean = false) : TextLine;

        public function set tabStops(value:Vector.<TabStop>) : void {
            var _loc_3:uint = 0;
            var _loc_4:TabStop = null;
            var _loc_5:TabStop = null;
            var _loc_2:Vector.<TabStop> = null;
            if (value){
                _loc_2 = new Vector.<TabStop>;
                _loc_3 = 0;
                while (_loc_3 < value.length){
                    
                    _loc_4 = value[_loc_3];
                    _loc_5 = new TabStop(_loc_4.alignment, _loc_4.position, _loc_4.decimalAlignmentToken);
                    _loc_2.push(_loc_4);
                    _loc_3 = _loc_3 + 1;
                }
            }
            this.setTabStops(_loc_2);
            return;
        }
        public function get firstInvalidLine() : TextLine;

        public function get textLineCreationResult() : String;

        private function setTextJustifier(value:TextJustifier) : void;

        public function releaseLines(firstLine:TextLine, lastLine:TextLine) : void;

    }
}
