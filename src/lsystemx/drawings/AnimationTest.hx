package lsystemx.drawings;
import lsystemx.FillLine;
import lsystemx.drawings.*;
import lsystemx.Mat1x2;
//  All axioms and rules used as examples below come from the wikipedia page for L-Systems 
//  ( http://en.wikipedia.org/wiki/L-system ).
//  plantD, plantE, plantF from 1990 book Algorithmic Beauty of Plants.
//  another source http://www.kevs3d.co.uk/dev/lsystems/
@:structInit
class AnimationTest {
    var currentColor: Int;
    var currentThick: Float;
    var drawing:      Drawing;
    var drawings:     Array< Drawing >;
    var colors:       Array< Int >;
    var wid:          Float;
    var hi:           Float;
    var fillLine:     FillLine;
    var traceAxiom:   Bool;
    public
    function new( fillLine:  FillLine
                , wid: Float, hi: Float
                , traceAxiom = true ){
        this.fillLine = fillLine;
        this.wid      = wid;
        this.hi       = hi;
        currentThick  = 0.5;
        currentColor  = 0xFFFF0000;
        this.traceAxiom = traceAxiom;
        initDrawings();
    }
    inline
    function initDrawings(){
        colors = [ 
            0xFFFF0000
        ,   0xFF00FF00
        ,   0xFF0000FF
        ,   0xFFFF0000
        ,   0xFF00FF00
        ,   0xFF00FF00
        ,   0xFFFF0000
        ,   0xFF00FF00
        ,   0xFFFFFF00
        ,   0xFFFF0000
        ,   0xFF999999 ];
        drawings = [    
            new PenoTriangle(        7, 4.5, position( 700, 600),  line, traceAxiom )
        ,   new FunnyTriangle(       6, 10,  position( 100, 600 ), line, traceAxiom )
        ,   new Tiles(               5, 20,  centre(),             line, traceAxiom )
        ,   new Seaweed(             5, 1,   position( 550, 600 ), line, setColor.bind( 3 ), traceAxiom )
        ,   new PondWeed(            5, 5,   position( 750, 600 ), line, setColor.bind( 4 ), traceAxiom )
        ,   new SierpinskiSnowFlake( 4, 2,   position( 500, 200 ), line, traceAxiom )
        ,   new Plant(               4, 4,   position( 90, 600 ),  line, traceAxiom )
        ,   new PlantE(              7, 1,   position( 800, 300 ), line, traceAxiom )
        ,   new PlantD(              7, 1,   position( 400, 400 ), line, traceAxiom )
        ,   new DragonCurve(        10, 10,  topLeft(),            line, traceAxiom )
        ,   new SierpinskiTriangle(  8, 2,   bottomRight(),        line, traceAxiom )
        ];
    }
    public inline
    function setColor( count: Int, col: Int ){
        colors[ count ] = col;
    }
    public
    function clear():Void {
        // TODO..
    }
    inline
    function position( x: Float, y: Float ): Mat1x2 {
        return { x: x, y: y };
    }
    inline
    function centre(): Mat1x2 {
        return { x: wid / 2, y: hi / 2 };
    }
    inline
    function bottomRight(): Mat1x2 {
        return { x: wid - 50, y: hi - 50 };
    }
    inline
    function topLeft():Mat1x2{
        return { x: 80, y: 170 };
    }
    inline
    function line( line ){
        var start: LNode = line.start;
        var end:   LNode = line.end;
        //trace( start + ' ' + end );
        fillLine( start.pos.x, start.pos.y, end.pos.x, end.pos.y, currentThick, currentColor );
    }
    var time: Int = 0;
    var speed: Int = 100;
    public function update( dt: Float ){
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