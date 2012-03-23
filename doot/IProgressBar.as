package doot {
	import com.fastframework.net.ILoader;

	/**
	 * @author colin
	 */
	public interface IProgressBar {
		function monitorLoader(loader:ILoader):void;
	}
}
