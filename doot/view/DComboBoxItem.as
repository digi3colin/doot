package doot.view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import doot.view.events.ActionEvent;
	import doot.view.events.ButtonClipEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;




	/**
	 * @author colin
	 */
	public class DComboBoxItem extends FASTEventDispatcher implements IFASTEventDispatcher{		
		private var label:TextField;
		private var base:ButtonClip;
		public function DComboBoxItem(view:Sprite) {
			label = MovieClipTools.findTextField(view);
			base = new ButtonClip(view);

			base.when(ButtonClipEvent.CLICK, onItemClick);

			//fix the event in target
			base.when(ButtonClipEvent.MOUSE_OVER, 	forwardEvent);
			base.when(ButtonClipEvent.MOUSE_OUT, 	forwardEvent);
			base.when(ButtonClipEvent.ROLL_OVER, 	forwardEvent);
			base.when(ButtonClipEvent.ROLL_OUT, 	forwardEvent);
			base.when(ButtonClipEvent.MOUSE_DOWN, 	forwardEvent);
			base.when(ButtonClipEvent.MOUSE_UP, 	forwardEvent);
			base.when(ButtonClipEvent.RESET, 		forwardEvent);
			base.when(ButtonClipEvent.CLICK, 		forwardEvent);
			base.when(ButtonClipEvent.SELECT, 		forwardEvent);
		}
		
		private function forwardEvent(e:Event):void{
			this.dispatchEvent(e);
		}

		private function onItemClick(e:Event):void{
			dispatchEvent(new Event(Event.SELECT));
			dispatchEvent(new ActionEvent(ActionEvent.ACTION,'select'));
		}

		public function setLabelText(str:String):void{
			if(label == null)return;
			label.text = str;
		}
	}
}
