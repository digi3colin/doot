
/**
 * @author colin
 */

package doot.net {
	import com.fastframework.log.FASTLog;
	import com.fastframework.net.ILoadParser;
	import com.fastframework.net.ILoader;

	import flash.net.URLLoader;
	import flash.text.StyleSheet;

	final public class ParseCSS implements ILoadParser{
		private var base:StyleSheet;

		public function onLoad(loader:ILoader):void{
			base.parseCSS(URLLoader(loader.getContext()).data);
			loader.dispatchEvent(new LoaderEvent(LoaderEvent.READY));
			FASTLog.instance().log(base.toString(), FASTLog.LOG_LEVEL_DETAIL);
		}

		public function getContext() : * {
			return base;
		}
	}
}