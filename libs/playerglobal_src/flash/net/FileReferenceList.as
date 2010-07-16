package flash.net
{
    import flash.events.*;

    public class FileReferenceList extends EventDispatcher {

        public function FileReferenceList() {
            return;
        }
        public function browse(typeFilter:Array = null) : Boolean;

        public function get fileList() : Array;

    }
}
