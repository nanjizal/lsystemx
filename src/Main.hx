
import luxe.Input;
import luxe.Vector;
import lsystem.LSystem;
import lsystem.LSystemRenderer;

//
//  All axioms and rules used as examples below come from the wikipedia page for L-Systems 
//  ( http://en.wikipedia.org/wiki/L-system ).
//


class Main extends luxe.Game 
{
    override function ready() 
    {
        //fractalPlant();
        //dragonCurve();
        sierpinskiTriangle();
    } //ready

    function fractalPlant() : Void
    {
        var options = {
            axiom : "A"
        };
        var lsystem = new LSystem(options);

        lsystem.addRule("A", "B-[[A]+A]+B[+BA]-A");
        lsystem.addRule("B", "BB");

        lsystem.iterate(4);

        var renderer = new LSystemRenderer(new Vector(Luxe.screen.w / 2, Luxe.screen.h / 2), 270.0, 4);

        for( i in 0...lsystem.options.axiom.length)
        {
            var char = lsystem.options.axiom.charAt(i);

            switch(char)
            {
                case "[":
                    renderer.push();
                case "]":
                    renderer.pop();
                case "+":
                    renderer.rotate(25.0);
                case "-":
                    renderer.rotate(-25.0);
                case "A":
                    renderer.moveForwardAndDraw();
                case "B":
                    renderer.moveForwardAndDraw();
            }
        }
    }

    function dragonCurve() : Void
    {
        var options = {
            axiom : "FX"
        };
        var lsystem = new LSystem(options);

        lsystem.addRule("X", "X+YF");
        lsystem.addRule("Y", "FX-Y");

        lsystem.iterate(10);

        var renderer = new LSystemRenderer(new Vector(Luxe.screen.w / 2, Luxe.screen.h / 2), 270.0, 12);

        for( i in 0...lsystem.options.axiom.length)
        {
            var char = lsystem.options.axiom.charAt(i);

            switch(char)
            {
                case "[":
                    renderer.push();
                case "]":
                    renderer.pop();
                case "+":
                    renderer.rotate(90.0);
                case "-":
                    renderer.rotate(-90.0);
                case "F":
                    renderer.moveForwardAndDraw();
            }
        }
    }

    function sierpinskiTriangle() : Void
    {
        var options = {
            axiom : "A"
        };
        var lsystem = new LSystem(options);

        lsystem.addRule("A", "B-A-B");
        lsystem.addRule("B", "A+B+A");

        lsystem.iterate(8);

        var renderer = new LSystemRenderer(new Vector(Luxe.screen.w - 50, Luxe.screen.h - 50), 180.0, 2);

        for( i in 0...lsystem.options.axiom.length)
        {
            var char = lsystem.options.axiom.charAt(i);

            switch(char)
            {
                case "[":
                    renderer.push();
                case "]":
                    renderer.pop();
                case "+":
                    renderer.rotate(60.0);
                case "-":
                    renderer.rotate(-60.0);
                case "A":
                    renderer.moveForwardAndDraw();
                case "B":
                    renderer.moveForwardAndDraw();
            }
        }
    }

    override function onkeyup( e:KeyEvent ) 
    {

        if(e.keycode == Key.escape) 
        {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) 
    {	

    } //update


} //Main
