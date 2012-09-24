package doot.model {
	import doot.model.encoder.PNGEncoder;
	import doot.net.LoaderEvent;
	import doot.net.LoaderFactory;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.SingletonError;
	import com.fastframework.net.ILoader;

	import flash.display.BitmapData;
	import flash.events.Event;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class PNGSaver extends FASTEventDispatcher{
		private static var ins : PNGSaver;
		public static const EVENT_READY : String = "EVENT_READY";

		public static function instance():PNGSaver {
			return ins || new PNGSaver();
		}
			
		private var uploader:ILoader;
		private var savedPath:String;

		public function PNGSaver(){
			if(ins!=null)throw new SingletonError(this);
			ins = this;

			uploader = LoaderFactory.instance().getXMLLoader();
			uploader.when(LoaderEvent.READY, uploaded);
		}

		public function save(width:int,height:int,imagesToDraw:Array):void{
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			for(var i:int=0;i<imagesToDraw.length;i++){
				//from bottom to top, 0 is bottom;
				bd.draw(imagesToDraw[i]);
			}

			uploader.sendBinaryAndLoad(
				'http://www.digi3studio.com/preview/moet/birthday/web/file/upload.xml?name=artwork',
				PNGEncoder.encode(bd, {})
			);
			savedPath = null;
		}

		private function uploaded(e:Event):void{
			var xData:XML = uploader.getContext();
			var xFile:XML = XML(xData.children()[0]).child('file')[0];
			savedPath = 'http://www.digi3studio.com/'+xFile.toString();
			dispatchEvent(new Event(PNGSaver.EVENT_READY));
		}

		public function getSavedPath():String{
			return savedPath;
		}
	}
}