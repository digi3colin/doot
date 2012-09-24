package doot.geom {
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ParticleFactory {
		private static var ins : ParticleFactory;
		public static function instance():ParticleFactory{
			return ins || new ParticleFactory();
		}
		
		private var particles:Vector.<Particle>;
		private var index:int=0;
		private var count:int=300;
		public function ParticleFactory(){
			if(ins!=null)return;
			ins = this;
			
			particles = new Vector.<Particle>(count);
			for(var i:int=0;i<count;i++){
				particles[i] = new Particle(0, 0, 0, 0, 0, 30);
				particles[i].g = 0.05;
			}
		}
		
		public function reserve(x:Number,y:Number,z:Number):Particle{
			if(index>=count)index=0;
			var res:Particle = particles[index++];
			res.life = 600;
			res.x = x;
			res.y = y;
			res.z = z;
			res.vx=res.vy=res.vz=0;
			res.color = Math.floor(Math.random()*3);
			res.airResistance=4;

			return res;
		}
		
		public function release(index:int):void{
			particles[index].life = 0;
		}
		
		public function getParticles():Vector.<Particle>{
			return particles;
		};
	}
}
