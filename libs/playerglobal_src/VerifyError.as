package 
{

    dynamic public class VerifyError extends Error {
        public static const length:int = 1;

        public function VerifyError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "VerifyError";
    }
}
