package doot.sprite.transform {
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteDrawTransform implements ITransformBehaviour {
		private var toDeg:Number=180/Math.PI;
		private var mc:Sprite;
		private var r:Number;
		private var s:Number;
		private var mtx:Matrix;

		public function SpriteDrawTransform(mc : Sprite) {
			this.mc = mc;
			r = mc.rotation;
			s = mc.scaleX;
			this.mtx = new Matrix();
		}

		public function rotate(radian : Number) : void {
			var bbox:Rectangle = mc.getBounds(mc);
			var center:Point = mtx.transformPoint(new Point(bbox.x+bbox.width*0.5,bbox.y+bbox.height*0.5));
			mtx.translate(-center.x, -center.y);
			mtx.rotate(radian-r);
			mtx.translate(center.x, center.y);

			mc.transform.matrix = mtx;

			r = radian;
			mc.rotation = radian*toDeg;
		}

		public function getRotate() : Number {
			return r;
		}

		public function scale(s : Number) : void {
			var bbox:Rectangle = mc.getBounds(mc);
			var center:Point = mtx.transformPoint(new Point(bbox.x+bbox.width*0.5,bbox.y+bbox.height*0.5));
			mtx.translate(-center.x, -center.y);
			mtx.scale(1/this.s, 1/this.s);
			mtx.scale(s,s);
			mtx.translate(center.x, center.y);

			mc.transform.matrix = mtx;

			this.s = s;
		}

		public function getScale() : Number {
			return s;
		}

		public function translate(tx : Number, ty : Number) : void {
			mtx.translate(tx, ty);
			mc.transform.matrix = mtx;
		}
	}
}
