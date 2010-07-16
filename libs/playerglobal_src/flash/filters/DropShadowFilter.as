package flash.filters
{

    final public class DropShadowFilter extends BitmapFilter {

        public function DropShadowFilter(distance:Number = 4, angle:Number = 45, color:uint = 0, alpha:Number = 1, blurX:Number = 4, blurY:Number = 4, strength:Number = 1, quality:int = 1, inner:Boolean = false, knockout:Boolean = false, hideObject:Boolean = false) {
            this.distance = distance;
            this.angle = angle;
            this.color = color;
            this.alpha = alpha;
            this.blurX = blurX;
            this.blurY = blurY;
            this.quality = quality;
            this.strength = strength;
            this.inner = inner;
            this.knockout = knockout;
            this.hideObject = hideObject;
            return;
        }
        public function get hideObject() : Boolean;

        public function set blurX(value:Number) : void;

        public function get color() : uint;

        public function set blurY(value:Number) : void;

        public function set quality(value:int) : void;

        public function set angle(value:Number) : void;

        public function get strength() : Number;

        public function set hideObject(value:Boolean) : void;

        public function set distance(value:Number) : void;

        public function set inner(value:Boolean) : void;

        public function set color(value:uint) : void;

        public function set strength(value:Number) : void;

        public function get blurX() : Number;

        public function get blurY() : Number;

        public function get angle() : Number;

        public function set knockout(value:Boolean) : void;

        public function get distance() : Number;

        public function get inner() : Boolean;

        public function get knockout() : Boolean;

        public function set alpha(value:Number) : void;

        override public function clone() : BitmapFilter {
            return new DropShadowFilter(this.distance, this.angle, this.color, this.alpha, this.blurX, this.blurY, this.strength, this.quality, this.inner, this.knockout, this.hideObject);
        }
        public function get alpha() : Number;

        public function get quality() : int;

    }
}
