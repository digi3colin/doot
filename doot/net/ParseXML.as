package doot.net {
	import com.fastframework.log.FASTLog;
	import com.fastframework.net.ILoadParser;
	import com.fastframework.net.ILoader;

	import flash.net.URLLoader;


	/**
	 * @author colin
	 * compressed xml supported
	 */
	final public class ParseXML implements ILoadParser {
		private var xmlContent : XML;

		public function onLoad(loader:ILoader):void{
			xmlContent = new XML(String(URLLoader(loader.getContext()).data));
			FASTLog.instance().log(xmlContent.toXMLString(), FASTLog.LOG_LEVEL_DETAIL);
			loader.dispatchEvent(new LoaderEvent(LoaderEvent.READY));
		}

		public function getContext() : * {
			return xmlContent;
		}
	}
}