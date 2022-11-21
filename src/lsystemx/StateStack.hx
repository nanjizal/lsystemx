package lsystemx;
@:transient
@:forward
abstract StateStack< T: ConstraintNode < T, Q >, Q >( Array< T > ) from Array< T > to Array< T > {
    inline public dynamicConstructor( node: Dynamic ): StateStack< Dynamic, Dynamic >{
        var statestack: StateStack< Dynamic, Dynamic > = new StateStack( node );
        return statestack;
    }
    public inline 
    function new( i: T ){
        this = new Array< T >();
        this[ 0 ] = i;
    }
    // adjust to pass Quaternions as well as degrees
    public inline
    function rotate( q: Q ): Void {
        this[ this.length - 1 ].addAngle( q );
    }
    public inline
    function pushSame(): Void {
        var currentState = this[ this.length - 1 ];
        this[ this.length ] = currentState.clone();
    }
    public inline
    function forwardDraw( distance : Float ): TwoNodes< T, Q > {
        var currentState = this[ this.length - 1 ];
        var newState = currentState.transform( distance );
        this[ this.length - 1 ] = newState;
        return new TwoNodes( currentState, newState );
    }
    public inline
    function forward( distance : Float ): Void {
        var currentState = this[ this.length - 1];
        var newState = currentState.transform( distance );
        this[ this.length - 1 ] = newState; 
    }
}