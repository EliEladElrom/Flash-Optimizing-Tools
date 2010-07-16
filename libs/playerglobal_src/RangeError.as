package 
{

    dynamic public class RangeError extends Error {
        public static const length:int = 1;

        public function RangeError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "RangeError";
    }
}
