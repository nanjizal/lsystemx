package lsystemx.demoUse;
import h2d.Graphics;
import lsystemx.drawings.AnimationTest;
function main() new HeapsUse();
class HeapsUse extends hxd.App {
    var g: h2d.Graphics; 
    var animationTest: AnimationTest;
    var lastColor = 0xFFffFFff;
    var lastThick = 1.;
    var hi: Int;
    var wid: Int; 
    override function init() {
        g = new h2d.Graphics(s2d);
        wid = 1024;
        hi = 768;
        animationTest = new AnimationTest( fillLine, wid, hi, false );
    }
    public
    function fillLine( sx: Float, sy: Float
                     , ex: Float, ey: Float
                     , thick: Float
                     , color: Int, ?alpha: Float = 1. ){
        color = color & 0xFFFFFF;
        if( lastColor != color  ) {
            g.lineStyle( thick, color, 1. );
        }   
        g.moveTo( sx, sy );
        g.lineTo( ex, ey );
        lastColor = color;
    }
    override function update(dt:Float) {
        animationTest.update();
    }
}