package doot.model {
	import doot.view.ButtonClip;
	import doot.view.events.ButtonClipEvent;

	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ButtonList extends FASTEventDispatcher {
		public static const EVENT_SELECT : String = Event.SELECT;
		public static const EVENT_ITEM_OVER : String = MouseEvent.MOUSE_OVER;
		public static const EVENT_ITEM_OUT : String = MouseEvent.MOUSE_OUT;

		private var selectedIndex:int;
		private var items:Array = [];
		private var dictItemIndex:Dictionary = new Dictionary(true);
		
		public function addItem(item:ButtonClip):int{
			item.when(ButtonClipEvent.CLICK,		itemClick);
			item.when(ButtonClipEvent.MOUSE_OVER, 	itemOver);
			item.when(ButtonClipEvent.MOUSE_OUT, 	itemOut);

			dictItemIndex[item] = items.length;
			items.push(item);
			return items.length-1;
		}

		public function select(index : int) : void {
			selectedIndex = index;
			dispatchEvent(new Event(ButtonList.EVENT_SELECT));
		}

		public function selectByItem(item : ButtonClip) : void {
			select(dictItemIndex[item]);
		}
	
		public function getIndex():int{
			return selectedIndex;
		}
		
		public function getLength():int{
			return items.length;
		}
		
		private function itemClick(e:Event):void{
			this.selectByItem(e.target as ButtonClip);
		}

		private function itemOver(e:Event):void{
			dispatchEvent(new Event(ButtonList.EVENT_ITEM_OVER));
		}

		private function itemOut(e:Event):void{
			dispatchEvent(new Event(ButtonList.EVENT_ITEM_OUT));
		}
	}
}
