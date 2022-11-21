package lsystem.nodes;
import lsystemx.Mat1x2;
/**
    Basic LSystem node
**/
//@:structInit
class LNode {
    public var pos : Mat1x2;
    public var angle : Float;
    public function new( pos_: Mat1x2, angle_: Float ){
        pos = pos_;
        angle = angle_;
    }
    @:keep
    public inline
    function transform( distance: Float ): LNode {
        var deg = Deg2Rad( angle );
        return new LNode( 
                new Mat1x2({ x: pos.x + Math.cos( deg ) * distance, y: pos.y + Math.sin( deg ) * distance } ),
                angle );
    }
    @:keep
    public inline
    function clone(): LNode {
        return new LNode( {x: pos.x, y: pos.y }, angle );
    }
    @:keep
    public inline
    function addAngle( q: Float ): Void {
        angle += q;
    }
    inline function Deg2Rad(degrees : Float) : Float{
        return degrees * (Math.PI / 180.0);
    }
}