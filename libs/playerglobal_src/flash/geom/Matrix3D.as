package flash.geom
{
    import __AS3__.vec.*;

    public class Matrix3D extends Object {

        public function Matrix3D(v:Vector.<Number> = null);

        public function transpose() : void;

        public function prependTranslation(x:Number, y:Number, z:Number) : void;

        public function set rawData(v:Vector.<Number>) : void;

        public function deltaTransformVector(v:Vector3D) : Vector3D;

        public function get position() : Vector3D;

        public function pointAt(pos:Vector3D, at:Vector3D = null, up:Vector3D = null) : void;

        public function transformVectors(vin:Vector.<Number>, vout:Vector.<Number>) : void;

        public function prependRotation(degrees:Number, axis:Vector3D, pivotPoint:Vector3D = null) : void;

        public function prepend(rhs:Matrix3D) : void;

        public function transformVector(v:Vector3D) : Vector3D;

        public function appendScale(xScale:Number, yScale:Number, zScale:Number) : void;

        public function decompose(orientationStyle:String = "eulerAngles") : Vector.<Vector3D>;

        public function get rawData() : Vector.<Number>;

        public function interpolateTo(toMat:Matrix3D, percent:Number) : void;

        public function get determinant() : Number;

        public function invert() : Boolean;

        public function appendTranslation(x:Number, y:Number, z:Number) : void;

        public function appendRotation(degrees:Number, axis:Vector3D, pivotPoint:Vector3D = null) : void;

        public function set position(pos:Vector3D) : void;

        public function append(lhs:Matrix3D) : void;

        public function prependScale(xScale:Number, yScale:Number, zScale:Number) : void;

        public function clone() : Matrix3D {
            return new Matrix3D(this.rawData);
        }
        public function identity() : void;

        public function recompose(components:Vector.<Vector3D>, orientationStyle:String = "eulerAngles") : Boolean;

        public static function interpolate(thisMat:Matrix3D, toMat:Matrix3D, percent:Number) : Matrix3D;

    }
}
