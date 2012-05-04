package  doot{
	import com.fastframework.core.IFASTEventDispatcher;
	import flash.display.Sprite;
	/**
	 * @author colin
	 */
	public interface IView extends IFASTEventDispatcher{
		function hide():IView;
		function show():IView;
		function getViewName() : String;
		function setView(mc:Sprite,autoHide:Boolean=true):IView;
		function getView():Sprite;
	}
}
