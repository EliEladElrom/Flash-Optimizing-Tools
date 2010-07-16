package flash.filters
{

    final public class GradientBevelFilter extends BitmapFilter {

        public function GradientBevelFilter(distance:Number = 4, angle:Number = 45, colors:Array = null, alphas:Array = null, ratios:Array = null, blurX:Number = 4, blurY:Number = 4, strength:Number = 1, quality:int = 1, type:String = "inner", knockout:Boolean = false) {
            this.distance = distance;
            this.angle = angle;
            if (colors != null){
                this.colors = colors;
            }
            if (alphas != null){
                this.alphas = alphas;
            }
            if (ratios != null){
                this.ratios = ratios;
            }
            this.blurX = blurX;
            this.blurY = blurY;
            this.quality = quality;
            this.strength = strength;
            this.type = type;
            this.knockout = knockout;
            return;
        }
        public function set colors(value:Array) : void;

        public function get strength() : Number;

        public function set blurX(value:Number) : void;

        public function set blurY(value:Number) : void;

        public function set angle(value:Number) : void;

        public function get type() : String;

        public function get ratios() : Array;

        public function set strength(value:Number) : void;

        public function set alphas(value:Array) : void;

        public function get colors() : Array;

        public function get blurX() : Number;

        public function get blurY() : Number;

        public function get angle() : Number;

        public function set knockout(value:Boolean) : void;

        public function get distance() : Number;

        public function set ratios(value:Array) : void;

        public function set distance(value:Number) : void;

        public function get knockout() : Boolean;

        public function set type(value:String) : void;

        public function get alphas() : Array;

        override public function clone() : BitmapFilter {
            return new GradientBevelFilter(this.distance, this.angle, this.colors, this.alphas, this.ratios, this.blurX, this.blurY, this.strength, this.quality, this.type, this.knockout);
        }
        public function set quality(value:int) : void;

        public function get quality() : int;

    }
}
