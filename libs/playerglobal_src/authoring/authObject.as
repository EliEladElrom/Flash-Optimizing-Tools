package authoring
{
    import flash.display.*;
    import flash.geom.*;

    public class authObject extends Object {

        public function authObject(key:uint);

        public function FrameOffset() : int;

        public function CacheAsBitmap() : Boolean;

        public function EndPosition() : int;

        public function IsSelected() : Boolean;

        public function get Key() : uint;

        public function IsVisible(inThumbnailPreview:Boolean) : Boolean;

        public function StartPosition() : int;

        public function HasShapeSelection() : Boolean;

        public function MotionPath() : authObject;

        public function Bounds(flags:uint, minFrame:int = -16000, maxFrame:int = 16000) : Rectangle;

        public function ThreeDTranslationHandlePoints() : Array;

        public function ColorXForm(resultXForm:ColorTransform) : ColorTransform;

        public function get Type() : uint;

        public function CenterPoint() : Point;

        public function get SwfKey() : uint;

        public function IsFloater() : Boolean;

        public function OutlineColor() : uint;

        public function Filters() : Array;

        public function BlendingMode() : String;

        public function OutlineMode() : Boolean;

        public function FrameType() : uint;

        public function Locked() : Boolean;

        public function get FirstChild() : authObject;

        public function ThreeDMatrix() : Matrix3D;

        public function get NextSibling() : authObject;

        public function SymbolBehavior() : int;

        public function Scale9Grid() : Rectangle;

        public function LivePreviewSize() : Point;

        public function RegistrationPoint() : Point;

        public function HasEmptyPath() : Boolean;

        public function FrameForFrameNumber(frameNum:int) : authObject;

        public function SymbolMode() : int;

        public function IsPrimitive() : Boolean;

        public function ObjMatrix(resultMatrix:Matrix) : Matrix;

        public static function ApplyMatrix(target:DisplayObject, srcMatrix:Matrix) : Boolean;

        public static function ApplyColorXForm(target:DisplayObject, srcXForm:ColorTransform = null) : Boolean;

        public static function set offScreenSurfaceRenderingEnabled(value:Boolean) : void;

        public static function get offScreenSurfaceRenderingEnabled() : Boolean;

    }
}
