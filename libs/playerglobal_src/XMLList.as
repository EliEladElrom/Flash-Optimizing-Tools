package 
{

    final dynamic public class XMLList extends Object {
        public static const length:Object = 1;

        public function XMLList(value = ) {
            return;
        }
        override function hasOwnProperty(P = ) : Boolean;

        function insertChildBefore(child1, child2);

        function namespaceDeclarations() : Array;

        override function propertyIsEnumerable(P = ) : Boolean;

        function setChildren(value) : XML;

        function name() : Object;

        function replace(propertyName, value) : XML;

        function normalize() : XMLList;

        function inScopeNamespaces() : Array;

        function toXMLString() : String;

        function descendants(name = "*") : XMLList;

        function attributes() : XMLList;

        function processingInstructions(name = "*") : XMLList;

        function setNamespace(ns) : void;

        function setLocalName(name) : void;

        function namespace(prefix = null);

        function attribute(arg) : XMLList;

        function childIndex() : int;

        function contains(value) : Boolean;

        function appendChild(child) : XML;

        function hasComplexContent() : Boolean;

        function localName() : Object;

        function length() : int;

        function valueOf() : XMLList {
            return this;
        }
        function parent();

        function child(propertyName) : XMLList;

        function toString() : String;

        function hasSimpleContent() : Boolean;

        function prependChild(value) : XML;

        function setName(name) : void;

        function text() : XMLList;

        function copy() : XMLList;

        function nodeKind() : String;

        function elements(name = "*") : XMLList;

        function insertChildAfter(child1, child2);

        function addNamespace(ns) : XML;

        function comments() : XMLList;

        function removeNamespace(ns) : XML;

        function children() : XMLList;

        prototype.valueOf = Object.prototype.valueOf;
        prototype.hasOwnProperty = function (P = ) : Boolean {
            if (prototype === this){
                return this.hasOwnProperty(P);
            }
            var _loc_2:XMLList = this;
            return _loc_2.hasOwnProperty(P);
        }        ;
        prototype.propertyIsEnumerable = function (P = ) : Boolean {
            if (prototype === this){
                return this.propertyIsEnumerable(P);
            }
            var _loc_2:XMLList = this;
            return _loc_2.propertyIsEnumerable(P);
        }        ;
        prototype.toString = function () : String {
            if (prototype === this){
                return "";
            }
            var _loc_1:XMLList = this;
            return _loc_1.toString();
        }        ;
        prototype.addNamespace = function (ns) : XML {
            var _loc_2:XMLList = this;
            return _loc_2.addNamespace(ns);
        }        ;
        prototype.appendChild = function (child) : XML {
            var _loc_2:XMLList = this;
            return _loc_2.appendChild(child);
        }        ;
        prototype.attribute = function (arg) : XMLList {
            var _loc_2:XMLList = this;
            return _loc_2.attribute(arg);
        }        ;
        prototype.attributes = function () : XMLList {
            var _loc_1:XMLList = this;
            return _loc_1.attributes();
        }        ;
        prototype.child = function (propertyName) : XMLList {
            var _loc_2:XMLList = this;
            return _loc_2.child(propertyName);
        }        ;
        prototype.childIndex = function () : int {
            var _loc_1:XMLList = this;
            return _loc_1.childIndex();
        }        ;
        prototype.children = function () : XMLList {
            var _loc_1:XMLList = this;
            return _loc_1.children();
        }        ;
        prototype.comments = function () : XMLList {
            var _loc_1:XMLList = this;
            return _loc_1.comments();
        }        ;
        prototype.contains = function (value) : Boolean {
            var _loc_2:XMLList = this;
            return _loc_2.contains(value);
        }        ;
        prototype.copy = function () : XMLList {
            var _loc_1:XMLList = this;
            return _loc_1.copy();
        }        ;
        prototype.descendants = function (name = "*") : XMLList {
            var _loc_2:XMLList = this;
            return _loc_2.descendants(name);
        }        ;
        prototype.elements = function (name = "*") : XMLList {
            var _loc_2:XMLList = this;
            return _loc_2.elements(name);
        }        ;
        prototype.hasComplexContent = function () : Boolean {
            var _loc_1:XMLList = this;
            return _loc_1.hasComplexContent();
        }        ;
        prototype.hasSimpleContent = function () : Boolean {
            var _loc_1:XMLList = this;
            return _loc_1.hasSimpleContent();
        }        ;
        prototype.inScopeNamespaces = function () : Array {
            var _loc_1:XMLList = this;
            return _loc_1.inScopeNamespaces();
        }        ;
        prototype.insertChildAfter = function (child1, child2) {
            var _loc_3:XMLList = this;
            return _loc_3.insertChildAfter(child1, child2);
        }        ;
        prototype.insertChildBefore = function (child1, child2) {
            var _loc_3:XMLList = this;
            return _loc_3.insertChildBefore(child1, child2);
        }        ;
        prototype.length = function () : int {
            var _loc_1:XMLList = this;
            return _loc_1.length();
        }        ;
        prototype.localName = function () : Object {
            var _loc_1:XMLList = this;
            return _loc_1.localName();
        }        ;
        prototype.name = function () : Object {
            var _loc_1:XMLList = this;
            return _loc_1.name();
        }        ;
        prototype.namespace = function (prefix = null) {
            arguments = this;
            return arguments.namespace.apply(arguments, arguments);
        }        ;
        prototype.namespaceDeclarations = function () : Array {
            var _loc_1:XMLList = this;
            return _loc_1.namespaceDeclarations();
        }        ;
        prototype.nodeKind = function () : String {
            var _loc_1:XMLList = this;
            return _loc_1.nodeKind();
        }        ;
        prototype.normalize = function () : XMLList {
            var _loc_1:XMLList = this;
            return _loc_1.normalize();
        }        ;
        prototype.parent = function () {
            var _loc_1:XMLList = this;
            return _loc_1.parent();
        }        ;
        prototype.processingInstructions = function (name = "*") : XMLList {
            var _loc_2:XMLList = this;
            return _loc_2.processingInstructions(name);
        }        ;
        prototype.prependChild = function (value) : XML {
            var _loc_2:XMLList = this;
            return _loc_2.prependChild(value);
        }        ;
        prototype.removeNamespace = function (ns) : XML {
            var _loc_2:XMLList = this;
            return _loc_2.removeNamespace(ns);
        }        ;
        prototype.replace = function (propertyName, value) : XML {
            var _loc_3:XMLList = this;
            return _loc_3.replace(propertyName, value);
        }        ;
        prototype.setChildren = function (value) : XML {
            var _loc_2:XMLList = this;
            return _loc_2.setChildren(value);
        }        ;
        prototype.setLocalName = function (name) : void {
            var _loc_2:XMLList = this;
            _loc_2.setLocalName(name);
            return;
        }        ;
        prototype.setName = function (name) : void {
            var _loc_2:XMLList = this;
            _loc_2.setName(name);
            return;
        }        ;
        prototype.setNamespace = function (ns) : void {
            var _loc_2:XMLList = this;
            _loc_2.setNamespace(ns);
            return;
        }        ;
        prototype.text = function () : XMLList {
            var _loc_1:XMLList = this;
            return _loc_1.text();
        }        ;
        prototype.toXMLString = function () : String {
            var _loc_1:XMLList = this;
            return _loc_1.toXMLString();
        }        ;
        _dontEnumPrototype(prototype);
    }
}
