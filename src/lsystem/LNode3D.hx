package lsystem;
import khaMath.Vector3;
import khaMath.FastMatrix4;
import khaMath.Quaternion;
// unused.
class LNode{
    public var pos : Vector3;
    public var angle : Quaternion;
    public function new( pos_: Vector3, angle_: Quaternion ){
        pos = pos_;
        angle = angle_;
    }
    inline public function transform( distance: Float ): LNode {
        return new LNode( 
                pos.multmat( FastMatrix4.fromMatrix4( angle.scale( distance ).matrix()) ),
                angle );
    }
    inline public function clone(): LNode {
        return new LNode( new Vector3( pos.x, pos.y, pos.z ), angle );
    }
    inline public function addAngle( q: Quaternion ): Void {
        angle = angle.add( q );
    }
}
