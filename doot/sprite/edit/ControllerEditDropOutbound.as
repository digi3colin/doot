package doot.sprite.edit {
	import doot.DragItem;
	import doot.model.UserInput;
	import doot.model.utils.GeomUtil;
	import doot.utils.FASTMouse;

	import flash.events.Event;
	import flash.geom.Rectangle;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerEditDropOutbound {
		private var bound : Rectangle;
		private var editor : Editor;
		private var dragItem : DragItem;
		
		public function ControllerEditDropOutbound(editor:Editor,dragItem:DragItem,bound:Rectangle){
			this.bound = bound;
			this.editor = editor.when(Editor.EVENT_EDIT_END, onEditEnd);
			this.dragItem = dragItem.when(DragItem.EVENT_DROP, onDrop);
		}

		private function onEditEnd(e:Event):void{
			UserInput.instance().updateMouse();
			if(GeomUtil.isPointInRect(FASTMouse.x, FASTMouse.y, bound)==false){
				editor.getTargetSprite().remove();
			}
		}

		private function onDrop(e:Event):void{
			UserInput.instance().updateMouse();
			var isAssetInside:Boolean = GeomUtil.isPointInRect(FASTMouse.x, FASTMouse.y, bound);

			if(isAssetInside==false){
				e.stopImmediatePropagation();
			}
		}
	}
}
