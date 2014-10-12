
import luxe.Input;
import lsystem.LSystem;
import lsystem.LSystemRenderer;

class Main extends luxe.Game 
{
	var m_currTime : Float = 0.0;
	var m_time : Float = 1.0;

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
    	renderer.draw(lsystem, 4);
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
