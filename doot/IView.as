package  doot{
	import flash.display.Sprite;
	/**
	 * @author colin
	 */
	public interface IView{
		function hide():IView;
		function show():IView;
		function getViewName() : String;
		function setView(mc:Sprite,autoHide:Boolean=true):IView;
		function getView():Sprite;
	}
}
