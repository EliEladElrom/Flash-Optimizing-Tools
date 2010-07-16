package 
{

    dynamic public class EvalError extends Error {
        public static const length:int = 1;

        public function EvalError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "EvalError";
    }
}
