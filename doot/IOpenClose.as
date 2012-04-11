package doot {
	import com.fastframework.core.IFASTEventDispatcher;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public interface IOpenClose extends IFASTEventDispatcher{
		function open():void;
		function close():void;
		function toggle():void;
	}
}
