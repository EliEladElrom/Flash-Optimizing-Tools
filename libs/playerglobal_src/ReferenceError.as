package 
{

    dynamic public class ReferenceError extends Error {
        public static const length:int = 1;

        public function ReferenceError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "ReferenceError";
    }
}
