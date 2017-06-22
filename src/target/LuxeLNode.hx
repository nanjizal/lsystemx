package target;
import luxe.Vector;
class LuxeLNode{
    public var pos : Vector;
    public var angle : Float;
    public function new( pos_: Vector, angle_: Float ){
        pos = pos_;
        angle = angle_;
    }
    inline public function transform( distance: Float ): LuxeLNode {
        var deg = Deg2Rad(angle);
        return new LuxeLNode( 
                new Vector( pos.x + Math.cos(deg) * distance, pos.y + Math.sin(deg) * distance ),
                angle );
    }
    inline public function clone(): LuxeLNode {
        return new LuxeLNode( pos.clone(), angle );
    }
    inline public function addAngle( q: Float ): Void {
        angle += q;
    }
    inline function Deg2Rad(degrees : Float) : Float{
        return degrees * (Math.PI / 180.0);
    }
}