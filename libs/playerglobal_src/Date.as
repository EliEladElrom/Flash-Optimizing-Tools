package 
{
    import Date.*;

    final dynamic public class Date extends Object {
        public static const length:int = 7;

        public function Date(year = , month = , date = , hours = , minutes = , seconds = , ms = ) {
            return;
        }
        public function get month() : Number {
            return this.getMonth();
        }
        public function get monthUTC() : Number {
            return this.getUTCMonth();
        }
        public function set month(value:Number) {
            this.setMonth(value);
            return;
        }
        function getMilliseconds() : Number;

        public function set minutesUTC(value:Number) {
            this.setUTCMinutes(value);
            return;
        }
        public function get hours() : Number {
            return this.getHours();
        }
        private function _setTime(value:Number) : Number;

        function getUTCMinutes() : Number;

        public function get milliseconds() : Number {
            return this.getMilliseconds();
        }
        function setMilliseconds(ms = ) : Number;

        public function get hoursUTC() : Number {
            return this.getUTCHours();
        }
        public function get dateUTC() : Number {
            return this.getUTCDate();
        }
        private function _get(index:int) : Number;

        public function get fullYearUTC() : Number {
            return this.getUTCFullYear();
        }
        function toTimeString() : String {
            return this._toString(2);
        }
        function toUTCString() : String {
            return this._toString(6);
        }
        function setUTCMilliseconds(ms = ) : Number;

        public function get day() : Number {
            return this.getDay();
        }
        function setMinutes(min = , sec = , ms = ) : Number;

        public function set hours(value:Number) {
            this.setHours(value);
            return;
        }
        function getUTCMilliseconds() : Number;

        public function set time(value:Number) {
            this.setTime(value);
            return;
        }
        function getDate() : Number;

        public function get secondsUTC() : Number {
            return this.getUTCSeconds();
        }
        function toLocaleString() : String {
            return this._toString(3);
        }
        function valueOf() : Number;

        function getMinutes() : Number;

        public function set monthUTC(value:Number) {
            this.setUTCMonth(value);
            return;
        }
        public function set milliseconds(value:Number) {
            this.setMilliseconds(value);
            return;
        }
        function setUTCMinutes(min = , sec = , ms = ) : Number;

        public function get date() : Number {
            return this.getDate();
        }
        function setDate(date = ) : Number;

        function getUTCSeconds() : Number;

        function getUTCMonth() : Number;

        public function set dateUTC(value:Number) {
            this.setUTCDate(value);
            return;
        }
        function setUTCDate(date = ) : Number;

        public function set hoursUTC(value:Number) {
            this.setUTCHours(value);
            return;
        }
        function toDateString() : String {
            return this._toString(1);
        }
        function getUTCDate() : Number;

        function setUTCSeconds(sec = , ms = ) : Number;

        function setUTCMonth(month = , date = ) : Number;

        public function set fullYearUTC(value:Number) {
            this.setUTCFullYear(value);
            return;
        }
        function getUTCHours() : Number;

        function getTime() : Number;

        function setSeconds(sec = , ms = ) : Number;

        function setMonth(month = , date = ) : Number;

        function getSeconds() : Number;

        function getMonth() : Number;

        private function _toString(index:int) : String;

        public function get minutesUTC() : Number {
            return this.getUTCMinutes();
        }
        function setHours(hour = , min = , sec = , ms = ) : Number;

        function getUTCDay() : Number;

        function setTime(t = ) : Number {
            return this._setTime(t);
        }
        public function set secondsUTC(value:Number) {
            this.setUTCSeconds(value);
            return;
        }
        function toLocaleTimeString() : String {
            return this._toString(5);
        }
        function setUTCHours(hour = , min = , sec = , ms = ) : Number;

        public function set minutes(value:Number) {
            this.setMinutes(value);
            return;
        }
        public function set fullYear(value:Number) {
            this.setFullYear(value);
            return;
        }
        function getHours() : Number;

        public function set date(value:Number) {
            this.setDate(value);
            return;
        }
        public function get minutes() : Number {
            return this.getMinutes();
        }
        function getTimezoneOffset() : Number;

        public function set millisecondsUTC(value:Number) {
            this.setUTCMilliseconds(value);
            return;
        }
        public function get time() : Number {
            return this.getTime();
        }
        function getDay() : Number;

        public function get dayUTC() : Number {
            return this.getUTCDay();
        }
        function getFullYear() : Number;

        public function get millisecondsUTC() : Number {
            return this.getUTCMilliseconds();
        }
        function toString() : String {
            return this._toString(0);
        }
        function setFullYear(year = , month = , date = ) : Number;

        public function get fullYear() : Number {
            return this.getFullYear();
        }
        function toLocaleDateString() : String {
            return this._toString(4);
        }
        function setUTCFullYear(year = , month = , date = ) : Number;

        function getUTCFullYear() : Number;

        public function get timezoneOffset() : Number {
            return this.getTimezoneOffset();
        }
        public function set seconds(value:Number) {
            this.setSeconds(value);
            return;
        }
        public function get seconds() : Number {
            return this.getSeconds();
        }
        public static function UTC(year, month, date = 1, hours = 0, minutes = 0, seconds = 0, ms = 0, ... args) : Number;

        public static function parse(s) : Number;

        prototype.setTime = function (t = ) : Number {
            var _loc_2:Date = this;
            return _loc_2._setTime(t);
        }        ;
        prototype.valueOf = function () {
            var _loc_1:Date = this;
            return _loc_1.valueOf();
        }        ;
        prototype.toString = function () : String {
            var _loc_1:Date = this;
            return _loc_1._toString(0);
        }        ;
        prototype.toDateString = function () : String {
            var _loc_1:Date = this;
            return _loc_1.toDateString();
        }        ;
        prototype.toTimeString = function () : String {
            var _loc_1:Date = this;
            return _loc_1.toTimeString();
        }        ;
        prototype.toLocaleString = function () : String {
            var _loc_1:Date = this;
            return _loc_1.toLocaleString();
        }        ;
        prototype.toLocaleDateString = function () : String {
            var _loc_1:Date = this;
            return _loc_1.toLocaleDateString();
        }        ;
        prototype.toLocaleTimeString = function () : String {
            var _loc_1:Date = this;
            return _loc_1.toLocaleTimeString();
        }        ;
        prototype.toUTCString = function () : String {
            var _loc_1:Date = this;
            return _loc_1.toUTCString();
        }        ;
        prototype.getUTCFullYear = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getUTCFullYear();
        }        ;
        prototype.getUTCMonth = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getUTCMonth();
        }        ;
        prototype.getUTCDate = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getUTCDate();
        }        ;
        prototype.getUTCDay = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getUTCDay();
        }        ;
        prototype.getUTCHours = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getUTCHours();
        }        ;
        prototype.getUTCMinutes = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getUTCMinutes();
        }        ;
        prototype.getUTCSeconds = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getUTCSeconds();
        }        ;
        prototype.getUTCMilliseconds = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getUTCMilliseconds();
        }        ;
        prototype.getFullYear = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getFullYear();
        }        ;
        prototype.getMonth = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getMonth();
        }        ;
        prototype.getDate = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getDate();
        }        ;
        prototype.getDay = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getDay();
        }        ;
        prototype.getHours = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getHours();
        }        ;
        prototype.getMinutes = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getMinutes();
        }        ;
        prototype.getSeconds = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getSeconds();
        }        ;
        prototype.getMilliseconds = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getMilliseconds();
        }        ;
        prototype.getTimezoneOffset = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getTimezoneOffset();
        }        ;
        prototype.getTime = function () : Number {
            var _loc_1:Date = this;
            return _loc_1.getTime();
        }        ;
        prototype.setFullYear = function (year = , month = , date = ) : Number {
            arguments = this;
            return arguments.setFullYear.apply(arguments, arguments);
        }        ;
        prototype.setMonth = function (month = , date = ) : Number {
            arguments = this;
            return arguments.setMonth.apply(arguments, arguments);
        }        ;
        prototype.setDate = function (date = ) : Number {
            arguments = this;
            return arguments.setDate.apply(arguments, arguments);
        }        ;
        prototype.setHours = function (hour = , min = , sec = , ms = ) : Number {
            arguments = this;
            return arguments.setHours.apply(arguments, arguments);
        }        ;
        prototype.setMinutes = function (min = , sec = , ms = ) : Number {
            arguments = this;
            return arguments.setMinutes.apply(arguments, arguments);
        }        ;
        prototype.setSeconds = function (sec = , ms = ) : Number {
            arguments = this;
            return arguments.setSeconds.apply(arguments, arguments);
        }        ;
        prototype.setMilliseconds = function (ms = ) : Number {
            arguments = this;
            return arguments.setMilliseconds.apply(arguments, arguments);
        }        ;
        prototype.setUTCFullYear = function (year = , month = , date = ) : Number {
            arguments = this;
            return arguments.setUTCFullYear.apply(arguments, arguments);
        }        ;
        prototype.setUTCMonth = function (month = , date = ) : Number {
            arguments = this;
            return arguments.setUTCMonth.apply(arguments, arguments);
        }        ;
        prototype.setUTCDate = function (date = ) : Number {
            arguments = this;
            return arguments.setUTCDate.apply(arguments, arguments);
        }        ;
        prototype.setUTCHours = function (hour = , min = , sec = , ms = ) : Number {
            arguments = this;
            return arguments.setUTCHours.apply(arguments, arguments);
        }        ;
        prototype.setUTCMinutes = function (min = , sec = , ms = ) : Number {
            arguments = this;
            return arguments.setUTCMinutes.apply(arguments, arguments);
        }        ;
        prototype.setUTCSeconds = function (sec = , ms = ) : Number {
            arguments = this;
            return arguments.setUTCSeconds.apply(arguments, arguments);
        }        ;
        prototype.setUTCMilliseconds = function (ms = ) : Number {
            arguments = this;
            return arguments.setUTCMilliseconds.apply(arguments, arguments);
        }        ;
        _dontEnumPrototype(prototype);
    }
}
