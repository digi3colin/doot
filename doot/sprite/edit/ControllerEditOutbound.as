package doot.sprite.edit {
	import doot.model.utils.GeomUtil;
	import doot.sprite.SpriteSelectable;

	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerEditOutbound {
		private var bound : Rectangle;
		private var editor: Editor;
		
		public function ControllerEditOutbound(editor:Editor,bound:Rectangle){
			this.bound = bound;
			this.editor = editor.when(Editor.EVENT_EDIT_END, onEditEnd);
		}
		
		private function onEditEnd(e:Event):void{
			var targetSprite:SpriteSelectable = editor.getTargetSprite();
			var targetSpriteCenter:Point = targetSprite.getGlobalCenter();

			var isAssetInside:Boolean = GeomUtil.isPointInRect(targetSpriteCenter.x, targetSpriteCenter.y, bound);
			if(isAssetInside==false){
				targetSprite.remove();
			}
		}
	}
}
