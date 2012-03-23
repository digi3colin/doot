package doot.shimmerPaint {
	import doot.model.particle.Particle;

	import flash.display.Sprite;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteLayer implements ILayer {
		private var mc:Sprite;
		public function SpriteLayer(mc:Sprite){
			this.mc = mc;
		}

		public function paint(shimmer : Shimmer) : void {
			if(shimmer.context is Sprite){
				paintSprite((shimmer.context as Sprite), shimmer.particle);
			}else{
				paintBitmapDrawable(shimmer);
			}
		}
		
		private function paintSprite(mcShimmer:Sprite,particle:Particle):void{
			mcShimmer.x = particle.x;
			mcShimmer.y = particle.y;
			mcShimmer.scaleX = 
			mcShimmer.scaleY = particle.scale;
			mcShimmer.rotation = particle.rotation;

			mc.addChild(mcShimmer);		
		}
		
		private function paintBitmapDrawable(shimmer:Shimmer):void{
		
		}
	}
}
