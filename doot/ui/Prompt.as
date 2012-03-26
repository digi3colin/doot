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
			ins ||=new Prompt(new SingletonBlocker());
			return ins;
		}
		
		public function Prompt(p_key:SingletonBlocker) {
			base = new AbstractView();
			p_key;
		}
		
		private var base:AbstractView;
		private var body:TextField;
		private var title:TextField;
		private var btn_cancel:ButtonClip;
		private var btn_ok:ButtonClip;

		public function setView(mc : Sprite, autoHide : Boolean = true) : IView {
			base.setView(mc,autoHide);
			btn_cancel 	= new ButtonClip(mc['btn_cancel']);
			btn_cancel.when(MouseEvent.CLICK, onCancel);
			btn_ok 		= new ButtonClip(mc['btn_ok']);
			btn_ok.when(MouseEvent.CLICK, onOk);
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

			this.btn_cancel.setEnabled((cancelCallBack!=null));
			this.btn_ok.setEnabled((okCallBack!=null)||okAndHide==true);

			this.cancelCallBack = cancelCallBack;
			this.okCallBack = okCallBack;
			this.okAndHide = okAndHide;
			show();
		}

		private function onCancel(e:MouseEvent):void{
			if(this.cancelCallBack!=null)cancelCallBack();
			btn_cancel.setEnabled(false);
			btn_ok.setEnabled(false);
			hide();
		}

		private function onOk(e:MouseEvent):void{
			if(this.okCallBack!=null)okCallBack();
			btn_cancel.setEnabled(false);
			btn_ok.setEnabled(false);
			if(okAndHide == true)hide();
		}

		public function getViewName() : String {
			return base.getViewName();
		}
	}
}

class SingletonBlocker{}