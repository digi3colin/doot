package doot.sprite.edit {
	import asset.EditTool;

	import doot.sprite.SpriteSelected;

	import com.fastframework.core.FASTMouse;

	import flash.display.Sprite;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class EditToolBox{
		private var mcTrashBin:Sprite;
		private var mc:Sprite;
		private var editToolController:EditToolController;

		public function EditToolBox(mc:Sprite):void{
			this.mc = mc;

			mcTrashBin = mc['mc_trash_bin'];
			
			var tool:EditTool = new EditTool();
			tool.btn_move  = mc['btn_move'];
			tool.btn_rotate= mc['btn_rotate'];
			tool.btn_scale = mc['btn_scale'];

			editToolController = new EditToolController(SpriteSelected.instance(), tool);
			editToolController.when(EditToolController.EVENT_MOVE_END, onMoveEnd);
		}

		private function onMoveEnd(...e):void{
			var isDropOnBin:Boolean = mcTrashBin.hitTestPoint(
				FASTMouse.x, 
				FASTMouse.y, true
			);

			if(isDropOnBin==true){
				SpriteSelected.instance().selectedSprite().remove();
			}
		}

		public function hide() : void {
			editToolController.hide();
		}
	}
}