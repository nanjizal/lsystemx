
import luxe.Input;
import luxe.Vector;
import lsystem.LSystem;
import lsystem.LSystemRenderer;

class Main extends luxe.Game 
{
    override function ready() 
    {

    	var options = {
    		axiom : "A",
    		angle : 25.0
    	};
    	var lsystem = new LSystem(options);

    	lsystem.addRule("A", "B-[[A]+A]+B[+BA]-A");
    	lsystem.addRule("B", "BB");

    	lsystem.iterate(6);

    	var renderer = new LSystemRenderer();
    	renderer.draw(lsystem, 4, 270.0, new Vector(Luxe.screen.w / 2, Luxe.screen.h + 50));
    } //ready

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
