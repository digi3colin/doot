package doot.shimmerPaint {
	import doot.model.particle.Particle;
	import flash.display.IBitmapDrawable;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Shimmer{
		public var particle:Particle;
		public var context:IBitmapDrawable;
		public var brightness:Number;

		public function Shimmer(particle:Particle,brightness:Number,context:IBitmapDrawable):void{
			this.particle 	= particle;
			this.brightness = brightness;
			this.context= context;
		}
	}
}
