package lsystem;
import khaMath.Vector2;
class LNode{
    public var pos : Vector2;
    public var angle : Float;
    public function new( pos_: Vector2, angle_: Float ){
        pos = pos_;
        angle = angle_;
    }
    inline public function transform( distance: Float ): LNode {
        var deg = Deg2Rad(angle);
        return new LNode( 
                new Vector2( pos.x + Math.cos(deg) * distance, pos.y + Math.sin(deg) * distance ),
                angle );
    }
    inline public function clone(): LNode {
        return new LNode( new Vector2( pos.x, pos.y ), angle );
    }
    inline public function addAngle( q: Float ): Void {
        angle += q;
    }
    inline function Deg2Rad(degrees : Float) : Float{
        return degrees * (Math.PI / 180.0);
    }
}