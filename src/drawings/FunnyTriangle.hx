package drawings;
import lsystem.*;
@:forward
abstract FunnyTriangle( Drawing ) from Drawing to Drawing {
    public inline function new( pos, lineFunc ){
        var options = { axiom : "W" };
        var lsystem = new LSystem(options);
        lsystem.setRule( "W", "+++X--F--ZFX+" );
        lsystem.setRule( "X", "---W++F++YFW-" );
        lsystem.setRule( "Y", "+ZFX--F--Z+++" );
        lsystem.setRule( "Z", "-YFW++F++Y---" );
        lsystem.iterate(6);
        var angle = 270.0;
        var line = lineFunc;
        this = new Drawing( lsystem, pos, angle );
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
                    line( cast s.forwardDraw(10) );
            }
        }
    }
}