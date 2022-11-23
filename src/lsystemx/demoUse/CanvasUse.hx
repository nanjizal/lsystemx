package lsystemx.demoUse;

import js.Browser;

// prerequesite    haxelib git https://github.com/nanjizal/htmlHelper.git
import htmlHelper.canvas.CanvasSetup;
import htmlHelper.canvas.Surface;
import htmlHelper.tools.DivertTrace;
import htmlHelper.tools.AnimateTimer;

import lsystemx.drawings.AnimationTest;

function main() {
    new CanvasUse();
}

class CanvasUse {
    public var canvasSetup = new CanvasSetup();
    var animationTest: AnimationTest;
    var dt = 0;
    var lastColor = 0xFFffFFff;
    var lastThick = 1.  ;
    var g: Surface;
    public function new(){
        canvasSetup = new CanvasSetup();
        g = canvasSetup.surface;
        animationTest = new AnimationTest( fillLine, 1025, 768, false );
        setAnimate();
    }
    inline
    function fillLine( sx: Float, sy: Float
                     , ex: Float, ey: Float
                     , thick: Float
                     , color: Int, ?alpha: Float = 1. ){
        // ignore alpha as not used uses 0xFFffFFff and not even alpha channel currently
        // currently does no drawings take advantage of line thickness but under future consideration
        color = color & 0xFFFFFF;
        if( lastColor != color  ) {
            g.endLines();
            g.lineStyle( thick, color, 1 );//|| lastThick != thick
            g.beginLines();
        }
        g.moveTo( sx, sy );
        g.lineTo( ex, ey );
        lastColor = color;
    }
    inline
    function setAnimate(){
        AnimateTimer.create();
        AnimateTimer.onFrame = function( v: Int ) render();
    }
    inline
    function render(){
        animationTest.update( dt++ );
        g.endLines();
    }
}