package flash.filters
{
    import flash.display.*;
    import flash.geom.*;

    public class ShaderFilter extends BitmapFilter {

        public function ShaderFilter(shader:Shader = null) {
            if (shader){
                this.shader = shader;
            }
            return;
        }
        private function set _extendBy(extend:Rectangle) : void;

        public function get rightExtension() : int {
            return int(this._extendBy.right);
        }
        public function get shader() : Shader;

        public function set rightExtension(v:int) : void {
            var _loc_2:* = this._extendBy;
            _loc_2.right = Number(v);
            this._extendBy = _loc_2;
            return;
        }
        public function set bottomExtension(v:int) : void {
            var _loc_2:* = this._extendBy;
            _loc_2.bottom = Number(v);
            this._extendBy = _loc_2;
            return;
        }
        public function set shader(shader:Shader) : void;

        public function set leftExtension(v:int) : void {
            var _loc_2:* = this._extendBy;
            _loc_2.left = Number(v);
            this._extendBy = _loc_2;
            return;
        }
        public function get topExtension() : int {
            return int(this._extendBy.top);
        }
        public function set topExtension(v:int) : void {
            var _loc_2:* = this._extendBy;
            _loc_2.top = Number(v);
            this._extendBy = _loc_2;
            return;
        }
        private function get _extendBy() : Rectangle;

        public function get leftExtension() : int {
            return int(this._extendBy.left);
        }
        public function get bottomExtension() : int {
            return int(this._extendBy.bottom);
        }
    }
}
