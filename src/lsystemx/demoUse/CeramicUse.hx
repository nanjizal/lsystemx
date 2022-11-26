package lsystemx.demoUse;
// theoretical implementation
import lsystemx.drawings.AnimationTest;
//import ceramic.Color;
import ceramic.Line;
import ceramic.Scene;
class CeramicUse extends Scene {
    var time:Float;
    var animationTest: AnimationTest;
    var lastColor = 0xFFffFFff;
    var lastThick = 1.;
    var hi: Int = 768;
    var wid: Int = 1024; 
    // Mesh2D maybe lighter
    override
    function create() {
        time = 0;
        animationTest = new AnimationTest( fillLine, wid, hi, false );
    }
    public
    function fillLine( sx: Float, sy: Float
                     , ex: Float, ey: Float
                     , thick: Float
                     , color: Int, ?alpha: Float = 1. ){
        color = color & 0xFFFFFF;
        var line = new Line();
        if( lastColor != color  ) {
            line.color = color;
            line.thickness = thick;
        }
        line.points = [ sx, sy, ex, ey ];
        add( line );
        lastColor = color;
    }
    override
    function update( delta: Float ) {
        time += delta;
        animationTest.update();
    }
}