package doot.resolveLink {
	import doot.IResolveLink;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ResolveLinkRemote implements IResolveLink {
		private var serverPath : String;
		private var swfPath:String;
		private var seed:String;

		public function ResolveLinkRemote(swfPath : String) {
			this.serverPath = swfPath.split('media/')[0];
			this.swfPath = swfPath.split('swf/')[0];
			this.seed = String((Math.random()*10000)>>0);
		}

		private function addCacheString(path:String,cacheString:String):String{
			return path+((path.indexOf('?')==-1)?'?':'')+cacheString;
		}

		public function create(fileName : String, isDynamicAsset : Boolean = false) : String {
			// file structure: http://www.digi3.com/test/media/swf/this.swf
			// server path:    http://www.digi3.com/test/
			// input string:   test.xml?hello=1
			// output string:  http://www.digi3.com/test/test.xml?hello=1

			// file structure: http://www.digi3.com/test/media/hk/en/swf/this.swf
			// server path:    http://www.digi3.com/test/
			// swf path:       http://www.digi3.com/test/media/hk/en/
			// input string:   test.jpg
			// output string:  http://www.digi3.com/test/media/hk/en/images/test.jpg

			if(isDynamicAsset==true){
				return addCacheString(serverPath+fileName,'&r='+seed);
			}

			fileName = fileName.split('?')[0];
			var ext:String = fileName.split(".").pop();
			var specifyFolder:String = "";

			switch(ext){
					case "jpg":
					case "jpeg":
					case "gif":
					case "png":
						specifyFolder = "images/";
						break;
					case "swf":
					case "flv":
					case "xml":
					case "css":
						specifyFolder = ext+"/";
						break;
					default:
						specifyFolder = "";
			}

			return swfPath+specifyFolder+fileName;
		}
	}
}
