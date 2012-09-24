package doot.view {
	import doot.IView;
	import doot.motion.MotionTween;

	import com.fastframework.core.FASTEventDispatcher;

	import flash.display.Sprite;
	import flash.utils.describeType;

	/**
	 * @author colin
	 */
	public class AbstractView extends FASTEventDispatcher implements IView{
		private var isHide:Boolean=false;
		private var motion:MotionTween;
		private var view:Sprite;

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
			motion.startTween({a:0});
			return this;
		}
		
		public function show() : IView {
			if(motion==null || isHide==false)return this;
			isHide = false;
			motion.startTween({a:100});
			return this;
		}
		
		public function getViewName() : String {
			return describeType(view).@name;
		}
	}
}
