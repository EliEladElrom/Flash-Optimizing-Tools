package flash.filters
{
    import flash.display.*;
    import flash.geom.*;

    final public class DisplacementMapFilter extends BitmapFilter {

        public function DisplacementMapFilter(mapBitmap:BitmapData = null, mapPoint:Point = null, componentX:uint = 0, componentY:uint = 0, scaleX:Number = 0, scaleY:Number = 0, mode:String = "wrap", color:uint = 0, alpha:Number = 0) {
            if (mapBitmap != null){
                this.mapBitmap = mapBitmap;
            }
            if (mapPoint != null){
                this.mapPoint = mapPoint;
            }
            this.componentX = componentX;
            this.componentY = componentY;
            this.scaleX = scaleX;
            this.scaleY = scaleY;
            this.mode = mode;
            this.color = color;
            this.alpha = alpha;
            return;
        }
        public function get componentY() : uint;

        override public function clone() : BitmapFilter {
            return new DisplacementMapFilter(this.mapBitmap, this.mapPoint, this.componentX, this.componentY, this.scaleX, this.scaleY, this.mode, this.color, this.alpha);
        }
        public function get alpha() : Number;

        public function set mode(value:String) : void;

        public function set mapPoint(value:Point) : void;

        public function set alpha(value:Number) : void;

        public function get mode() : String;

        public function get mapBitmap() : BitmapData;

        public function set color(value:uint) : void;

        public function get scaleX() : Number;

        public function get scaleY() : Number;

        public function get color() : uint;

        public function get mapPoint() : Point;

        public function set componentX(value:uint) : void;

        public function set componentY(value:uint) : void;

        public function get componentX() : uint;

        public function set scaleX(value:Number) : void;

        public function set mapBitmap(value:BitmapData) : void;

        public function set scaleY(value:Number) : void;

    }
}
