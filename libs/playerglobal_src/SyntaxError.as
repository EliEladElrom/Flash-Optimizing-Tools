package 
{

    dynamic public class SyntaxError extends Error {
        public static const length:int = 1;

        public function SyntaxError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "SyntaxError";
    }
}
