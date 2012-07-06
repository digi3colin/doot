package doot.resolveLink {
	import doot.IResolveLink;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ResolveLinkLocal implements IResolveLink {
		private var server:String;
		private var testServer:String;
		private var seed:String;
		private var city:String;
		private var lang:String;

		private var fileName:String;
		private var fileType:String;
		private var usage:String;

		public function ResolveLinkLocal(swfPath:String,dynamicAssetTestingServerPath:String,city:String='',lang:String=''){
			//url format:
			//http://server/media/city/lang/usage/mediatype/fileName.xxx
			var preQuery:String = swfPath.split('?')[0];
			var folders:Array = preQuery.split('/');

			this.fileName = String(folders.pop());
			this.fileType = String(folders.pop())+'/';
			this.usage = folders.pop()+'/';
			this.city = (city=='')?'':(city+'/');
			this.lang = (lang=='')?'':(lang+'/');
			this.server = swfPath.split('media/')[0];

			this.testServer = dynamicAssetTestingServerPath;
			this.seed = '88'+String((Math.random()*10000)>>0);

		}

		private function addCacheString(path:String,cacheString:String):String{
			return path+((path.indexOf('?')==-1)?'?':'')+cacheString;
		}

		public function create(fileName : String, isDynamicAsset : Boolean = false,isMultiLang:Boolean=true) : String {
			if(isDynamicAsset==true){
				return addCacheString(testServer+fileName,'&r='+seed);
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
			return server+'media/'+((isMultiLang==true)?(city+lang):'')+usage+specifyFolder+fileName;
		}
	}
}
