package doot.model.particle {
	import doot.model.utils.NumberUtil;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Spray {
		//to create the random position
		private var radius:Number = 10;
		private var powderCount:int = 10;

		public var minRadius:Number = 1;
		public var maxRadius:Number = 30;
		public var particleMinScale:Number = 0.1;
		public var particleMaxScale:Number = 1;
		public var density:Number = 1;

		public function Spray(minRadius:Number=1,maxRadius:Number=30,particleMinScale:Number=0.1,particleMaxScale:Number=1,density:Number=1){
			this.minRadius = minRadius;
			this.maxRadius = maxRadius;
			this.particleMinScale = particleMinScale;
			this.particleMaxScale = particleMaxScale;
			this.density = density;
		}

		public function start():void{
			radius = minRadius;
		}
		
		public function increaseRadius(speed:Number):Spray{
			radius+=speed;
			if(radius>maxRadius)radius = maxRadius;
			
			powderCount = radius*density;
			return this;
		}

		public function spary(x:Number,y:Number) : Array {
			//random powder position and size
			var result:Array = [];
			var featherAngle:Number;
			var featherRadius:Number;

			for(var i:int=0;i<powderCount;i++){
				//random powder position
				featherAngle = Math.random()*2*Math.PI;
				featherRadius = NumberUtil.randomRange(-this.radius, this.radius);

				result.push(new Particle(
					Math.cos(featherAngle)*featherRadius+x,
					Math.sin(featherAngle)*featherRadius+y,
					NumberUtil.randomRange(particleMinScale,particleMaxScale),
					NumberUtil.randomRange(0,360)
				));
			}
			return result;
		}
	}
}
