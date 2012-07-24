package doot.layout{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class LayoutCenter implements IBoxLayout {
		private var layoutScale:Number;
		private var w:Number;
		private var h:Number;

		public function LayoutCenter(w : Number = 1000, h : Number = 567) {
			this.w = w;
			this.h = h;
			layoutScale = w/1000;
		}

		public function compose(displayObjects : Vector.<DisplayObject>) : Vector.<Matrix> {
			var paddingTop:Number = layoutScale*90;
			var boundHeight:Number = layoutScale*437;//(567-40-90);
			var boundWidth:Number = layoutScale*800;
			var pageWidth:Number = layoutScale*1000;

			var mc:DisplayObject = displayObjects[0];
			var scale:Number = Math.min(boundHeight/mc.height,boundWidth/mc.width);
			var paddingLeft:Number = (pageWidth-(mc.width*scale))/2;
			var centerTop:Number = (boundHeight-(mc.height*scale))/2;

			var mtx:Matrix = new Matrix(scale,0,0,scale,paddingLeft,paddingTop+centerTop);
			
			return new <Matrix>[mtx];
		}
	}
}
import flash.geom.Matrix;
final class ViewObject{
	public var width:Number;
	public var height:Number;
	public var transform : Matrix;

	public function ViewObject(width : Number, height : Number) {
		this.width = width;
		this.height = height;
	}
}