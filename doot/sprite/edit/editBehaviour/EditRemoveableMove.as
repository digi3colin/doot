package doot.sprite.edit.editBehaviour {
	import doot.model.UserInput;
	import doot.model.utils.GeomUtil;
	import doot.sprite.SpriteSelected;
	import doot.sprite.edit.IEditToolBehaviour;

	import com.fastframework.core.FASTMouse;

	import flash.events.Event;
	import flash.geom.Rectangle;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class EditRemoveableMove implements IEditToolBehaviour {
		private var lx:Number;
		private var ly:Number;
		private var bound:Rectangle;

		public function EditRemoveableMove(bound:Rectangle){
			this.bound = bound;
		}

		public function reset():void{
			lx = FASTMouse.x;
			ly = FASTMouse.y;
			UserInput.instance().once(UserInput.MOUSE_UP, onMouseUp);
		}

		public function click() : void {
		}

		public function move() : void {
			var x:Number = FASTMouse.x;
			var y:Number = FASTMouse.y;
			SpriteSelected.instance().selectedSprite().translate(x-lx,y-ly);
			lx = x;
			ly = y;
		}
		
		private function onMouseUp(e:Event):void{
			UserInput.instance().updateMouse();
			if(GeomUtil.isPointInRect(FASTMouse.x, FASTMouse.y, bound)==false){
				SpriteSelected.instance().selectedSprite().remove();
			}
		}
	}
}
