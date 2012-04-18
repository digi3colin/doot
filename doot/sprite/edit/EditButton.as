package doot.sprite.edit {
	import doot.model.UserInput;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.view.IButtonClip;
	import com.fastframework.view.events.ButtonClipEvent;

	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class EditButton extends FASTEventDispatcher implements IFASTEventDispatcher{
		private var input:UserInput=UserInput.instance();

		private var base : IButtonClip;
		private var imp:IEditToolBehaviour;

		public function EditButton(btn:IButtonClip, imp:IEditToolBehaviour){
			this.imp = imp;
			base = btn.when(ButtonClipEvent.MOUSE_DOWN, onStartDrag);
		}

		private function onStartDrag(e:Event):void{
			input.updateMouse();
			imp.reset();

			input.addEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			input.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);

			dispatchEvent(new Event(MouseEvent.MOUSE_DOWN));
		}

		private function onStopDrag(e:Event):void{
			imp.click();
			input.removeEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			input.removeEventListener(MouseEvent.MOUSE_UP, onStopDrag);

			dispatchEvent(new Event(MouseEvent.MOUSE_UP));
			dispatchEvent(new Event(MouseEvent.CLICK));
		}

		private function onDragging(e:MouseEvent):void{
			imp.move();
		}
	}
}