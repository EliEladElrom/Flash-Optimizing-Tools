package flash.filters
{

    final public class BlurFilter extends BitmapFilter {

        public function BlurFilter(blurX:Number = 4, blurY:Number = 4, quality:int = 1) {
            this.blurX = blurX;
            this.blurY = blurY;
            this.quality = quality;
            return;
        }
        public function get blurX() : Number;

        public function set blurX(value:Number) : void;

        public function set blurY(value:Number) : void;

        public function get blurY() : Number;

        override public function clone() : BitmapFilter {
            return new BlurFilter(this.blurX, this.blurY, this.quality);
        }
        public function set quality(value:int) : void;

        public function get quality() : int;

    }
}
