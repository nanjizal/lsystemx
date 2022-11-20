package drawings;
import lsystem.*;
@:forward
abstract Tiles( Drawing ) from Drawing to Drawing {
    public inline function new( iterations: Int, distance: Float, pos, lineFunc ){
        var options = { axiom : "[7]++[7]++[7]++[7]++[7]" };
        var lsystem = new LSystem(options);
        lsystem.setRule( "6", "81++91----71[-81----61]++" );
        lsystem.setRule( "7", "+81--91[---61--71]+" );
        lsystem.setRule( "8", "-61++71[+++81++91]-" );
        lsystem.setRule( "9", "--81++++61[+91++++71]--71" );
        lsystem.setRule( "1",'');
        lsystem.iterate( iterations );// 5
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
                    s.rotate(36.0);
                case '-'.code:
                    s.rotate(-36.0);
                case '6'.code,'7'.code, '8'.code, '9'.code, '1'.code:
                    line( cast s.forwardDraw( d ) );// 20 
            }
        }
    }
}