package renderers;
import luxe.Vector;
import luxe.Color;

typedef NodeState = 
{
	pos : Vector,
	angle : Float
};

class TurtleGraphicsRenderer
{
	private var m_stateStack : Array<NodeState>;

	public function new(initialPosition : Vector, initialAngle: Float) : Void
	{
		m_stateStack = new Array<NodeState>();
		m_stateStack.push({pos : initialPosition, angle : initialAngle});
	}

	public function rotate(degrees : Float) : Void
	{
		m_stateStack[m_stateStack.length - 1].angle += degrees;
	}

	public function push() : Void
	{
		var currentState = m_stateStack[m_stateStack.length - 1];
		m_stateStack.push({pos:currentState.pos.clone(), angle:currentState.angle});
	}

	public function pop() : Void
	{
		m_stateStack.pop();
	}

	public function moveForwardAndDraw(distance : Float) : Void
	{
		var currentState = m_stateStack[m_stateStack.length - 1];
		var newState = {
			pos : new Vector(currentState.pos.x + Math.cos(Deg2Rad(currentState.angle)) * distance,
						currentState.pos.y + Math.sin(Deg2Rad(currentState.angle)) * distance),
			angle : currentState.angle
		};

		Luxe.draw.line({
		    p0 : new Vector( currentState.pos.x, currentState.pos.y ),
		    p1 : new Vector( newState.pos.x, newState.pos.y ),
		    color : new Color( 0.5, 0.2, 0.2, 1 )
		});

		//	Apply changes from new state to current.
		m_stateStack[m_stateStack.length - 1] = {pos : newState.pos.clone(), angle: newState.angle};
	}

	public function moveForward(distance : Float) : Void
	{
		var currentState = m_stateStack[m_stateStack.length - 1];
		var newState = {
			pos : new Vector(currentState.pos.x + Math.cos(Deg2Rad(currentState.angle)) * distance,
						currentState.pos.y + Math.sin(Deg2Rad(currentState.angle)) * distance),
			angle : currentState.angle
		};

		//	Apply changes from new state to current.
		m_stateStack[m_stateStack.length - 1] = {pos : newState.pos.clone(), angle: newState.angle};
	}

	private function Deg2Rad(degrees : Float) : Float
	{
		return degrees * (Math.PI / 180.0);
	}
}