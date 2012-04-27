package doot.view {
	import doot.IView;

	import com.fastframework.motion.MotionTween;
	import com.fastframework.view.ButtonClip;
	import com.fastframework.view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.describeType;

	/**
	 * @author colin
	 */
	public class ShowHideView implements IView{
		private var isHide:Boolean=false;
		private var motion:MotionTween;
		private var view:Sprite;
		private var btnClose:ButtonClip;

		public function ShowHideView(mc:Sprite,autoHide:Boolean = true){
			this.setView(mc, autoHide);
			if(mc['btn_close']!=null){
				btnClose = new ButtonClip(mc['btn_close']);
				btnClose.when(ButtonClipEvent.CLICK, onClose);
			}
		}

		private function onClose(e:Event):void{
			this.hide();
		}

		public function setView(mc : Sprite,autoHide:Boolean=true) : IView {
			view = mc;
			motion = new MotionTween(mc);
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
			return this;
		}
		
		public function show() : IView {
			if(motion==null || isHide==false)return this;
			isHide = false;
			motion.startTween({a:100,x:view.x,y:view.y});
			return this;
		}
		
		public function getViewName() : String {
			return describeType(view).@name;
		}
	}
}
