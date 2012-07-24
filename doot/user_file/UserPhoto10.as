package doot.user_file {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Matrix;
	import flash.net.FileFilter;
	import flash.net.FileReference;

	/**
	 * @author colin
	 */
	public class UserPhoto10 extends FASTEventDispatcher implements IUserPhoto {
		public static const EVENT_UPLOAD_COMPLETE : String   = "EVENT_UPLOAD_COMPLETE";
		public static const EVENT_DOWNLOAD_COMPLETE : String = "EVENT_DOWNLOAD_COMPLETE";
		public static const EVENT_DOWNLOAD_PROGRESS : String = "EVENT_DOWNLOAD_PROGRESS";
		private var dataRender:Loader;
		
		private var file:FileReference;
		private var bytesUpload:int = -1;
		private var bytesDownload:int = -1;
		private var bytesDownloadTotal:int = -1;
		private var bytesUploadTotal:int = -1;

		public function UserPhoto10(){
			dataRender = new Loader();
			dataRender.contentLoaderInfo.addEventListener(Event.COMPLETE, previewReady);
			file = new FileReference();
			file.addEventListener(Event.SELECT, onFileSelected);
			file.addEventListener(Event.COMPLETE, onFileLoaded);
			file.addEventListener(ProgressEvent.PROGRESS, onFileProgress);
			//throw error if file.load not available
			if(file.load==null)throw new Error('FileReference.load not support');
		}

		private function onFileSelected(e:Event):void{
			file.load();
			dispatchEvent(new Event(UserPhoto10.EVENT_UPLOAD_COMPLETE));
		}

		private function onFileLoaded(e:Event):void{
			dataRender.loadBytes(file.data);
		}
		
		private function previewReady(e:Event):void{
			dispatchEvent(new Event(UserPhoto10.EVENT_DOWNLOAD_COMPLETE));
		}
		
		private function onFileProgress(e:ProgressEvent):void{
			bytesDownloadTotal = e.bytesTotal;
			bytesDownload = e.bytesLoaded;
			dispatchEvent(new Event(UserPhoto10.EVENT_DOWNLOAD_PROGRESS));
		}

		public function upload() : void {
			file.browse([new FileFilter("Photo", "*.jpg;*.jpeg;*.gif;*.png")]);
		}

		public function getBytesUpload() : int {
			return bytesUpload;
		}
		
		public function getBytesDownload() : int {
			return bytesDownload;
		}
		
		public function getBytesUploadTotal() : int {
			return bytesUploadTotal;
		}
		
		public function getBytesDownloadTotal() : int {
			return bytesDownloadTotal;
		}
		
		public function getLoadedBitmapData() : BitmapData {
			var tmx:Matrix = new Matrix();
			var w:Number = dataRender.width;
			var h:Number = dataRender.height;
			
			var maxSize:Number = 1600;
			
			if(w>maxSize||h>maxSize){
				var sw:Number = maxSize/w;
				var sh:Number = maxSize/h;
				var s:Number = Math.min(sw,sh);
				w = w*s;
				h = h*s;
				tmx.scale(s, s);
			}

			var result:BitmapData = new BitmapData(w,h,true,0);
			result.draw(dataRender,tmx);
			return result;
		}
	}
}
