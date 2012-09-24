package doot.sprite.edit {
	import doot.model.UserInput;
	import doot.view.ButtonClip;
	import doot.view.IButtonClip;
	import doot.view.events.ButtonClipEvent;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerEditButton extends FASTEventDispatcher implements IFASTEventDispatcher{
		private var input:UserInput=UserInput.instance();

		private var base : IButtonClip;
		private var imp:IEditToolBehaviour;
		private var editor:Editor;

		public function ControllerEditButton(mc:Sprite, imp:IEditToolBehaviour,editor:Editor){
			base = new ButtonClip(mc).when(ButtonClipEvent.MOUSE_DOWN, onStartDrag);
			this.imp = imp;
			this.editor = editor;
		}

		private function onStartDrag(e:Event):void{
			input.updateMouse();
			imp.reset();
			editor.editStart();
			
			input.addEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			input.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		}

		private function onStopDrag(e:Event):void{
			imp.click();
			editor.editEnd();

			input.removeEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			input.removeEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		}

		private function onDragging(e:MouseEvent):void{
			imp.move();
		}
	}
}