package flash.text.engine
{

    final public class ElementFormat extends Object {

        public function ElementFormat(fontDescription:FontDescription = null, fontSize:Number = 12, color:uint = 0, alpha:Number = 1, textRotation:String = "auto", dominantBaseline:String = "roman", alignmentBaseline:String = "useDominantBaseline", baselineShift:Number = 0, kerning:String = "on", trackingRight:Number = 0, trackingLeft:Number = 0, locale:String = "en", breakOpportunity:String = "auto", digitCase:String = "default", digitWidth:String = "default", ligatureLevel:String = "common", typographicCase:String = "default") {
            this.fontDescription = fontDescription ? (fontDescription) : (new FontDescription());
            this.fontSize = fontSize;
            this.color = color;
            this.alpha = alpha;
            this.textRotation = textRotation;
            this.dominantBaseline = dominantBaseline;
            this.alignmentBaseline = alignmentBaseline;
            this.baselineShift = baselineShift;
            this.kerning = kerning;
            this.trackingRight = trackingRight;
            this.trackingLeft = trackingLeft;
            this.locale = locale;
            this.breakOpportunity = breakOpportunity;
            this.digitCase = digitCase;
            this.digitWidth = digitWidth;
            this.ligatureLevel = ligatureLevel;
            this.typographicCase = typographicCase;
            return;
        }
        public function set baselineShift(value:Number) : void;

        public function set trackingLeft(value:Number) : void;

        public function get baselineShift() : Number;

        public function get dominantBaseline() : String;

        public function set color(value:uint) : void;

        public function get alignmentBaseline() : String;

        public function set dominantBaseline(dominantBaseline:String) : void;

        public function get textRotation() : String;

        public function get kerning() : String;

        public function set alignmentBaseline(alignmentBaseline:String) : void;

        public function set trackingRight(value:Number) : void;

        public function get breakOpportunity() : String;

        public function set textRotation(value:String) : void;

        public function set kerning(value:String) : void;

        public function get digitWidth() : String;

        public function set fontDescription(value:FontDescription) : void;

        public function set locked(value:Boolean) : void;

        public function clone() : ElementFormat {
            return new ElementFormat(this.fontDescription ? (this.fontDescription.clone()) : (null), this.fontSize, this.color, this.alpha, this.textRotation, this.dominantBaseline, this.alignmentBaseline, this.baselineShift, this.kerning, this.trackingRight, this.trackingLeft, this.locale, this.breakOpportunity, this.digitCase, this.digitWidth, this.ligatureLevel, this.typographicCase);
        }
        public function get alpha() : Number;

        public function set ligatureLevel(ligatureLevelType:String) : void;

        public function set fontSize(value:Number) : void;

        public function get locale() : String;

        public function get locked() : Boolean;

        public function get color() : uint;

        public function get trackingRight() : Number;

        public function set breakOpportunity(opportunityType:String) : void;

        public function get fontDescription() : FontDescription;

        public function set typographicCase(typographicCaseType:String) : void;

        public function get fontSize() : Number;

        public function set digitWidth(digitWidthType:String) : void;

        public function set locale(value:String) : void;

        public function get trackingLeft() : Number;

        public function get ligatureLevel() : String;

        public function set digitCase(digitCaseType:String) : void;

        public function get typographicCase() : String;

        public function set alpha(value:Number) : void;

        public function get digitCase() : String;

        public function getFontMetrics() : FontMetrics;

    }
}
