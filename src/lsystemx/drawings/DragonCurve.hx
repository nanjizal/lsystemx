package drawings;
import lsystem.*;
@:forward
abstract DragonCurve( Drawing ) from Drawing to Drawing {
    public inline function new( iterations: Int, distance: Float, pos, lineFunc ){
        var options = { axiom : "FX" };
        var lsystem = new LSystem( options );
        lsystem.setRule( "X", "X+YF" );
        lsystem.setRule( "Y", "FX-Y" );
        lsystem.iterate( iterations );// 10 
        var angle = 270.0;
        var d = distance;
        var line = lineFunc;
        var node = new LNode( pos, angle );
        this = new Drawing( lsystem, StateStack.dynamicConstructor( node ) );
        this.render = function( charCode: Int ): Void {
            var s = this.stack;
            switch( charCode ){
                case "[".code:
                    s.pushSame();
                case "]".code:
                    s.pop();
                case "+".code:
                    s.rotate(90.0);
                case "-".code:
                    s.rotate(-90.0);
                case "F".code:
                    line( cast s.forwardDraw( d ) );// 10
            }
        }
    }
}