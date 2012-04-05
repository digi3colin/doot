package doot.sprite {
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public interface ITransformBehaviour {
		function rotate(radian:Number):void;
		function getRotate():Number;
		function scale(s:Number):void;
		function getScale():Number;
		function translate(tx:Number,ty:Number):void;
		
	}
}
