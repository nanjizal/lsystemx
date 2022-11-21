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
        initDraw();
        animationTest = new AnimationTest( fillLine, 1025, 768, true );
        setAnimate();
    }
    inline
    function initDraw(){
        g   = canvasSetup.surface;
        g.lineStyle( 1, lastColor );
    }
    inline
    function fillLine( sx: Float, sy: Float
                     , ex: Float, ey: Float
                     , thick: Float
                     , color: Int, ?alpha: Float ){
        // ignore alpha as not used uses 0xFFffFFff and not even alpha channel currently
        // currently does no drawings take advantage of line thickness but under future consideration
        if( lastColor != color  ) g.lineStyle( thick, color );//|| lastThick != thick
        g.moveTo( sx, sy );
        g.lineTo( ex, ey );
    }
    inline
    function setAnimate(){
        AnimateTimer.create();
        AnimateTimer.onFrame = function( v: Int ) render();
    }
    inline
    function render(){
        animationTest.update( dt++ );
    }
}