package lsystemx;
class TwoNodes<T:ConstraintNode<T,Q>,Q> {
    public function new( a_: T, b_: T ){
        start = a_;
        end = b_;
    }
    public var start: T;
    public var end: T;
}