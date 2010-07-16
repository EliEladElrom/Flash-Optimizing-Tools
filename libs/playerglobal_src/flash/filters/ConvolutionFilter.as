package flash.filters
{

    public class ConvolutionFilter extends BitmapFilter {

        public function ConvolutionFilter(matrixX:Number = 0, matrixY:Number = 0, matrix:Array = null, divisor:Number = 1, bias:Number = 0, preserveAlpha:Boolean = true, clamp:Boolean = true, color:uint = 0, alpha:Number = 0) {
            this.matrixX = matrixX;
            this.matrixY = matrixY;
            if (matrix != null){
                this.matrix = matrix;
            }
            this.divisor = divisor;
            this.bias = bias;
            this.preserveAlpha = preserveAlpha;
            this.clamp = clamp;
            this.color = color;
            this.alpha = alpha;
            return;
        }
        public function get matrix() : Array;

        public function set matrix(value:Array) : void;

        public function get color() : uint;

        public function set preserveAlpha(value:Boolean) : void;

        public function get alpha() : Number;

        public function set color(value:uint) : void;

        public function set bias(value:Number) : void;

        public function set alpha(value:Number) : void;

        public function set matrixX(value:Number) : void;

        public function set matrixY(value:Number) : void;

        public function get preserveAlpha() : Boolean;

        public function set clamp(value:Boolean) : void;

        public function get matrixX() : Number;

        public function get matrixY() : Number;

        public function get bias() : Number;

        public function get clamp() : Boolean;

        public function set divisor(value:Number) : void;

        override public function clone() : BitmapFilter {
            return new ConvolutionFilter(this.matrixX, this.matrixY, this.matrix, this.divisor, this.bias, this.preserveAlpha, this.clamp, this.color, this.alpha);
        }
        public function get divisor() : Number;

    }
}
