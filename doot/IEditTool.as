package  doot{
	import flash.display.Sprite;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public interface IEditTool {
		function getBtnRotate():Sprite;
		function getBtnMove():Sprite;
		function getBtnScale() : Sprite;
		function setBtnRotate(mc : Sprite) : void;
		function setBtnMove(mc : Sprite) : void;
		function setBtnScale(mc : Sprite) : void;
	}
}
