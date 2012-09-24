package doot.sprite.edit.editBehaviour {
	import com.fastframework.core.FASTMouse;
	import doot.sprite.SpriteSelected;
	import doot.sprite.edit.IEditToolBehaviour;



	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class EditMove implements IEditToolBehaviour {
		private var lx:Number;
		private var ly:Number;

		public function reset():void{
			lx = FASTMouse.x;
			ly = FASTMouse.y;
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
	}
}
