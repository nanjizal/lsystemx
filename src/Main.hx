package;
import luxe.Input;
import luxe.Vector;
import lsystem.*;
import target.LuxeLNode;
import phoenix.geometry.Geometry;
import luxe.Color;
import drawings.*;

//  All axioms and rules used as examples below come from the wikipedia page for L-Systems 
//  ( http://en.wikipedia.org/wiki/L-system ).
//  plantD, plantE, plantF from 1990 book Algorithmic Beauty of Plants.
//  another source http://www.kevs3d.co.uk/dev/lsystems/
class Main extends luxe.Game {
    var green: Color;
    var blue: Color;
    var red: Color;
    var yellow: Color;
    var darkRed: Color;
    var white: Color;
    var grey: Color;
    var currentColor: Color;
    var graphics: Array<Geometry>;
    var drawing: Drawing;
    var drawings: Array<Drawing>;
    var colors: Array<Color>;
    override function ready() {
        green = new Color().rgb(0x00ff00);
        blue = new Color().rgb(0x0000ff);
        red = new Color().rgb(0xff0000);
        yellow = new Color().rgb( 0xFFFF00 );
        white = new Color().rgb( 0xFFFFFF );
        grey = new Color().rgb( 0xcccccc );
        darkRed = new Color( 0.5, 0.2, 0.2, 1 );
        currentColor = red;
        graphics = new Array<phoenix.geometry.Geometry>();
        colors =   [    red, green, blue, red, green, green, red, green, yellow, red, grey ];
        drawings = [    new PenoTriangle( position( 700, 600), line )
                    ,   new FunnyTriangle( position( 100, 600 ), line )
                    ,   new Tiles( centre(), line )
                    ,   new Seaweed( position( 550, 600 ), line, setColor.bind( 3 ) )
                    ,   new PondWeed( position( 750, 600 ), line, setColor.bind( 4 ) )
                    ,   new SierpinskiSnowFlake( position( 500, 200 ), line )
                    ,   new Plant( position( 90, 600 ), line )
                    ,   new PlantE( position( 800, 300 ), line )
                    ,   new PlantD( position( 400, 400 ), line )
                    ,   new DragonCurve( topLeft(), line )
                    ,   new SierpinskiTriangle( bottomRight(), line )
        ];
    }
    inline public function setColor( count: Int, col: Color ){
        colors[ count ] = col;
    }
    public function clear():Void {
        var geom;
        while ((geom = graphics.pop()) != null) geom.drop();
    }
    inline function position( x: Float, y: Float ): Vector {
        return new Vector( x, y );
    }
    inline function centre():Vector {
        return new Vector( Luxe.screen.w / 2, Luxe.screen.h / 2 );
    }
    inline function bottomRight():Vector{
        return new Vector( Luxe.screen.w - 50, Luxe.screen.h - 50 );
    }
    inline function topLeft():Vector{
        return new Vector( 80, 170 );
    }
    inline function line( line ){
        var start: LuxeLNode = line.start;
        var end: LuxeLNode = line.end;
        var geom = Luxe.draw.line({
            p0 : start.pos.clone(),
            p1 : end.pos.clone(),
            color : currentColor
        });
        graphics[ graphics.length ] = geom;
    }
    override function onkeyup( e: KeyEvent ){
        if( e.keycode == Key.escape ) Luxe.shutdown();
    }
    var time: Int = 0;
    var speed: Int = 100;
    override function update( dt: Float ){
        if( time == 1000 ) {
            speed = 10;
            clear();
        }
        for( i in 0...speed ){
            var j = 0;
            for( drawing in drawings ){
                if( time > 1000 || ( j == 3 || j == 4 ) ){
                    currentColor = colors[ j ];
                    if( drawing.hasNext() ){
                        drawing.draw();
                    } else {}
                }
                j++;
            }
        }
        time++;
    }
}
