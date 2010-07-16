package flash.geom
{

    public class PerspectiveProjection extends Object {

        public function PerspectiveProjection();

        public function get projectionCenter() : Point;

        public function toMatrix3D() : Matrix3D;

        public function get fieldOfView() : Number;

        public function set projectionCenter(p:Point);

        public function get focalLength() : Number;

        public function set fieldOfView(fieldOfViewAngleInDegrees:Number) : void;

        public function set focalLength(value:Number) : void;

    }
}
