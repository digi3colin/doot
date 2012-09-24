package doot.view {
	import doot.IView;
	import doot.motion.MotionEvent;
	import doot.motion.MotionTween;
	import doot.view.events.ButtonClipEvent;

	import com.fastframework.core.FASTEventDispatcher;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.describeType;

	/**
	 * @author colin
	 */
	public class ShowHideView extends FASTEventDispatcher implements IView{
		private var isHide:Boolean=false;
		private var motion:MotionTween;
		private var view:Sprite;
		private var btnClose:ButtonClip;
		private var motionDur:Number;

		public function ShowHideView(mc:Sprite,autoHide:Boolean = true,motionDur:Number=10){
			this.motionDur = motionDur;
			this.setView(mc, autoHide);

			try{
			if(mc['btn_close']!=null){
				btnClose = new ButtonClip(mc['btn_close']);
				btnClose.when(ButtonClipEvent.CLICK, onClose);
			}
			}catch(e:Error){}
		}

		private function onClose(e:Event):void{
			this.hide();
		}

		public function setView(mc : Sprite,autoHide:Boolean=true) : IView {
			view = mc;
			motion = new MotionTween(mc,{dur:motionDur});
			motion.when(MotionEvent.EVENT_END, onMotionEnd);
			if(autoHide){
				motion.hideSprite();
				isHide = true;
			}

			return this;
		}
		
		public function getView():Sprite{
			return view;
		}
		
		public function hide() : IView {
			if(motion==null || isHide==true)return this;
			isHide = true;
			motion.startTween({a:0,x:view.x,y:view.y});
			dispatchEvent(new Event(ShowHideEvent.EVENT_HIDE));
			return this;
		}
		
		public function show() : IView {
			if(motion==null || isHide==false)return this;
			isHide = false;
			motion.startTween({a:100,x:view.x,y:view.y});
			dispatchEvent(new Event(ShowHideEvent.EVENT_SHOW));
			return this;
		}
		
		public function getViewName() : String {
			return describeType(view).@name;
		}

		private function onMotionEnd(e:Event):void{
			var type:String = (isHide)?ShowHideEvent.EVENT_HIDE_ANIMATION_END:ShowHideEvent.EVENT_SHOW_ANIMATION_END;
			dispatchEvent(new Event(type));
		}
	}
}
