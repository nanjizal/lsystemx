package;
import luxe.Input;
import luxe.Vector;
import lsystem.*;
import target.LuxeLNode;
import luxe.Color;
//  All axioms and rules used as examples below come from the wikipedia page for L-Systems 
//  ( http://en.wikipedia.org/wiki/L-system ).
class Main extends luxe.Game {
    override function ready() {
        //fractalPlant();
        //dragonCurve();
        sierpinskiTriangle();
    } //ready
    function fractalPlant() : Void {
        var options = { axiom : "A" };
        var lsystem = new LSystem(options);
        lsystem.setRule( "A", "B-[[A]+A]+B[+BA]-A" );
        lsystem.setRule( "B", "BB" );
        lsystem.iterate(4);
        var node = new LuxeLNode( centre(), 270.0 );
        var stack = new StateStack( cast node );
        var axiom = lsystem.options.axiom;
        var l = axiom.length;
        for( i in 0...l ){
            switch( axiom.charAt(i) ){
                case '[':
                    stack.pushSame();
                case ']':
                    stack.pop();
                case '+':
                    stack.rotate(25.0);
                case '-':
                    stack.rotate(-25.0);
                case 'A','B':
                    luxeLine( cast stack.forwardDraw(4) );
            }
        }
    }
    function dragonCurve() : Void {
        var options = { axiom : "FX" };
        var lsystem = new LSystem( options );
        lsystem.setRule( "X", "X+YF" );
        lsystem.setRule( "Y", "FX-Y" );
        lsystem.iterate( 10 );
        var node = new LuxeLNode( centre(), 270.0 );
        var stack = new StateStack( cast node );
        var axiom = lsystem.options.axiom;
        var l = axiom.length;
        for( i in 0...l ){
            switch( axiom.charAt(i) ){
                case "[":
                    stack.pushSame();
                case "]":
                    stack.pop();
                case "+":
                    stack.rotate(90.0);
                case "-":
                    stack.rotate(-90.0);
                case "F":
                    luxeLine( cast stack.forwardDraw(12) );
            }
        }
    }
    function sierpinskiTriangle() : Void {
        var options = { axiom : "A" };
        var lsystem = new LSystem(options);
        lsystem.setRule("A", "B-A-B");
        lsystem.setRule("B", "A+B+A");
        lsystem.iterate(8);
        var node = new LuxeLNode( bottomRight(), 180.0 );
        var stack = new StateStack( cast node );
        var axiom = lsystem.options.axiom;
        var l = axiom.length;
        for( i in 0...l ){
            switch( axiom.charAt(i) ){
                case "[":
                    stack.pushSame();
                case "]":
                    stack.pop();
                case "+":
                    stack.rotate(60.0);
                case "-":
                    stack.rotate(-60.0);
                case 'A','B':
                    luxeLine( cast stack.forwardDraw(2) );
            }
        }
    }
    inline function centre():Vector {
        return new Vector( Luxe.screen.w / 2, Luxe.screen.h / 2 );
    }
    inline function bottomRight():Vector{
        return new Vector( Luxe.screen.w - 50, Luxe.screen.h - 50 );
    }
    inline function luxeLine( line ){
        var start: LuxeLNode = line.start;
        var end: LuxeLNode = line.end;
        Luxe.draw.line({
            p0 : start.pos.clone(),
            p1 : end.pos.clone(),
            color : new Color( 0.5, 0.2, 0.2, 1 )
        });
    }
    override function onkeyup( e: KeyEvent ){
        if( e.keycode == Key.escape ) Luxe.shutdown();
    }
    override function update( dt: Float ){}
}
