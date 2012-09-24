package doot.sprite.edit.editBehaviour {
	import com.fastframework.core.FASTMouse;
	import doot.sprite.SpriteSelectable;
	import doot.sprite.SpriteSelected;
	import doot.sprite.edit.IEditToolBehaviour;
	import flash.geom.Point;




	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class EditScale implements IEditToolBehaviour {
		private var os : Number;
		private var op : Point;

		public function reset() : void {
			var mc:SpriteSelectable = SpriteSelected.instance().selectedSprite();
			os = mc.getScale();
			op = mc.getGlobalCenter();
		}

		public function click() : void {

		}

		public function move() : void {
			var mc:SpriteSelectable = SpriteSelected.instance().selectedSprite();
			var s:Number = ((FASTMouse.x-op.x)+(op.y-FASTMouse.y))*0.005;
			mc.scale(os+s);
		}
	}
}