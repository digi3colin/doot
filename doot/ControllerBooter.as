package doot {
	import doot.net.LoaderEvent;

	import com.fastframework.net.ILoader;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerBooter {
		private var mainView:Sprite;
		private var loader:ILoader;

		public function ControllerBooter(mc : Sprite,loader:ILoader) {
			this.loader = loader;
			mc.addChild(mainView = new Sprite());


			/*load main or file from flashvars */
			//ResolveLink.instance().setup(mc,Config.TESTING_SERVER);

			var loaderInfo:LoaderInfo = mc.loaderInfo;
			var fileToLoad:String= loaderInfo.parameters['file']||"main.swf";
//			fileToLoad = "media/asia/en/site/swf/main.swf";

			var parameters:Array = [];
			parameters['sessionId'] = loaderInfo.parameters['sessionId']||'';
			parameters['section']   = loaderInfo.parameters['section']  ||'';
			parameters['lang']		= loaderInfo.parameters['lang']     ||'en';
			parameters['city']		= loaderInfo.parameters['city']     ||'asia';

			//pass all flashvas to file to load
			var strParameters:Array = [];
			for(var name:String in parameters){
				if(parameters[name]=='')continue;
				strParameters.push(name+'='+parameters[name]);
			}

			var queryKey:String = (strParameters.length==0)?'':((fileToLoad.match(/\?/)==null)?'?':'&');
			var fileWithQueryToLoad:String = fileToLoad+queryKey+strParameters.join('&');

			loader.once(LoaderEvent.COMPLETE, onMainLoad);
			loader.load(ResolveLink.instance().create(fileWithQueryToLoad));

//			TextField(mc['txtDebug']).appendText(fileWithQueryToLoad+'\n');
//			TextField(mc['txtDebug']).appendText(ResolveLink.instance().create(fileWithQueryToLoad)+'\n');
			
		}
		private function onMainLoad(e:Event):void{
			mainView.addChild(Loader(loader.getContext()));
		}
	}
}
