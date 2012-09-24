package doot.sprite.transform {
	import flash.display.Sprite;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteTransform implements ITransformBehaviour {
		private var toDeg:Number=180/Math.PI;
		private var mc:Sprite;
		private var r:Number;
		private var s:Number;

		public function SpriteTransform(mc:Sprite){
			this.mc = mc;
			r = mc.rotation;
			s = mc.scaleX;
		}

		public function rotate(radian : Number) : void {
			r = radian;
			mc.rotation = radian*toDeg;
		}

		public function getRotate() : Number {
			return this.r;
		}

		public function scale(s : Number) : void {
			this.mc.scaleX = 
			this.mc.scaleY = s;
			this.s = s;
		}

		public function getScale() : Number {
			return this.s;
		}

		public function translate(tx : Number, ty : Number) : void {
			this.mc.x +=tx;
			this.mc.y +=ty;
		}
	}
}
