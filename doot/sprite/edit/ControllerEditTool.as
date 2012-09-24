package doot.sprite.edit {
	import doot.IEditTool;
	import doot.sprite.edit.editBehaviour.EditRemoveableMove;
	import doot.sprite.edit.editBehaviour.EditRotate;
	import doot.sprite.edit.editBehaviour.EditScale;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerEditTool{
		//manage show hide of the Edit tool
		private var view:IEditTool;

		private var btnRotate:ControllerEditButton;
		private var btnMove:ControllerEditButton;
		private var btnScale : ControllerEditButton;
		private var editor : Editor;

		public function ControllerEditTool(mc:Sprite,editor:Editor, editTool:IEditTool,bound:Rectangle) {
			this.editor = editor;
			this.editor.when(Editor.EVENT_HIDE_ALL_TOOL, 	hide);
			this.editor.when(Editor.EVENT_SHOW_BASIC_TOOL, 	showMoveTool);
			this.editor.when(Editor.EVENT_SHOW_ALL_TOOL,   	showAllTool);
			this.editor.when(Editor.EVENT_EDIT, 			updateButtonsPosition);

			this.view = editTool;
			view.setBtnMove(mc['btn_move']);
			view.setBtnRotate(mc['btn_rotate']);
			view.setBtnScale(mc['btn_scale']);

			//add new edit features.
			btnRotate 	= new ControllerEditButton(view.getBtnRotate(),new EditRotate(),editor);
			btnMove 	= new ControllerEditButton(view.getBtnMove(),  new EditRemoveableMove(bound)  ,editor);
			btnScale 	= new ControllerEditButton(view.getBtnScale(), new EditScale() ,editor);
			
			doHide();
		}

		private function hide(e:Event):void{
			doHide();
		}

		private function doHide():void{
			this.view.getBtnMove().visible = false;
			this.view.getBtnRotate().visible = false;
			this.view.getBtnScale().visible = false;
		}

		private function showMoveTool(e:Event):void{
			doUpdateButtonsPosition();
			this.view.getBtnMove().visible = true;
		}
		
		private function showAllTool(e:Event):void{
			doUpdateButtonsPosition();
			this.view.getBtnMove().visible = true;
			this.view.getBtnRotate().visible = true;
			this.view.getBtnScale().visible = true;
		}

		private function updateButtonsPosition(e:Event):void{
			doUpdateButtonsPosition();
		}

		private function doUpdateButtonsPosition():void{
			var center:Point = editor.getTargetSprite().getGlobalCenter();

			pos(this.view.getBtnMove(),  center.x,   center.y);
			pos(this.view.getBtnRotate(),center.x-20,center.y);
			pos(this.view.getBtnScale(), center.x+20,center.y);		
		}

		private function pos(mc:Sprite,x:Number,y:Number):void{
			mc.x = x;
			mc.y = y;
		}
	}
}
