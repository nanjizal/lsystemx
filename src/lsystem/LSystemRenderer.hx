package lsystem;
import luxe.Vector;
import luxe.Color;
import luxe.Transform;

typedef NodeState = 
{
	pos : Vector,
	angle : Float
};

class LSystemRenderer
{
	private var m_stateStack : Array<NodeState>;

	public function new() : Void
	{
	}

	public function draw(lsystem : LSystem, linelength : Int) : Void
	{
		var m_stateStack = new Array<NodeState>();

		var initalState = {
			pos : new Vector(Luxe.screen.w / 2, Luxe.screen.h + 50),
			angle : 270.0
		};

		m_stateStack.push(initalState);

		var currentState = m_stateStack[m_stateStack.length - 1];

		Luxe.draw.circle({
		    x : currentState.pos.x,
		    y : currentState.pos.y,
		    r : 2,
		    color : new Color( 0.8, 0.3, 0.2, 1 )
		});

		//	Split the axiom into separate pieces and parse them.
		var commands = lsystem.options.axiom.split("");
		for( command in commands )
		{
			currentState = m_stateStack[m_stateStack.length - 1];
			

			if (command == "A" || command == "B" )
			{
				var newState = {
					pos : new Vector(currentState.pos.x + Math.cos(Deg2Rad(currentState.angle)) * linelength,
								currentState.pos.y + Math.sin(Deg2Rad(currentState.angle)) * linelength),
					angle : currentState.angle
				};

				Luxe.draw.line({
				    p0 : new Vector( currentState.pos.x, currentState.pos.y ),
				    p1 : new Vector( newState.pos.x, newState.pos.y ),
				    color : new Color( 0.5, 0.2, 0.2, 1 )
				});

				//	Apply changes from new transform to current.
				m_stateStack[m_stateStack.length - 1] = {pos : newState.pos.clone(), angle: newState.angle};

			}
			else if (command == "+")
			{
				currentState.angle -= lsystem.options.angle;
			}
			else if (command == "-")
			{
				currentState.angle += lsystem.options.angle;
			}
			else if (command == "[")
			{
				m_stateStack.push({pos:currentState.pos.clone(), angle:currentState.angle});
			}
			else if (command == "]")
			{
				m_stateStack.pop();
			}	
		}

		//	Pop the last one otherwise the root will still be in the array.
		m_stateStack.pop();
	}

	private function Deg2Rad(degrees : Float) : Float
	{
		return degrees * (Math.PI / 180.0);
	}
}