
package lsystemx.demoUse;

import flixel.FlxGame;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import openfl.display.Sprite;
import flash.display.Graphics;
import lsystemx.drawings.AnimationTest;
using flixel.util.FlxSpriteUtil;

class FlixelUse extends Sprite {
	public function new(){
		super();
		addChild(new FlxGame(0, 0, Basic));
	}
}
class Basic extends FlxState {
    var flxlsystemx: FlxLsystemx;
    override public function create(){
        super.create();
        flxlsystemx = new FlxLsystemx( 10, 10, 1024, 768 );
        add( flxlsystemx );
        trace( 'testing ' + flxlsystemx );
    }
    override public function update( elapsed: Float ){
        super.update( elapsed );
        flxlsystemx.updateGraphics();
    }
}
class FlxLsystemx extends FlxSprite {
    var g: Graphics;
    var animationTest: AnimationTest;
    var lastColor = 0xFFffFFff;
    var lastThick = 1.;
    var hi: Int;
    var wid: Int;
    public function new( x: Float, y: Float, wid: Int, hi: Int ){
        super( x, y );
        this.hi = hi;
        this.wid = wid;
        clear();
        g = FlxSpriteUtil.flashGfx;
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
    public
    function updateGraphics(){
        FlxSpriteUtil.beginDraw( null, null );
        animationTest.update();
        FlxSpriteUtil.endDraw( this, {} );
    }
    public
    function background( color: FlxColor ){
        FlxSpriteUtil.drawRect( this, 0, 0, wid, hi, color );
    }
    public
    function clear(){
        makeGraphic( wid, hi, FlxColor.TRANSPARENT, true );
    }
}