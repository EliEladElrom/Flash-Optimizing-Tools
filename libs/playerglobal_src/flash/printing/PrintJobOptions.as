package flash.printing
{

    public class PrintJobOptions extends Object {
        public var printAsBitmap:Boolean = false;

        public function PrintJobOptions(printAsBitmap:Boolean = false) {
            this.printAsBitmap = printAsBitmap;
            return;
        }
    }
}
