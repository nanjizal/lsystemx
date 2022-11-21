package lsystemx.drawings;
import lsystemx.*;
@:transient
@:forward
abstract SierpinskiTriangle( Drawing ) from Drawing to Drawing {
    public inline
    function new( iterations: Int, distance: Float, pos, lineFunc, traceAxiom = false ){
        var options = { axiom : "A" };
        var lsystem = new LSystem(options);
        lsystem.setRule("A", "B-A-B");
        lsystem.setRule("B", "A+B+A");
        lsystem.iterate( iterations );//8
        var angle   = 180.0;
        var d       = distance;
        var line    = lineFunc;
        var node    = new LNode( pos, angle );
        this        = new Drawing( lsystem, StateStack.dynamicConstructor( node ), traceAxiom );
        this.render = function( charCode: Int ): Void {
            var s = this.stack;
            switch( charCode ){
                case "[".code:
                    s.pushSame();
                case "]".code:
                    s.pop();
                case "+".code:
                    s.rotate(  60.0 );
                case "-".code:
                    s.rotate( -60.0 );
                case 'A'.code,'B'.code:
                    line( cast s.forwardDraw( d ) ); // 2
            }
        }
    }
}