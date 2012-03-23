package doot.shimmerPaint {
	import doot.model.particle.Particle;

	import flash.display.Sprite;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ShimmerTemplate {
		private var mask:Sprite;
		public var passRate:Number = 0.001;

		public function ShimmerTemplate(){}
		
		public function setMask(mc:Sprite):void{
			this.mask = mc;
		}

		public function pass(particle:Particle):Boolean{
			//if no mask, always true;
			if(this.mask==null)return true;
			//the particle may pass through by random
			if(Math.random()<=passRate)return true;

			//check if the particle is inside mask;
			return this.mask.hitTestPoint(particle.x, particle.y, true);
		}
	}
}
