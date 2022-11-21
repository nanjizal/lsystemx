package lsystemx;

typedef LSystemOptions = { axiom : String }

class LSystem {
    var m_options:                  LSystemOptions;
    public var options( get, set ): LSystemOptions;
    function get_options():         LSystemOptions return m_options;
    function set_options( _options: LSystemOptions ): LSystemOptions return m_options = _options;
    var m_rules : Map<String,String>;
    public function new( options: LSystemOptions ): Void {
        m_options = options;
        m_rules   = new Map<String, String>();
        createStandardRules();
    }
    //	Sets up standard rules for the L-System, these should not be changed.
    function createStandardRules(): Void {
        m_rules.set( "+", "+" );
        m_rules.set( "-", "-" );
        m_rules.set( "[", "[" );
        m_rules.set( "]", "]" );
    }
    //	Iterates the L-System 'i' number of times.
    //	Each iteration changes the axiom of the L-System.
    public function iterate( i : Int ): Void {
        var currentIteration = 0;
        while( currentIteration < i ){
            var commands = m_options.axiom.split( "" );
            var newAxiom: String = "";
            for( command in commands ) newAxiom += parseCommand( command );
            m_options.axiom = newAxiom;
            currentIteration++;
        }
    }
    inline 
    function parseCommand( cmd: String ): String {
        return ( m_rules.exists( cmd ) )? m_rules.get(cmd): "";
    }
    //	Sets a rule to the L-System.
    //	The rules decide what structure the L-System will have after iterating.
    //	Old rules can be overridden by just setting the rule of the axiom again.
    public function setRule( axiom: String, rule: String ): Void {
        m_rules.set( axiom, rule );
    }
}