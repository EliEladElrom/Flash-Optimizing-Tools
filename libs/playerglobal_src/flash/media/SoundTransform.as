package flash.media
{

    final public class SoundTransform extends Object {

        public function SoundTransform(vol:Number = 1, panning:Number = 0) {
            this.volume = vol;
            this.pan = panning;
            return;
        }
        public function set pan(panning:Number) : void {
            this.leftToLeft = Math.sqrt(1 - panning);
            this.leftToRight = 0;
            this.rightToRight = Math.sqrt(1 + panning);
            this.rightToLeft = 0;
            return;
        }
        public function get rightToRight() : Number;

        public function get volume() : Number;

        public function get leftToLeft() : Number;

        public function set rightToRight(rightToRight:Number) : void;

        public function set leftToLeft(leftToLeft:Number) : void;

        public function set leftToRight(leftToRight:Number) : void;

        public function get leftToRight() : Number;

        public function set volume(volume:Number) : void;

        public function set rightToLeft(rightToLeft:Number) : void;

        public function get pan() : Number {
            if (this.leftToRight == 0){
            }
            if (this.rightToLeft == 0){
                return 1 - this.leftToLeft * this.leftToLeft;
            }
            return 0;
        }
        public function get rightToLeft() : Number;

    }
}
