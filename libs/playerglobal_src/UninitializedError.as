package 
{

    dynamic public class UninitializedError extends Error {
        public static const length:int = 1;

        public function UninitializedError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "UninitializedError";
    }
}
