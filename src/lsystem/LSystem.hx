package lsystem;
import luxe.Entity;

typedef LSystemOptions = 
{
	axiom : String,
	angle : Float
}

class LSystem
{

	private var m_options : LSystemOptions;
	public var options (get, set) : LSystemOptions;
	private function get_options() : LSystemOptions { return m_options; }
	private function set_options(_options : LSystemOptions) : LSystemOptions { return m_options = _options; }

	private var m_rules : Map<String,String>;

	public function new( options : LSystemOptions ) : Void
	{
		m_options = options;
		m_rules = new Map<String, String>();
		createStandardRules();
	}

	//	Sets up standard rules for the L-System, these should not be changed.
	private function createStandardRules() : Void
	{
		m_rules.set("+", "+");
		m_rules.set("-", "-");
		m_rules.set("[", "[");
		m_rules.set("]", "]");
	}

	//	Iterates the L-System 'i' number of times.
	//	Each iteration changes the axiom of the L-System.
	public function iterate(i : Int) : Void
	{
		var currentIteration = 0;
		while( currentIteration < i )
		{
			var commands = m_options.axiom.split("");
			var newAxiom : String = "";
			for( command in commands )
			{
				newAxiom += parseCommand(command);
			}

			m_options.axiom = newAxiom;
			currentIteration++;
		}
		trace("New Axiom: " + m_options.axiom);
	}

	private function parseCommand(cmd : String) : String
	{
		if (m_rules.exists(cmd))
		{
			return m_rules.get(cmd);
		}

		return "";
	}

	//	Adds a new rule to the L-System.
	//	The rules decide what structure the L-System will have after iterating. 
	public function addRule(axiom : String, rule : String) : Void
	{
		m_rules[axiom] = rule;
	}
}