
import luxe.Input;
import luxe.Vector;
import lsystem.LSystem;
import lsystem.LSystemRenderer;

class Main extends luxe.Game 
{
    override function ready() 
    {
        fractalPlant();
    	
    	//renderer.draw(lsystem, 4, 270.0, );
    } //ready

    function fractalPlant() : Void
    {
        var options = {
            axiom : "A",
            angle : 25.0
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
                    renderer.moveForward();
                case "B":
                    renderer.moveForward();
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
