package 
{
    import Math.*;

    final public class Math extends Object {
        public static const E:Number = 2.71828;
        public static const SQRT1_2:Number = 0.707107;
        public static const SQRT2:Number = 1.41421;
        public static const LN10:Number = 2.30259;
        public static const LOG10E:Number = 0.434294;
        public static const LN2:Number = 0.693147;
        public static const LOG2E:Number = 1.4427;
        public static const PI:Number = 3.14159;

        public function Math() {
            return;
        }
        public static function abs(x:Number) : Number;

        public static function random() : Number;

        public static function acos(x:Number) : Number;

        public static function cos(x:Number) : Number;

        public static function ceil(x:Number) : Number;

        public static function round(x:Number) : Number;

        private static function _min(x:Number, y:Number) : Number;

        public static function asin(x:Number) : Number;

        public static function sin(x:Number) : Number;

        public static function atan2(x:Number, y:Number) : Number;

        public static function floor(x:Number) : Number;

        public static function log(x:Number) : Number;

        public static function exp(x:Number) : Number;

        public static function pow(x:Number, y:Number) : Number;

        private static function _max(x:Number, y:Number) : Number;

        public static function atan(x:Number) : Number;

        public static function tan(x:Number) : Number;

        public static function min(x:Number = , y:Number = , ... args) : Number;

        public static function max(x:Number = , y:Number = , ... args) : Number;

        public static function sqrt(x:Number) : Number;

    }
}
