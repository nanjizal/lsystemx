package;
import luxe.Input;
import luxe.Vector;
import lsystem.*;
import phoenix.geometry.Geometry;
import luxe.Color;
import drawings.*;
import khaMath.Vector2;
import target.BasicColors;
class Iteration extends luxe.Game {
    var red: Color;
    var currentColor: Color;
    var graphics: Array<Geometry>;
    var drawing: Drawing;
    var drawings: Array<Drawing>;
    var colors: Array<Color>;
    override function ready() {
        red = currentColor = BasicColors.Red;
        graphics = new Array<phoenix.geometry.Geometry>();
        colors =   [];
        drawings = [];
        var size: Float;
        var i1: Float;
        for( i in 0...10 ){
            if( i % 2 == 0 ){
                colors.push( red );
                i1 = i+1;
                size = 5000 / (i1*i1*i1*(i1/3));
                drawings.push( new SierpinskiTriangle( i, size, bottomRight(), line ) );
            }
        }
    }
    inline public function setColor( count: Int, col: Color ){
        colors[ count ] = col;
    }
    public function clear():Void {
        var geom;
        while ((geom = graphics.pop()) != null) geom.drop();
    }
    inline function position( x: Float, y: Float ): Vector2 {
        return new Vector2( x, y );
    }
    inline function centre():Vector2 {
        return new Vector2( Luxe.screen.w / 2, Luxe.screen.h / 2 );
    }
    inline function bottomRight():Vector2{
        return new Vector2( Luxe.screen.w - 50, Luxe.screen.h - 50 );
    }
    inline function topLeft():Vector{
        return new Vector( 80, 170 );
    }
    inline function line( line ){
        var start: LNode = line.start;
        var end:   LNode = line.end;
        var geom = Luxe.draw.line({
            p0 : new Vector( start.pos.x, start.pos.y ),
            p1 : new Vector( end.pos.x, end.pos.y ),
            color : currentColor
        });
        graphics[ graphics.length ] = geom;
    }
    override function onkeyup( e: KeyEvent ){
        if( e.keycode == Key.escape ) Luxe.shutdown();
    }
    var time: Int = 0;
    var speed: Int = 1;
    var j: Int = 1;
    var jold: Int = 0;
    override function update( dt: Float ){
        speed = Std.int(j*j*j*j);
        var delay;
        for( i in 0...speed ){
            drawing = drawings[ j ];
            currentColor = colors[ j ];
            if( drawing.hasNext() ){
                    delay = 4;
                    if( j != jold ) delay = 100;
                    if( ( time % delay ) == 0 ) {
                        if( j!= jold ) clear();
                        drawing.draw();
                        jold = j;
                    }
            } else {
                if( j < drawings.length - 1 ) { 
                    j++;
                    break;
                } else {
                    // reset
                    for( k in 0...drawings.length ){
                        drawings[k].iterator();
                        drawings[k].stack[0].pos = bottomRight();
                    }
                    j = 1;
                    break;
                }
            }
        }
        time++;
    }
}