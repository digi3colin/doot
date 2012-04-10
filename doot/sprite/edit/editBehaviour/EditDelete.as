package doot.sprite.edit.editBehaviour {
	import doot.sprite.SpriteSelected;
	import doot.sprite.edit.IEditToolBehaviour;
	import flash.display.Sprite;



	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class EditDelete implements IEditToolBehaviour {
		public function click() : void {
			var mc:Sprite = SpriteSelected.instance().selectedSprite();
			mc.parent.removeChild(mc);
			SpriteSelected.instance().deselect();
		}

		public function move() : void {
		}

		public function reset() : void {
		}
	}
}
