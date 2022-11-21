package lsystemx.drawings;
import lsystemx.*;
@:transient
@:forward
abstract PondWeed( Drawing ) from Drawing to Drawing {
    public inline
    function new( iterations: Int, distance: Float, pos, lineFunc, colorFunc, traceAxiom = true ){
        var green   = 0xff00ff00;
        var blue    = 0xff0000ff;
        var red     = 0xffff0000;
        var options = { axiom : "F" };
        var lsystem = new LSystem(options);
        lsystem.setRule( "F", "AFF-[B-F+F+F]+[C+F-F-F]" );
        lsystem.iterate( iterations );// 5
        var angle = 270.0;
        var d     = distance;
        var line  = lineFunc;
        var color = colorFunc;
        var node  = new LNode( pos, angle );
        this      = new Drawing( lsystem, StateStack.dynamicConstructor( node ), traceAxiom );
        this.render = function( charCode: Int ): Void {
            var s = this.stack;
            switch( charCode ){
                case '['.code: 
                    s.pushSame();
                case ']'.code:
                    s.pop();
                case '+'.code:
                    s.rotate(  22.0 );
                case '-'.code:
                    s.rotate( -22.0 );
                case 'F'.code:
                    line( cast s.forwardDraw( d ) );//5
                case 'A'.code:
                    color( red   );
                case 'B'.code:
                    color( green );
                case 'C'.code:
                    color( blue   );
            }
        }
    }
}