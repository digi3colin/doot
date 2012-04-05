package doot.ui {
	import doot.IView;
	import doot.view.AbstractView;

	import com.fastframework.view.ButtonClip;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author colin
	 */
	public class Prompt implements IView{
		private static var ins:Prompt;
		public static function instance():Prompt {
			return ins ||new Prompt();
		}
		
		public function Prompt() {
			if(ins!=null)return;
			ins = this;
			base = new AbstractView();
		}
		
		private var base:AbstractView;
		private var body:TextField;
		private var title:TextField;
		private var btnCancel:ButtonClip;
		private var btnOk:ButtonClip;
		private var btn_cancel:Sprite;
		private var btn_ok:Sprite;
		

		public function setView(mc : Sprite, autoHide : Boolean = true) : IView {
			base.setView(mc,autoHide);
			btnCancel 	= new ButtonClip(btn_cancel = mc['btn_cancel']);
			btnCancel.when(MouseEvent.CLICK, onCancel);
			btnOk 		= new ButtonClip(btn_ok = mc['btn_ok']);
			btnOk.when(MouseEvent.CLICK, onOk);
			body 		= mc['body'];
			title 		= mc['title'];
			
			return this;
		}

		public function getView() : Sprite {
			return base.getView();
		}

		public function hide() : IView {
			this.cancelCallBack = null;
			this.okCallBack = null;
			base.hide();
			return this;
		}

		public function show() : IView {
			base.show();
			return this;
		}

		private var cancelCallBack:Function;
		private var okCallBack:Function;
		private var okAndHide:Boolean = true;
		public function popup(title:String,body:String,cancelCallBack:Function=null,okCallBack:Function=null,okAndHide:Boolean = true):void{
			if(base.getView()==null){
				trace(title,body);
				if(okCallBack!=null)okCallBack();
				return;
			}

			this.title.text = title;
			this.body.text = body;

			this.btn_cancel.visible = (cancelCallBack!=null);
			this.btn_ok.visible = (okCallBack!=null)||okAndHide==true;

			this.cancelCallBack = cancelCallBack;
			this.okCallBack = okCallBack;
			this.okAndHide = okAndHide;
			show();
		}

		private function onCancel(e:MouseEvent):void{
			if(this.cancelCallBack!=null)cancelCallBack();
			btn_cancel.visible = false;
			btn_ok.visible = false;
			hide();
		}

		private function onOk(e:MouseEvent):void{
			if(this.okCallBack!=null)okCallBack();
			btn_cancel.visible = false;
			btn_ok.visible = false;
			if(okAndHide == true)hide();
		}

		public function getViewName() : String {
			return base.getViewName();
		}
	}
}
