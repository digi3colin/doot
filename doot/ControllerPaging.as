package doot {
	import asset.BtnPageNav;

	import doot.view.ButtonClip;
	import doot.view.FASTRadioButton;
	import doot.view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerPaging {
		private var width:Number;
		private var mcPageNavigation:Sprite;

		private var btnPrev:ButtonClip;
		private var btnNext : ButtonClip;
		private var btnPageNavs:Array = [];
		private var paging : Paging;

		public function ControllerPaging(mc:Sprite,paging:Paging){
			this.paging = paging;
			this.paging.when(Paging.EVENT_PAGE_COUNT_CHANGE,onAddPage);
			this.paging.when(Paging.EVENT_PAGE_CHANGE, updateNavButtons);

			btnPageNavs = [];

			btnPrev = new ButtonClip(mc['btn_prev']).when(ButtonClipEvent.CLICK, prevClick);
			btnNext = new ButtonClip(mc['btn_next']).when(ButtonClipEvent.CLICK, nextClick);

			this.width = mc.width;
			this.mcPageNavigation = mc['mc_page_nav'];
			Sprite(this.mcPageNavigation['sample']).visible = false;
		}

		private function onAddPage(event:Event) : void {
			//update mcPageNavigation
			var btn:FASTRadioButton;
			for(var i:int=0;i<=paging.getMaxPage();i++){
				if(btnPageNavs[i]!=null)continue;
				var btnView:BtnPageNav = new BtnPageNav();
				this.mcPageNavigation.addChild(btnView);
				btnView.x = i*12;

				btn = new FASTRadioButton(btnView,'btn$'+i);
				btn.addElement(btnView);
				btn.when(ButtonClipEvent.CLICK, navBtnClick);

				btnPageNavs[i] = btn;
			}
			this.mcPageNavigation.x = (width - this.mcPageNavigation.width)*.5;
		}

		private function updateNavButtons(event:Event):void{
			FASTRadioButton(btnPageNavs[paging.getPage()]).select(true);
		}

		private function navBtnClick(event:Event):void{
			paging.setPage(
				parseInt(FASTRadioButton(event.target).getValue())
			);
		}

		private function prevClick(event:Event):void{
			this.paging.prev();
		}

		private function nextClick(event:Event):void{
			this.paging.next();
		}
	}
}
