package doot.layout{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public interface IBoxLayout {
		function compose(displayObjects:Vector.<DisplayObject>):Vector.<Matrix>;
	}
}
