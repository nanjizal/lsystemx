package drawings;
import lsystem.*;
@:forward
abstract FunnyTriangle( Drawing ) from Drawing to Drawing {
    public inline function new( iterations: Int, distance: Float, pos, lineFunc ){
        var options = { axiom : "W" };
        var lsystem = new LSystem(options);
        lsystem.setRule( "W", "+++X--F--ZFX+" );
        lsystem.setRule( "X", "---W++F++YFW-" );
        lsystem.setRule( "Y", "+ZFX--F--Z+++" );
        lsystem.setRule( "Z", "-YFW++F++Y---" );
        lsystem.iterate( iterations );// 6
        var angle = 270.0;
        var d = distance;
        var line = lineFunc;
        var node = new LNode( pos, angle );
        this = new Drawing( lsystem, StateStack.dynamicConstructor( node ) );
        this.render = function( charCode: Int ): Void {
            var s = this.stack;
            switch( charCode ){
                case '['.code:
                    s.pushSame();
                case ']'.code:
                    s.pop();
                case '+'.code:
                    s.rotate(30.0);
                case '-'.code:
                    s.rotate(-30.0);
                case 'F'.code,'W'.code,'X'.code, 'Y'.code, 'Z'.code:
                    line( cast s.forwardDraw( d ) );// 10
            }
        }
    }
}