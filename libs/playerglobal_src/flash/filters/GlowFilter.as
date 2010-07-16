package flash.filters
{

    final public class GlowFilter extends BitmapFilter {

        public function GlowFilter(color:uint = 16711680, alpha:Number = 1, blurX:Number = 6, blurY:Number = 6, strength:Number = 2, quality:int = 1, inner:Boolean = false, knockout:Boolean = false) {
            this.color = color;
            this.alpha = alpha;
            this.blurX = blurX;
            this.blurY = blurY;
            this.quality = quality;
            this.strength = strength;
            this.inner = inner;
            this.knockout = knockout;
            return;
        }
        public function get strength() : Number;

        public function set blurX(value:Number) : void;

        public function get color() : uint;

        public function set blurY(value:Number) : void;

        public function set quality(value:int) : void;

        public function set color(value:uint) : void;

        public function set strength(value:Number) : void;

        public function set inner(value:Boolean) : void;

        public function get blurX() : Number;

        public function get blurY() : Number;

        public function set knockout(value:Boolean) : void;

        public function get inner() : Boolean;

        public function get knockout() : Boolean;

        public function set alpha(value:Number) : void;

        override public function clone() : BitmapFilter {
            return new GlowFilter(this.color, this.alpha, this.blurX, this.blurY, this.strength, this.quality, this.inner, this.knockout);
        }
        public function get alpha() : Number;

        public function get quality() : int;

    }
}
