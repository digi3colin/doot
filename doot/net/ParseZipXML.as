package doot.net {
	import com.fastframework.log.FASTLog;
	import com.fastframework.net.ILoadParser;
	import com.fastframework.net.ILoader;

	import flash.net.URLLoader;
	import flash.utils.ByteArray;


	/**
	 * @author colin
	 * compressed xml supported
	 */
	final public class ParseZipXML implements ILoadParser {
		private var xmlContent : XML;

		public function onLoad(loader:ILoader):void{
			var receiveBytes:ByteArray = URLLoader(loader.getContext()).data;
			//try decompress data;
			try{
				receiveBytes.uncompress();
			}catch(e:Error){
				FASTLog.instance().log('result XML is not compressed',FASTLog.LOG_LEVEL_ERROR);
			}finally{}

			receiveBytes.position = 0;
			try{
				xmlContent = new XML(receiveBytes.readUTFBytes(receiveBytes.length));
			}catch(err:Error){
				xmlContent = new XML('<error>'+err.message+'</error>');
			}
			receiveBytes = null;
			FASTLog.instance().log(xmlContent.toXMLString(), FASTLog.LOG_LEVEL_DETAIL);

			loader.dispatchEvent(new LoaderEvent(LoaderEvent.READY));
		}

		public function getContext() : * {
			return xmlContent;
		}
	}
}