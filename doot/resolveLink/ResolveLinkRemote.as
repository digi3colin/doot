package doot.resolveLink {
	import doot.IResolveLink;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ResolveLinkRemote implements IResolveLink {
		private var server : String;

		private var seed:String;
		private var city:String;
		private var lang:String;

		private var fileName:String;
		private var fileType:String;
		private var usage:String;

		public function ResolveLinkRemote(swfPath : String,city:String,lang:String) {
			var preQuery:String = swfPath.split('?')[0];
			var folders:Array = preQuery.split('/');

			this.fileName = String(folders.pop());
			this.fileType = String(folders.pop())+'/';
			this.usage = folders.pop()+'/';
			this.city = (city=='')?'':(city+'/');
			this.lang = (lang=='')?'':(lang+'/');
			this.server = swfPath.split('media/')[0];

			this.seed = String((Math.random()*10000)>>0);
		}

		private function addCacheString(path:String,cacheString:String):String{
			return path+((path.indexOf('?')==-1)?'?':'')+cacheString;
		}

		public function create(fileName : String, isDynamicAsset : Boolean = false,isMultiLang:Boolean=true) : String {
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
				return addCacheString(server+fileName,'&r='+seed);
			}

			var oFileName:String = fileName;

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

			return server+'media/'+((isMultiLang==true)?(city+lang):'')+usage+specifyFolder+oFileName;
		}
	}
}
