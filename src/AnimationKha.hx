package;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Image;
import kha.Color;
import kha.Assets;
import kha.input.Keyboard;
import kha.input.Mouse;
import kha.input.KeyCode;
import haxe.Http;
import lsystem.*;
import drawings.*;
import khaMath.Vector2;
import target.BasicColors;

typedef Line = { x0: Float, y0: Float, x1: Float, y1: Float, col: BasicColors }
class AnimationKha {
    var currentColor: Color;
    var lines: Array<Line> = [];
    var drawing: Drawing;
    var drawings: Array<Drawing>;
    var colors: Array<Color>;
    
    public function new() {
        currentColor = BasicColors.Red;
        colors =   [    BasicColors.Red
                    ,   BasicColors.Green
                    ,   BasicColors.Blue
                    ,   BasicColors.Red
                    ,   BasicColors.Green
                    ,   BasicColors.Green
                    ,   BasicColors.Red
                    ,   BasicColors.Green
                    ,   BasicColors.Yellow
                    ,   BasicColors.Red
                    ,   BasicColors.Grey ];
        drawings = [    new PenoTriangle( 7, 4.5, position( 700, 600), line )
                    ,   new FunnyTriangle( 6, 10, position( 100, 600 ), line )
                    ,   new Tiles( 5, 20, centre(), line )
                    ,   new Seaweed( 5, 1, position( 550, 600 ), line, setColor.bind( 3 ) )
                    ,   new PondWeed( 5, 5, position( 750, 600 ), line, setColor.bind( 4 ) )
                    ,   new SierpinskiSnowFlake( 4, 2, position( 500, 200 ), line )
                    ,   new Plant( 4, 4, position( 90, 600 ), line )
                    ,   new PlantE( 7, 1, position( 800, 300 ), line )
                    ,   new PlantD( 7, 1, position( 400, 400 ), line )
                    ,   new DragonCurve( 10, 10, topLeft(), line )
                    ,   new SierpinskiTriangle( 8, 2, bottomRight(), line )
        ];
        System.notifyOnRender(render);
        Scheduler.addTimeTask(update, 0, 1 / 60);
    }
    inline public function setColor( count: Int, col: Color ){
        colors[ count ] = col;
    }
    public function clear():Void {
        var aline;
        while ((aline = lines.pop()) != null) {
            
        }
    }
    inline function position( x: Float, y: Float ): Vector2 {
        return new Vector2( x, y );
    }
    inline function centre():Vector2 {
        return new Vector2( 1024/ 2, 768 / 2 );
    }
    inline function bottomRight():Vector2{
        return new Vector2( 1024 - 50, 768 - 50 );
    }
    inline function topLeft():Vector2{
        return new Vector2( 80, 170 );
    }
    inline function line( line ){
        var start: LNode = line.start;
        var end: LNode = line.end;
        var aline: Line = { x0: start.pos.x
                        ,   y0: start.pos.y
                        ,   x1: end.pos.x
                        ,   y1: end.pos.y
                        ,   col: currentColor };
        lines[ lines.length ] = aline;
    }
    var time: Int = 0;
    var speed: Int = 100;
    function update(): Void {
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
    function render(framebuffer: Framebuffer): Void {
        var g2 = framebuffer.g2;
        g2.begin();
        g2.clear( Color.fromValue(0xff000000) );
        var l = lines.length;
        for( i in 0...l ){
            var aline = lines[ i ];
            g2.color = aline.col;
            g2.drawLine( aline.x0, aline.y0, aline.x1, aline.y1, 1.0 );
        }
        g2.end();
    }
}