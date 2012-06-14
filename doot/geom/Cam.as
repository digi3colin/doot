package doot.geom {
	import doot.geom.Pt3;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Cam extends Pt3 {
		public var focusDistance : Number;
		public var stageWidth : Number;
		public var stageHeight : Number;

		public function Cam(x : Number = 0, y : Number = 0, z : Number = 0, focusDistance:Number=700,stageWidth:Number=1000,stageHeight:Number=567) {
			super(x, y, z);
			this.focusDistance = focusDistance;
			this.stageWidth = stageWidth;
			this.stageHeight= stageHeight;
		}
	}
}
