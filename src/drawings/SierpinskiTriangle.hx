package drawings;
import lsystem.*;
@:forward
abstract SierpinskiTriangle( Drawing ) from Drawing to Drawing {
    public inline function new( pos, lineFunc ){
        var options = { axiom : "A" };
        var lsystem = new LSystem(options);
        lsystem.setRule("A", "B-A-B");
        lsystem.setRule("B", "A+B+A");
        lsystem.iterate(8);
        var angle = 180.0;
        var line = lineFunc;
        this = new Drawing( lsystem, pos, angle );
        this.render = function( charCode: Int ): Void {
            var s = this.stack;
            switch( charCode ){
                case "[".code:
                    s.pushSame();
                case "]".code:
                    s.pop();
                case "+".code:
                    s.rotate(60.0);
                case "-".code:
                    s.rotate(-60.0);
                case 'A'.code,'B'.code:
                    line( cast s.forwardDraw(2) );
            }
        }
    }
}