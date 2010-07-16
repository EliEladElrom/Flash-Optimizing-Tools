package flash.display
{
    import flash.events.*;

    public class ShaderJob extends EventDispatcher {

        public function ShaderJob(shader:Shader = null, target:Object = null, width:int = 0, height:int = 0) {
            if (shader){
                this.shader = shader;
            }
            if (target){
                this.target = target;
            }
            this.width = width;
            this.height = height;
            return;
        }
        public function start(waitForCompletion:Boolean = false) : void;

        public function get shader() : Shader;

        public function get width() : int;

        public function get height() : int;

        public function set target(s:Object) : void;

        public function set shader(s:Shader) : void;

        public function set width(v:int) : void;

        public function get progress() : Number;

        public function set height(v:int) : void;

        public function get target() : Object;

        public function cancel() : void;

    }
}
