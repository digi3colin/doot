package doot.resolveLink {
	import doot.IResolveLink;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ResolveLinkLocal implements IResolveLink {
		private var mediaPath:String;
		private var testPath:String;
		private var seed:String;
		public function ResolveLinkLocal(swfPath:String,dynamicAssetTestingServerPath:String){
			this.mediaPath = swfPath.split('swf/')[0];
			this.testPath = dynamicAssetTestingServerPath;
			this.seed = '88'+String((Math.random()*10000)>>0);
		}

		private function addCacheString(path:String,cacheString:String):String{
			return path+((path.indexOf('?')==-1)?'?':'')+cacheString;
		}

		public function create(fileName : String, isDynamicAsset : Boolean = false) : String {
			if(isDynamicAsset==true){
				return addCacheString(testPath+fileName,'&r='+seed);
			}

			// file structure: file:///c:/test/swf/this.swf
			// media path:     file:///c:/test/
			// input string:   test.xml?hello=1
			// output string:  file:///c:/test/xml/test.xml

			//trim query string
			fileName = fileName.split('?')[0];

			var specifyFolder:String = "";
			var ext:String = fileName.split(".").pop();

			switch(ext){
					case "jpg":
					case "jpeg":
					case "gif":
					case "png":
						specifyFolder = "images/";
						break;
					case "flv":
					case "xml":
					case "swf":
					case "css":
						specifyFolder = ext+"/";
						break;
					default:
						specifyFolder = "";
			}

			return mediaPath+specifyFolder+fileName;
		}
	}
}
