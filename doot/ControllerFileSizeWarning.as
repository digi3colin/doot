package doot {
	import flash.display.Sprite;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerFileSizeWarning {
		public function ControllerFileSizeWarning(mc : Sprite, fileSizeLimit : int) {
			//check filesize
			if(mc.loaderInfo.bytesTotal>fileSizeLimit)trace('warning: booter filesize exist 7k');
		}
	}
}
