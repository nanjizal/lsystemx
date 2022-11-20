package drawings;
import lsystem.*;
@:forward
abstract PlantE( Drawing ) from Drawing to Drawing {
    public inline function new( iterations: Int, distance: Float, pos, lineFunc ){
        var options = { axiom : 'X' };
        var lsystem = new LSystem(options);
        lsystem.setRule( "X", "F[+X][-X]FX" );
        lsystem.setRule( "F", "FF" );
        lsystem.iterate( iterations );// 7
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
                    s.rotate(27.5);
                case '-'.code:
                    s.rotate(-27.5);
                case 'X'.code,'F'.code:
                    line( cast s.forwardDraw( d ) );// 1
            }
        }
    }
}