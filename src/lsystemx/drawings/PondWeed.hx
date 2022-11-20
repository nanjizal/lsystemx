package drawings;
import luxe.Color;
import lsystem.*;
@:forward
abstract PondWeed( Drawing ) from Drawing to Drawing {
    public inline function new( iterations: Int, distance: Float, pos, lineFunc, colorFunc ){
        var green = new Color().rgb(0x00ff00);
        var blue = new Color().rgb(0x0000ff);
        var red = new Color().rgb(0xff0000);
        var options = { axiom : "F" };
        var lsystem = new LSystem(options);
        lsystem.setRule( "F", "AFF-[B-F+F+F]+[C+F-F-F]" );
        lsystem.iterate( iterations );// 5
        var angle = 270.0;
        var d = distance;
        var line = lineFunc;
        var color = colorFunc;
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
                    s.rotate(22.0);
                case '-'.code:
                    s.rotate(-22.0);
                case 'F'.code:
                    line( cast s.forwardDraw( d ) );//5
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