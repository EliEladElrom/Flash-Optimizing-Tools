package 
{

    dynamic public class URIError extends Error {
        public static const length:int = 1;

        public function URIError(message = "", id = 0) {
            super(message, id);
            this.name = prototype.name;
            return;
        }
        prototype.name = "URIError";
    }
}
