package doot {
	import com.fastframework.net.ILoader;

	import flash.display.Sprite;
	import flash.events.ProgressEvent;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerProgressBar {
		private var progressBar:ProgressBar;
		public function ControllerProgressBar(mc : Sprite, loader : ILoader) {
			if(mc['mc_progress_bar']!=null){
				progressBar = new ProgressBar(mc['mc_progress_bar']);
				loader.when(ProgressEvent.PROGRESS, loading);
			}
		}

		private function loading(e:ProgressEvent):void{
			var loader:ILoader = ILoader(e.target);
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