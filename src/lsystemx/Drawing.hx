package lsystemx;
import lsystemx.*;
class Drawing {
    public var stack: StateStack< Dynamic, Dynamic >;
    var axiom:         String;
    public var length: Int;
    public var count:  Int;
    public var render: Int -> Void;
    public function new( lsystem: LSystem, stack: StateStack< Dynamic, Dynamic >, traceAxiom: Bool = true ){
        this.stack = stack;
        axiom = lsystem.options.axiom;
        if( traceAxiom ) trace( 'axiom ' + axiom );
        length = axiom.length;
        iterator();
    }
    public inline
    function renderWhole(){
        for( charCode in iterator() ){
            if( render != null ) render( charCode );
        }
    }
    public inline
    function iterator< Int >(): Iterator< Int > { 
        count = 0;
        return cast this;
    }
    inline public
    function hasNext(){
        return count < length;
    }
    inline public
    function next(){
        return StringTools.fastCodeAt( axiom, count++ );
    }
    inline public
    function draw(){
        if( render != null ) render( next() );
    }
}