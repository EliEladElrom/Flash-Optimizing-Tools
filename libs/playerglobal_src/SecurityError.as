package 
{

    dynamic public class SecurityError extends Error {
        public static const length:int = 1;

        public function SecurityError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "SecurityError";
    }
}
