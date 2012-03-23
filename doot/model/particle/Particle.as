package doot.model.particle {
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Particle {
		public var x:Number;
		public var y:Number;
		public var scale:Number;
		public var rotation:Number;

		public function Particle(x:Number,y:Number,scale:Number,rotation:Number){
			this.x = x;
			this.y = y;
			this.scale = scale;
			this.rotation = rotation;
		}
	}
}
