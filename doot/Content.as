package doot {
	import doot.motion.MotionEvent;
	import doot.motion.MotionTween;
	import doot.net.LoaderEvent;
	import doot.net.LoaderFactory;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.navigation.Navigation;
	import com.fastframework.navigation.NavigationEvent;
	import com.fastframework.net.ILoader;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
 * @author Colin
 */
	public class Content extends FASTEventDispatcher implements IFASTEventDispatcher{

		private var base:Sprite;
		private var prefix:String;
		private var currentNavKey:String;
		private var fadein:MotionTween;
		private var fadeout:MotionTween;
		private var targetName: String;
		private var extension : String;
		private var movieContainer:Sprite;

		public function Content(mc:Sprite,parameter:String=null){

			this.base = mc;

			var para:Array;
			if(parameter==null){
				para = base.name.split('$');
			}else{
				para = parameter.split('$');
			}
			targetName	= para[1]||"";
			prefix		= para[2]||"";
			extension   = para[3]||"swf";

			mc.addChild(movieContainer = new Sprite());
			movieContainer.alpha=0.01;

			fadein  = new MotionTween(movieContainer,{a:100});
			fadeout = new MotionTween(movieContainer,{a:0});
			fadeout.when(MotionEvent.EVENT_END, onFadeOutAndLoad);

			Navigation.instance().when(NavigationEvent.CHANGE, onNavChange);
		}

		private function onNavChange(e:NavigationEvent):void{
			//if targetName is empty, load only 
			var navTargetIsEmpty:Boolean = (e.targetContainer==""||e.targetContainer==null);

	 		var criteria1:Boolean = (targetName==""&&navTargetIsEmpty);
	 		var criteria2:Boolean = (navTargetIsEmpty==false&&e.targetContainer==targetName);
			if(criteria1==false&&criteria2==false)return;

			currentNavKey = e.navKey;
			if(fadein.isTweening()==true)fadein.killTween();
			if(fadeout.isTweening()==true)return;
			fadeout.startTween();
			trace('onNavChange');
		}

		private function onFadeOutAndLoad(e:Event):void {
			loadAction();
		}


		private function loadAction():void{
			for(var i:int=0;i<movieContainer.numChildren;i++){
				movieContainer.removeChildAt(i);
			}

			var url:String = prefix+currentNavKey+"."+extension;

			var ldr:ILoader = LoaderFactory.instance().getSWFLoader(movieContainer);
			ldr.when(LoaderEvent.PROGRESS, 	onProgress);
			ldr.once(LoaderEvent.READY, 	onLoadContentAndFadeIn);
			ldr.load(ResolveLink.instance().create(url));
		}

		private function onProgress(e:Event):void{
			dispatchEvent(e);
		}

		private function onLoadContentAndFadeIn(e:Event):void{
			if(Navigation.instance().getNavStackRequests()!=null){
				Navigation.instance().nextSection();
			}
			
			movieContainer.alpha=0.01;
			fadein.startTween();
		}
	}
}