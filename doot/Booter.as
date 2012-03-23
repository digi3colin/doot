package doot {
	import com.fastframework.core.SingletonError;
	import com.fastframework.core.utils.SystemUtils;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderLoader;

	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;



	/**
	 * @author colin
	 */
/**
* The wrapper for main.swf to display the loading progress as soon as possible
*/

	final public class Booter{
		private static var ins:Booter;
		public static function instance():Booter {
			ins ||=new Booter();
			return ins;
		}

		public function Booter() {
			if(ins!=null){throw new SingletonError(this);}
			ins = this;
		}
		
		private var mainView:Sprite;
		private var loader:ILoader;
		private var progressBar:ProgressBar;
		private var loaderInfo:LoaderInfo;
		public function getLoaderInfo():LoaderInfo{
			return loaderInfo;
		};
		public function initWithView(mc:Sprite):void{
/*			this.graphics.beginFill(0x9D7341);
			this.graphics.drawRect(0, 0, 1000, 650);*/

			loaderInfo = mc.loaderInfo;

			mc.stage.align = StageAlign.TOP_LEFT;
			mc.stage.scaleMode = StageScaleMode.NO_SCALE;

			//check filesize
			if(mc.loaderInfo.bytesTotal>7168)trace('warning: booter filesize exist 7k');
			mc.addChild(mainView = new Sprite());

			/*load main or file from flashvars */
			ResolveLink.instance().setup(SystemUtils.getMovieURLPath(mc));

			loader = new LoaderLoader();
			if(mc['mc_progress_bar']!=null){
				progressBar = new ProgressBar(mc['mc_progress_bar']);
				loader.when(ProgressEvent.PROGRESS, this,loading);
			}

			var fileToLoad:String= loaderInfo.parameters['file']||"main.swf";

			var parameters:Array = [];
			parameters['sessionId'] = loaderInfo.parameters['sessionId']||'';
			parameters['section']   = loaderInfo.parameters['section']  ||'';
			parameters['lang']		= loaderInfo.parameters['lang']     ||'en';
			parameters['city']		= loaderInfo.parameters['city']     ||'asia';

			var strParameters:Array = [];
			for(var name:String in parameters){
				if(parameters[name]=='')continue;
				strParameters.push(name+'='+parameters[name]);
			}

			var queryKey:String = (strParameters.length==0)?'':((fileToLoad.match(/\?/)==null)?'?':'&');

			loader.when(Event.COMPLETE, this, onMainLoad);
			loader.load(ResolveLink.instance().create(fileToLoad+queryKey+strParameters.join('&'),true));
		}

		private function onMainLoad(e:Event):void{
			mainView.addChild(loader.getContext());
		};

		private function loading(e:ProgressEvent):void{
			var fileSize:Number = Math.ceil(loader.getBytesTotal()/1024);
			progressBar.setProgress(loader.getBytesLoaded()/loader.getBytesTotal(),'Loading '+fileSize+'kB file: ');
		}
	}
}
import flash.display.Sprite;
import flash.text.TextField;

final class ProgressBar {
	private var view:Sprite;
	private var bar:Sprite;
	private var txt:TextField;
	private var isShow:Boolean =false;

	
	public function ProgressBar(view:Sprite){
		this.view = view;
		txt = view['txt'];
		bar = view['bar'];
	}
	
	public function setProgress(progress:Number,msg:String=""):void{
		txt.text = msg+Math.floor(progress*100)+"%";
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