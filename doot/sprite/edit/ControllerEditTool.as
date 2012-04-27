package doot.sprite.edit {
	import asset.EditTool;

	import doot.sprite.edit.editBehaviour.EditMove;
	import doot.sprite.edit.editBehaviour.EditRotate;
	import doot.sprite.edit.editBehaviour.EditScale;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerEditTool{
		//manage show hide of the Edit tool
		private var view:EditTool;

		private var btnRotate:ControllerEditButton;
		private var btnMove:ControllerEditButton;
		private var btnScale : ControllerEditButton;
		private var editor : Editor;

		public function ControllerEditTool(mc:Sprite,editor:Editor) {
			this.editor = editor;
			this.editor.when(Editor.EVENT_HIDE_ALL_TOOL, 	hide);
			this.editor.when(Editor.EVENT_SHOW_BASIC_TOOL, 	showMoveTool);
			this.editor.when(Editor.EVENT_SHOW_ALL_TOOL,   	showAllTool);
			this.editor.when(Editor.EVENT_EDIT, 			updateButtonsPosition);

			this.view = new EditTool();
			view.btn_move     = mc['btn_move'];
			view.btn_rotate   = mc['btn_rotate'];
			view.btn_scale    = mc['btn_scale'];

			//add new edit features.
			btnRotate 	= new ControllerEditButton(view.btn_rotate,new EditRotate(),editor);
			btnMove 	= new ControllerEditButton(view.btn_move,  new EditMove()  ,editor);
			btnScale 	= new ControllerEditButton(view.btn_scale, new EditScale() ,editor);
			
			doHide();
		}

		private function hide(e:Event):void{
			doHide();
		}

		private function doHide():void{
			this.view.btn_move.visible = false;
			this.view.btn_rotate.visible = false;
			this.view.btn_scale.visible = false;		
		}

		private function showMoveTool(e:Event):void{
			doUpdateButtonsPosition();
			this.view.btn_move.visible = true;
		}
		
		private function showAllTool(e:Event):void{
			doUpdateButtonsPosition();
			this.view.btn_move.visible = true;
			this.view.btn_rotate.visible = true;
			this.view.btn_scale.visible = true;
		}

		private function updateButtonsPosition(e:Event):void{
			doUpdateButtonsPosition();
		}

		private function doUpdateButtonsPosition():void{
			var center:Point = editor.getTargetSprite().getGlobalCenter();

			pos(this.view.btn_move,  center.x,   center.y);
			pos(this.view.btn_rotate,center.x-20,center.y);
			pos(this.view.btn_scale, center.x+20,center.y);		
		}

		private function pos(mc:Sprite,x:Number,y:Number):void{
			mc.x = x;
			mc.y = y;
		}
	}
}
