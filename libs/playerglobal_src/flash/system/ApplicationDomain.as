package flash.system
{
    import flash.utils.*;

    final public class ApplicationDomain extends Object {

        public function ApplicationDomain(parentDomain:ApplicationDomain = null);

        public function get domainMemory() : ByteArray;

        public function getDefinition(name:String) : Object;

        public function set domainMemory(mem:ByteArray);

        public function hasDefinition(name:String) : Boolean;

        public function get parentDomain() : ApplicationDomain;

        public static function get currentDomain() : ApplicationDomain;

        public static function get MIN_DOMAIN_MEMORY_LENGTH() : uint;

    }
}
