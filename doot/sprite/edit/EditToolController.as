package doot.sprite.edit{
	import asset.EditTool;
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.view.ButtonClip;
	import doot.sprite.SpriteSelectable;
	import doot.sprite.SpriteSelected;
	import doot.sprite.edit.editBehaviour.EditMove;
	import doot.sprite.edit.editBehaviour.EditRotate;
	import doot.sprite.edit.editBehaviour.EditScale;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;





	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class EditToolController extends FASTEventDispatcher{
		public static const EVENT_MOVE_END:String = 'move_end';

		//manage show hide of the Edit tool
		private var delayShowAll:Number = 500;
		private var timerShowAll:Timer;
		
		private var model:SpriteSelected;
		private var targetSprite:SpriteSelectable;
		private var view:EditTool;

		private var btnRotate:EditButton;
		private var btnMove:EditButton;
		private var btnScale:EditButton;
		public function EditToolController(model:SpriteSelected,view:EditTool) {
			this.view = view;
			this.model = model;

			btnRotate 	= new EditButton(new ButtonClip(view.btn_rotate),new EditRotate());

			btnMove 	= new EditButton(new ButtonClip(view.btn_move),new EditMove());
			btnMove.when(MouseEvent.MOUSE_DOWN, onMoveStart);
			btnMove.when(MouseEvent.MOUSE_UP, onMoveEnd);

			btnScale 	= new EditButton(new ButtonClip(view.btn_scale),new EditScale());

			model.when(SpriteSelected.SELECT, spriteSelected);
			model.when(SpriteSelected.DESELECT, onDeselect);

			timerShowAll = new Timer(delayShowAll,1);
			timerShowAll.addEventListener(TimerEvent.TIMER, showAllTool, false, 0, true);

			hide();
		}

		private function onMoveStart(...e):void{
			watchTarget();
		}

		private function onMoveEnd(...e):void{
			unwatchTarget();
			dispatchEvent(new Event(EditToolController.EVENT_MOVE_END));
		}

		private function watchTarget():void{
			targetSprite.addEventListener(SpriteSelectable.EVENT_CHANGE, updateButtonsPosition);		
		}
		
		private function unwatchTarget():void{
			if(targetSprite==null)return;
			targetSprite.removeEventListener(SpriteSelectable.EVENT_CHANGE, updateButtonsPosition);		
		}

		private function onDeselect(...e):void{
			unwatchTarget();
			targetSprite = null;
			hide();
		}

		private function spriteSelected(...e) : void {
			onMoveEnd();
			targetSprite = model.selectedSprite();

			hide();
			showMoveTool();
			updateButtonsPosition();

			timerShowAll.start();
		}

		public function hide(...e):void{
			timerShowAll.reset();
			this.view.btn_move.visible = false;
			this.view.btn_rotate.visible = false;
			this.view.btn_scale.visible = false;
		}

		private function showMoveTool(...e):void{
			this.view.btn_move.visible = true;
		}
		
		private function showAllTool(...e):void{
			this.view.btn_move.visible = true;
			this.view.btn_rotate.visible = true;
			this.view.btn_scale.visible = true;
		}

		private function updateButtonsPosition(...e):void{
//			var pos:Point = SpriteSelectable.selected.getCornerTopRight();
			var center:Point = targetSprite.getGlobalCenter();

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
