package flash.geom
{
    import __AS3__.vec.*;

    public class Utils3D extends Object {

        public function Utils3D() {
            return;
        }
        public static function pointTowards(percent:Number, mat:Matrix3D, pos:Vector3D, at:Vector3D = null, up:Vector3D = null) : Matrix3D;

        public static function projectVector(m:Matrix3D, v:Vector3D) : Vector3D;

        public static function projectVectors(m:Matrix3D, verts:Vector.<Number>, projectedVerts:Vector.<Number>, uvts:Vector.<Number>) : void;

    }
}
