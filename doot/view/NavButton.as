package doot.view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.navigation.Navigation;
	import com.fastframework.navigation.NavigationEvent;
	import doot.view.events.ButtonClipEvent;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.utils.Dictionary;




	/**
	 * @author Colin
	 * decorator of ButtonClip
	 */
	final public class NavButton extends FASTEventDispatcher implements IButtonClip{
		private var base:ButtonEvt;

		public var navKey:String;
		public var targetContainer: String;

		public function NavButton(hitarea:SimpleButton,navKey:String,targetContainer:String=''){			
			base = new ButtonEvt(hitarea).when(ButtonClipEvent.CLICK, click);

			this.navKey = navKey;
			this.targetContainer = targetContainer;

			Navigation.instance().when(NavigationEvent.CHANGE, highlightButton);
		}

		private function click(e:Event):void{
			Navigation.instance().changeSection(navKey, targetContainer);
		}

		private function highlightButton(e:NavigationEvent):void{
			highlightButtonByNavKey(e.navKey);
		}

		public function highlightButtonByNavKey(nav_key:String):void{
			if(nav_key==null)return;

			for(var i:int=0;i<nav_key.split("_").length;i++){
				if(this.navKey==nav_key.split("_",i+1).join("_")){
					base.select(true);
					return;
				}
			}
			base.select(false);
		}
		
		public function addElement(element : IButtonElement) : IButtonClip {
			base.addElement(element);
			return this;
		}
		
		public function select(bln:Boolean=true) : IButtonClip {
			base.select(bln);
			return this;
		}
		
		public function setMouseOverDelay(miniSecond : int) : IButtonClip {
			base.setMouseOverDelay(miniSecond);
			return this;
		}
		
		public function setMouseOutDelay(miniSecond : int) : IButtonClip {
			base.setMouseOutDelay(miniSecond);
			return this;
		}
		
		public function clearMouseOver() : IButtonClip {
			base.clearMouseOver();
			return this;
		}
		
		public function clearMouseOut() : IButtonClip {
			base.clearMouseOut();
			return this;
		}

		public function getElements() : Dictionary {
			return base.getElements();
		}

		public function focus(bln : Boolean = true) : IButtonClip {
			base.focus(bln);
			return this;
		}

		public function getSelect() : Boolean {
			return base.getSelect();
		}

		public function getFocus() : Boolean {
			return base.getFocus();
		}
	}
}