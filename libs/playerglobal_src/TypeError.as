package 
{

    dynamic public class TypeError extends Error {
        public static const length:int = 1;

        public function TypeError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "TypeError";
    }
}
