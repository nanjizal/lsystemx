package drawings;
import lsystem.*;
@:forward
abstract SierpinskiSnowFlake( Drawing ) from Drawing to Drawing {
    public inline function new( iterations: Int, distance: Float, pos, lineFunc ){
        var options = { axiom : "F++F++F" };
        var lsystem = new LSystem(options);
        lsystem.setRule( "F", "F-F++F-F" );
        lsystem.setRule( "X", "FF" );
        lsystem.iterate( iterations );//4
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
                    s.rotate( 60.0 );
                case '-'.code:
                    s.rotate( -60.0 );
                case 'F'.code,'X'.code:
                    line( cast s.forwardDraw( d ) );// 2
            }
        }
    }
}