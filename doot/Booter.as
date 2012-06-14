package doot {
	import controller.system.ControllerStageSetup;

	import com.fastframework.core.utils.SystemUtils;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderLoader;

	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	/**
	 * The wrapper for main.swf to display the loading progress as soon as possible
	*/

	final public class Booter{
		private var mainView:Sprite;
		private var loader:ILoader;
		private var progressBar:ProgressBar;
		
		private var controllers:Array = [];

		public function Booter(mc:Sprite) {
			Template.bg = mc['mc_bg'];

			controllers.push(new ControllerStageSetup(mc.stage));

			//check filesize
			if(mc.loaderInfo.bytesTotal>7168)trace('warning: booter filesize exist 7k');
			mc.addChild(mainView = new Sprite());

			/*load main or file from flashvars */
			//ResolveLink.instance().setup(mc,Config.TESTING_SERVER);

			loader = new LoaderLoader();
			if(mc['mc_progress_bar']!=null){
				progressBar = new ProgressBar(mc['mc_progress_bar']);
				loader.when(ProgressEvent.PROGRESS, loading);
			}

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

			var swfPath:String = SystemUtils.getMovieURLPath(mc);
			var isLocal:Boolean = (swfPath.indexOf('file:///')==0);
			var serverPath:String = swfPath.split('media/')[0];

			var absolutefileToLoad:String = (isLocal)?
													fileToLoad:
													(serverPath+fileToLoad+queryKey+strParameters.join('&'));

			loader.once(Event.COMPLETE, onMainLoad);
			loader.load(absolutefileToLoad);
		}

		private function onMainLoad(e:Event):void{
			mainView.addChild(loader.getContext());
		}

		private function loading(e:ProgressEvent):void{
			progressBar.setProgress(loader.getBytesLoaded()/loader.getBytesTotal());
		}
	}
}
import flash.display.Sprite;

final class ProgressBar {
	private var view:Sprite;
	private var bar:Sprite;

	private var isShow:Boolean =false;

	public function ProgressBar(view:Sprite){
		this.view = view;
		bar = view['bar'];
	}
	
	public function setProgress(progress:Number):void{
		bar.scaleX = progress;

		if(progress>=1 || progress<=0){
			hide();
			return;
		}
		show();
	}

	public function show():ProgressBar{
		if(isShow==true)return this;
		isShow = true;
		this.view.visible = true;
		this.view.alpha = 1;
		return this;
	}

	public function hide():ProgressBar{
		if(isShow==false)return this;
		isShow = false;
		this.view.visible = false;
		return this;
	}
}