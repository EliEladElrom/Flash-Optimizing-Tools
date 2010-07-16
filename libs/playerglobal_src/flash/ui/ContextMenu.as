package flash.ui
{
    import flash.events.*;
    import flash.net.*;

    final public class ContextMenu extends EventDispatcher {

        public function ContextMenu() {
            this.builtInItems = new ContextMenuBuiltInItems();
            this.customItems = new Array();
            this.initLinkAndClipboardProperties();
            return;
        }
        public function set builtInItems(value:ContextMenuBuiltInItems) : void;

        public function get builtInItems() : ContextMenuBuiltInItems;

        private function cloneLinkAndClipboardProperties(c:ContextMenu) : void;

        public function get clipboardItems() : ContextMenuClipboardItems;

        public function get customItems() : Array;

        public function set clipboardMenu(value:Boolean) : void;

        public function set link(value:URLRequest) : void;

        public function get clipboardMenu() : Boolean;

        public function get link() : URLRequest;

        public function set clipboardItems(value:ContextMenuClipboardItems) : void;

        private function initLinkAndClipboardProperties() : void;

        public function clone() : ContextMenu {
            var _loc_1:* = new ContextMenu();
            _loc_1.builtInItems = this.builtInItems.clone();
            this.cloneLinkAndClipboardProperties(_loc_1);
            var _loc_2:int = 0;
            while (_loc_2 < this.customItems.length){
                
                _loc_1.customItems.push(this.customItems[_loc_2].clone());
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }
        public function set customItems(value:Array) : void;

        public function hideBuiltInItems() : void {
            this.builtInItems.save = false;
            this.builtInItems.zoom = false;
            this.builtInItems.quality = false;
            this.builtInItems.play = false;
            this.builtInItems.loop = false;
            this.builtInItems.rewind = false;
            this.builtInItems.forwardAndBack = false;
            this.builtInItems.print = false;
            return;
        }
    }
}
