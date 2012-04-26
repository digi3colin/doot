﻿package doot {
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
	 * The wrapper for main.swf to display the loading progress as soon as possible
	*/

	final public class Booter{
		private var mainView:Sprite;
		private var loader:ILoader;
		private var progressBar:ProgressBar;
		private var loaderInfo:LoaderInfo;

		public function Booter(mc:Sprite) {
			Template.bg = mc['mc_bg'];

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
				loader.when(ProgressEvent.PROGRESS, loading);
			}

			var fileToLoad:String= loaderInfo.parameters['file']||"main.swf";

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

			loader.once(Event.COMPLETE, onMainLoad);
			loader.load(ResolveLink.instance().create(fileToLoad+queryKey+strParameters.join('&'),true));
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