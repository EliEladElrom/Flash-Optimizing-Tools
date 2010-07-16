package flash.geom
{
    import flash.display.*;

    public class Transform extends Object {

        public function Transform(displayObject:DisplayObject);

        public function get matrix() : Matrix;

        public function set matrix(value:Matrix) : void;

        public function set matrix3D(m:Matrix3D);

        public function get colorTransform() : ColorTransform;

        public function get perspectiveProjection() : PerspectiveProjection;

        public function get concatenatedMatrix() : Matrix;

        public function get matrix3D() : Matrix3D;

        public function getRelativeMatrix3D(relativeTo:DisplayObject) : Matrix3D;

        public function set perspectiveProjection(pm:PerspectiveProjection) : void;

        public function get concatenatedColorTransform() : ColorTransform;

        public function set colorTransform(value:ColorTransform) : void;

        public function get pixelBounds() : Rectangle;

    }
}
