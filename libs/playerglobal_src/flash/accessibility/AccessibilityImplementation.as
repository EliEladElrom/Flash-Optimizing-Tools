package flash.accessibility
{
    import flash.geom.*;

    public class AccessibilityImplementation extends Object {
        public var errno:uint;
        public var stub:Boolean;

        public function AccessibilityImplementation() {
            this.stub = false;
            this.errno = 0;
            return;
        }
        public function isLabeledBy(labelBounds:Rectangle) : Boolean {
            return false;
        }
        public function get_accName(childID:uint) : String {
            return null;
        }
        public function get_accFocus() : uint {
            return 0;
        }
        public function get_accValue(childID:uint) : String {
            return null;
        }
        public function accDoDefaultAction(childID:uint) : void {
            return;
        }
        public function get_accSelection() : Array {
            return null;
        }
        public function get_accRole(childID:uint) : uint {
            Error.throwError(Error, 2143);
            return null;
        }
        public function accLocation(childID:uint) {
            return null;
        }
        public function getChildIDArray() : Array {
            return null;
        }
        public function get_accState(childID:uint) : uint {
            Error.throwError(Error, 2144);
            return null;
        }
        public function accSelect(operation:uint, childID:uint) : void {
            return;
        }
        public function get_accDefaultAction(childID:uint) : String {
            return null;
        }
    }
}
