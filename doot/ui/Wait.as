package doot.ui {
	import com.fastframework.core.SingletonError;
	import doot.IView;
	import doot.view.ShowHideView;

	import com.fastframework.log.FASTLog;

	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author digi3colin
	 */
	public class Wait extends FASTEventDispatcher implements IView{
		private static var ins:Wait;
		public static function instance():Wait {
			return ins ||new Wait();
		}
		private var msg:String="";
		private var base:ShowHideView;
		private var body:TextField;
		private var showCount:int=0;

		public function Wait() {
			if(ins!=null)throw new SingletonError(this);
			ins = this;
		}

		public function message(str:String):void{
			msg = str;
			if(base==null){
				FASTLog.instance().log('[Wait message]'+str,FASTLog.LOG_LEVEL_ACTION);
				return;
			}
			this.body.htmlText = '<font face="FontBody" size="12" color="#FFFFFF">'+str+'</font>';
			this.show();
		}

		public function setView(mc:Sprite,autoHide:Boolean=true):IView{
			base = base|| new ShowHideView(mc, autoHide);

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
				if(base==null)return this;
				base.hide();
			}
			return this;
		}

		public function show() : IView {
			showCount++;
			if(base==null)return this;
			base.show();
			return this;
		}

		public function getViewName() : String {
			return base.getViewName();
		}
	}
}