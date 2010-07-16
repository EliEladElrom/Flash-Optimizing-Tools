package flash.filters
{

    final public class ColorMatrixFilter extends BitmapFilter {

        public function ColorMatrixFilter(matrix:Array = null) {
            if (matrix != null){
                this.matrix = matrix;
            }
            return;
        }
        public function get matrix() : Array;

        public function set matrix(value:Array) : void;

        override public function clone() : BitmapFilter {
            return new ColorMatrixFilter(this.matrix);
        }
    }
}
