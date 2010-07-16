package flash.utils
{
    import flash.events.*;

    final class SetIntervalTimer extends Timer {
        var id:uint;
        private var rest:Array;
        private var closure:Function;
        private static var intervals:Array = [];

        function SetIntervalTimer(closure:Function, delay:Number, repeats:Boolean, rest:Array) {
            super(delay, repeats ? (0) : (1));
            this.closure = closure;
            this.rest = rest;
            addEventListener(TimerEvent.TIMER, this.onTimer);
            start();
            this.id = intervals.length + 1;
            intervals.push(this);
            return;
        }
        private function onTimer(event:Event) : void {
            this.closure.apply(null, this.rest);
            if (repeatCount == 1){
                if (intervals[(this.id - 1)] == this){
                    delete intervals[(this.id - 1)];
                }
            }
            return;
        }
        static function clearInterval(id_to_clear:uint) : void {
            id_to_clear = id_to_clear - 1;
            if (intervals[id_to_clear] is ){
                intervals[id_to_clear].stop();
                delete intervals[id_to_clear];
            }
            return;
        }
    }
}
