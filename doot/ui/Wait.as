package doot.ui {
	import doot.IView;
	import doot.view.AbstractView;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author digi3colin
	 */
	public class Wait implements IView{
		private static var ins:Wait;
		public static function instance():Wait {
			ins ||=new Wait(new SingletonBlocker());
			return ins;
		}
		private var msg:String="";
		private var base:AbstractView;
		private var body:TextField;
		private var showCount:int=0;

		public function Wait(p_key:SingletonBlocker) {
			base = new AbstractView();
			p_key;
		}

		public function message(str:String):void{
			msg = str;
			if(base.getView()==null){
				trace('[Wait message]'+str);
				return;
			}
			this.body.text = str;
		}

		public function setView(mc:Sprite,autoHide:Boolean=true):IView{
			base.setView(mc,autoHide);
			body = mc['body'];
			return this;
		}

		public function getView() : Sprite {
			return base.getView();
		}

		public function hide() : IView{
			trace('wait.hide()');
			showCount--;
			if(showCount<=0){
				base.hide();
			}
			return this;
		}

		public function show() : IView {
			showCount++;
			trace('wait.show()' + msg);
			base.show();
			return this;
		}

		public function getViewName() : String {
			return base.getViewName();
		}
		
	}
}
class SingletonBlocker{}