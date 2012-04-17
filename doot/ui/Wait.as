package doot.ui {
	import doot.IView;
	import doot.view.AbstractView;

	import com.fastframework.core.FASTLog;

	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author digi3colin
	 */
	public class Wait implements IView{
		private static var ins:Wait;
		public static function instance():Wait {
			return ins ||new Wait();
		}
		private var msg:String="";
		private var base:AbstractView;
		private var body:TextField;
		private var showCount:int=0;

		public function Wait() {
			if(ins!=null)return;
			ins = this;

		}

		public function message(str:String):void{
			msg = str;
			if(base.getView()==null){
				FASTLog.instance().log('[Wait message]'+str,FASTLog.LOG_LEVEL_DETAIL);
				return;
			}
			this.body.text = str;
			this.show();
		}

		public function setView(mc:Sprite,autoHide:Boolean=true):IView{
			base = base|| new AbstractView(mc, autoHide);

			this.body = mc['txt_body'];
			this.body.defaultTextFormat = new TextFormat('FontBody');
			this.body.thickness = 0;
			this.body.sharpness = 0;
			this.body.antiAliasType = AntiAliasType.ADVANCED;
			return this;
		}

		public function getView() : Sprite {
			return base.getView();
		}

		public function hide() : IView{
			showCount--;
			if(showCount<=0){
				base.hide();
			}
			return this;
		}

		public function show() : IView {
			showCount++;
			base.show();
			return this;
		}

		public function getViewName() : String {
			return base.getViewName();
		}
		
	}
}
class SingletonBlocker{}