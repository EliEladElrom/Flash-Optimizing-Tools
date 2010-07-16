package flash.geom
{

    public class Point extends Object {
        public var x:Number;
        public var y:Number;

        public function Point(x:Number = 0, y:Number = 0) {
            this.x = x;
            this.y = y;
            return;
        }
        public function add(v:Point) : Point {
            return new Point(this.x + v.x, this.y + v.y);
        }
        public function get length() : Number {
            return Math.sqrt(this.x * this.x + this.y * this.y);
        }
        public function toString() : String {
            return "(x=" + this.x + ", y=" + this.y + ")";
        }
        public function normalize(thickness:Number) : void {
            var _loc_2:* = this.length;
            if (_loc_2 > 0){
                _loc_2 = thickness / _loc_2;
                this.x = this.x * _loc_2;
                this.y = this.y * _loc_2;
            }
            return;
        }
        public function subtract(v:Point) : Point {
            return new Point(this.x - v.x, this.y - v.y);
        }
        public function offset(dx:Number, dy:Number) : void {
            this.x = this.x + dx;
            this.y = this.y + dy;
            return;
        }
        public function clone() : Point {
            return new Point(this.x, this.y);
        }
        public function equals(toCompare:Point) : Boolean {
            if (toCompare.x == this.x){
            }
            return toCompare.y == this.y;
        }
        public static function interpolate(pt1:Point, pt2:Point, f:Number) : Point {
            return new Point(pt2.x + f * (pt1.x - pt2.x), pt2.y + f * (pt1.y - pt2.y));
        }
        public static function distance(pt1:Point, pt2:Point) : Number {
            return pt1.subtract(pt2).length;
        }
        public static function polar(len:Number, angle:Number) : Point {
            return new Point(len * Math.cos(angle), len * Math.sin(angle));
        }
    }
}
