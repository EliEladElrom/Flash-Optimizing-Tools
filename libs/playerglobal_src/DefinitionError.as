package 
{

    dynamic public class DefinitionError extends Error {
        public static const length:int = 1;

        public function DefinitionError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "DefinitionError";
    }
}
