package asset {
	import doot.IEditTool;

	import flash.display.Sprite;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class EditTool implements IEditTool{
		public var btn_rotate : Sprite;
		public var btn_move : Sprite;
		public var btn_scale : Sprite;
		
		public function getBtnRotate():Sprite{
			return this.btn_rotate;
		}
		
		public function getBtnMove():Sprite{
			return this.btn_move;
		}
		
		public function getBtnScale():Sprite{
			return this.btn_scale;
		}

		public function setBtnRotate(mc : Sprite) : void {
			this.btn_rotate = mc;
		}

		public function setBtnMove(mc : Sprite) : void {
			this.btn_move = mc;
		}

		public function setBtnScale(mc : Sprite) : void {
			this.btn_scale = mc;
		}
	}
}

