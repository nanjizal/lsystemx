package drawings;
import luxe.Color;
import lsystem.*;
@:forward
abstract Seaweed( Drawing ) from Drawing to Drawing {
    public inline function new( iterations: Int, distance: Float, pos, lineFunc, colorFunc ){
        var green = new Color().rgb(0x00ff00);
        var blue = new Color().rgb(0x0000ff);
        var red = new Color().rgb(0xff0000);
        var options = { axiom : "F" };
        var lsystem = new LSystem(options);
        lsystem.setRule( "F", "AFF[B-F++F][C+F--F]C++F--F" );
        lsystem.iterate( iterations );//5
        var angle = 180.0;
        var d = distance;
        var line = lineFunc;
        var color = colorFunc;
        this = new Drawing( lsystem, pos, angle );
        this.render = function( charCode: Int ): Void {
            var s = this.stack;
            switch( charCode ){
                case '['.code:
                    s.pushSame();
                case ']'.code:
                    s.pop();
                case '+'.code:
                    s.rotate(27.0);
                case '-'.code:
                    s.rotate(-27.0);
                case 'F'.code:
                    line( cast s.forwardDraw( d ) );// 1
                case 'A'.code:
                    color( red );
                case 'B'.code:
                    color( green );
                case 'C'.code:
                    color( blue );
            }
        }
    }
}