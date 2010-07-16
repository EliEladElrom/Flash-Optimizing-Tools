package flash.display
{
    import flash.media.*;

    public class SimpleButton extends InteractiveObject {

        public function SimpleButton(upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null, hitTestState:DisplayObject = null) {
            if (upState){
                this.upState = upState;
            }
            if (overState){
                this.overState = overState;
            }
            if (downState){
                this.downState = downState;
            }
            if (hitTestState){
                this.hitTestState = hitTestState;
            }
            this._updateButton();
            return;
        }
        public function get enabled() : Boolean;

        public function set enabled(value:Boolean) : void;

        public function get hitTestState() : DisplayObject;

        public function set hitTestState(value:DisplayObject) : void;

        private function _updateButton() : void;

        public function set upState(value:DisplayObject) : void;

        public function get downState() : DisplayObject;

        public function set soundTransform(sndTransform:SoundTransform) : void;

        public function get soundTransform() : SoundTransform;

        public function get upState() : DisplayObject;

        public function set useHandCursor(value:Boolean) : void;

        public function set overState(value:DisplayObject) : void;

        public function get useHandCursor() : Boolean;

        public function get trackAsMenu() : Boolean;

        public function get overState() : DisplayObject;

        public function set downState(value:DisplayObject) : void;

        public function set trackAsMenu(value:Boolean) : void;

    }
}
