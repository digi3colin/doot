package doot {
	import doot.resolveLink.ResolveLinkLocal;
	import doot.resolveLink.ResolveLinkRemote;
	import doot.utils.SystemUtils;

	import flash.display.Sprite;
	/**
	 * @author colin
	 */
	public class ResolveLink implements IResolveLink{
		private static var ins:ResolveLink;
		public static function instance():ResolveLink {
			return ins || new ResolveLink();
		}

		public function ResolveLink() {
			if(ins!=null)return;
			ins = this;
		}

		private var imp:IResolveLink;

		public function setup(mc:Sprite, testingServer:String,city:String,lang:String):void{
			if(imp!=null)return;

			var swfPath:String = SystemUtils.getMovieURLPath(mc);
			if(swfPath.indexOf('file:///')==0){
				//if is Local, use testing server
				imp = new ResolveLinkLocal(swfPath,testingServer,city,lang);
			}else{
				//else, use relative path
				imp = new ResolveLinkRemote(swfPath,city,lang);
			}
		}

		public function create(fileName:String,isDynamicAsset:Boolean=false,isMultiLang:Boolean=true):String{
			//if load absolute path resource, no need to resolve link.
			if(fileName.indexOf("http://")==0)return fileName;

			return imp.create(fileName, isDynamicAsset,isMultiLang);
/*
			//if local running, should remove the query in url
			if(isLocalRunning){
				fileName = fileName.split('?')[0];
			}

			//resolve link by enviorment;

			var ext:String = String(fileName.split("?")[0]).split(".")[1];
			var specifyFolder:String = "";
			//only swf on server append no cache;
			var noCache:String = (_swfPath.indexOf('http://')==0)?'&r='+Math.floor(Math.random()*10000):'';

			switch(ext){
					case "jpg":
					case "jpeg":
					case "gif":
					case "png":
						specifyFolder = "../images/";
						noCache="";
						break;
					case "flv":
						specifyFolder = "../flv/";
						noCache="";
						break;
					case "xml":
						specifyFolder = "../xml/";
						break;
					case "swf":
						specifyFolder = "";
						break;
					default:
						specifyFolder = "../";
			}

			var path:String = _swfPath+specifyFolder+fileName;
			return (noCache=="")?path:addCacheString(path, noCache);*/
		}

/*		private function addCacheString(path:String,cacheString:String):String{
			return path+((path.indexOf('?')==-1)?'?':'')+cacheString;
		}*/
	}
}
