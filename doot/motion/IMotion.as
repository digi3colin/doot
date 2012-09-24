package doot.motion {
	import com.fastframework.core.IFASTEventDispatcher;
	/**
	 * @author Digi3Studio - Colin Leung
	 */

	public interface IMotion extends IFASTEventDispatcher{
		function to(value:Number):void;
		function skip():void;
	}
}
