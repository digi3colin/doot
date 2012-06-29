package doot.user_file {
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.display.BitmapData;

	/**
	 * @author colin
	 */
	public interface IUserPhoto extends IFASTEventDispatcher {
		function upload():void;
		function getBytesUpload():int;
		function getBytesDownload():int;
		function getBytesUploadTotal():int;
		function getBytesDownloadTotal():int;
		function getLoadedBitmapData():BitmapData;
	}
}