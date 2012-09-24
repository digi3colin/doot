package doot.model {
	import com.fastframework.core.ILog;

	import flash.text.TextField;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class LoggerTextField implements ILog {
		private var txt : TextField;

		public function LoggerTextField(txt:TextField){
			this.txt = txt;
		}
		
		public function addGlobalError(loaderInfoOrLoader : *) : void {

		}

		public function log(str : String, debugLevel : int = 0) : void {
			txt.appendText(str+'\n');
		}

		public function setLogger(logger : ILog) : void {
		}
	}
}
