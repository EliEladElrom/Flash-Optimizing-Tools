package flash.utils
{
    import flash.events.*;

    public class Timer extends EventDispatcher {
        private var m_repeatCount:int;
        private var m_iteration:int;
        private var m_delay:Number;

        public function Timer(delay:Number, repeatCount:int = 0) {
            if (delay >= 0){
            }
            if (!isFinite(delay)){
                Error.throwError(RangeError, 2066);
            }
            this.m_delay = delay;
            this.m_repeatCount = repeatCount;
            return;
        }
        private function _timerDispatch() : void;

        public function get delay() : Number {
            return this.m_delay;
        }
        public function set delay(value:Number) : void {
            if (value >= 0){
            }
            if (!isFinite(value)){
                Error.throwError(RangeError, 2066);
            }
            this.m_delay = value;
            if (this.running){
                this.stop();
                this.start();
            }
            return;
        }
        public function set repeatCount(value:int) : void {
            this.m_repeatCount = value;
            if (this.running){
            }
            if (this.m_repeatCount != 0){
            }
            if (this.m_iteration >= this.m_repeatCount){
                this.stop();
            }
            return;
        }
        private function _start(delay:Number, closure:Function) : void;

        private function tick() : void {
            var _loc_1:String = this;
            var _loc_2:* = this.m_iteration + 1;
            _loc_1.m_iteration = _loc_2;
            this._timerDispatch();
            if (this.m_repeatCount != 0){
            }
            if (this.m_iteration >= this.m_repeatCount){
                this.stop();
                dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE, false, false));
            }
            return;
        }
        public function reset() : void {
            if (this.running){
                this.stop();
            }
            this.m_iteration = 0;
            return;
        }
        public function get repeatCount() : int {
            return this.m_repeatCount;
        }
        public function start() : void {
            if (!this.running){
                this._start(this.m_delay, this.tick);
            }
            return;
        }
        public function stop() : void;

        public function get currentCount() : int {
            return this.m_iteration;
        }
        public function get running() : Boolean;

    }
}
