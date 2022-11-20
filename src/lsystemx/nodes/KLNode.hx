package lsystem.nodes;
import khaMath.Vector2;
class KLNode{
    public var pos : Vector2;
    public var angle : Float;
    public function new( pos_: Vector2, angle_: Float ){
        pos = pos_;
        angle = angle_;
    }
    @:keep
    inline public function transform( distance: Float ): KLNode {
        var deg = Deg2Rad( angle );
        return new KLNode( 
                new Vector2( pos.x + Math.cos( deg ) * distance, pos.y + Math.sin( deg ) * distance ),
                angle );
    }
    @:keep
    inline public function clone(): KLNode {
        return new KLNode( new Vector2( pos.x, pos.y ), angle );
    }
    @:keep
    inline public function addAngle( q: Float ): Void {
        angle += q;
    }
    inline function Deg2Rad( degrees : Float ) : Float{
        return degrees * (Math.PI / 180.0);
    }
}