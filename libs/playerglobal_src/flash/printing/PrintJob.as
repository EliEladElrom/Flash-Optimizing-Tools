package flash.printing
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class PrintJob extends EventDispatcher {
        private static const kGetPageHeight:uint = 5;
        private static const kGetOrientation:uint = 9;
        private static const kGetPaperHeight:uint = 1;
        private static const kGetPaperWidth:uint = 3;
        private static const kGetPageWidth:uint = 7;
        private static const kAddPage:uint = 101;
        private static const kStart:uint = 100;
        private static const kSend:uint = 102;

        public function PrintJob() {
            return;
        }
        public function get orientation() : String {
            return this.invoke(kGetOrientation);
        }
        public function get paperHeight() : int {
            return this.invoke(kGetPaperHeight);
        }
        private function toClassicRectangle(printArea:Rectangle) {
            if (printArea != null){
                return {xMin:printArea.left, yMin:printArea.top, xMax:printArea.right, yMax:printArea.bottom};
            }
            return null;
        }
        public function get pageHeight() : int {
            return this.invoke(kGetPageHeight);
        }
        public function get pageWidth() : int {
            return this.invoke(kGetPageWidth);
        }
        private function invoke(index:uint, ... args);

        public function start() : Boolean {
            return this.invoke(kStart) == true;
        }
        public function get paperWidth() : int {
            return this.invoke(kGetPaperWidth);
        }
        public function addPage(sprite:Sprite, printArea:Rectangle = null, options:PrintJobOptions = null, frameNum:int = 0) : void {
            var _loc_5:Object = null;
            if (options != null){
                _loc_5 = {printAsBitmap:options.printAsBitmap};
            }
            if (this._invoke(kAddPage, sprite, this.toClassicRectangle(printArea), _loc_5, frameNum > 0 ? (frameNum) : (-1)) == false){
                Error.throwError(Error, 2057);
            }
            return;
        }
        private function _invoke(index, ... args);

        public function send() : void {
            this.invoke(kSend);
            return;
        }
    }
}
