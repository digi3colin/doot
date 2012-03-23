package doot.model {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class UserInput extends FASTEventDispatcher implements IFASTEventDispatcher{
		public static const MOUSE_DOWN:String = MouseEvent.MOUSE_DOWN;
		public static const MOUSE_MOVE:String = MouseEvent.MOUSE_MOVE;
		public static const MOUSE_UP:String = MouseEvent.MOUSE_UP;
		public static const KEY_DOWN:String = KeyboardEvent.KEY_DOWN;
		public static const KEY_UP:String = KeyboardEvent.KEY_UP;

		public var target:Object;
		public var mousePt:Point = new Point();
		public var isMouseDown:Boolean=false;

		private var stage:Stage;
		private static var ins:UserInput;
		public static function instance():UserInput {
			return ins || new UserInput();
		}

		public function UserInput() {
			if(ins!=null){return;}ins = this;
		}

		public function setRoot(mc:InteractiveObject):UserInput{
			if(mc.stage ==null){
				mc.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
				return this;
			}
			registerRoot(mc.stage);
			return this;
		};

		private function onAddedToStage(e:Event):void{
			InteractiveObject(e.target).removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false);
			registerRoot(InteractiveObject(e.target).stage);
		}
		
		private function registerRoot(stage:Stage):void{
			if(this.stage!=null)return;
			this.stage = stage;

			stage.addEventListener(MouseEvent.MOUSE_DOWN, this.down, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, this.forwardMouseEvent, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP,   this.up, false, 0, true);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.forwardKeyboardEvent, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_UP,   this.forwardKeyboardEvent, false, 0, true);
		}

		private function down(e:MouseEvent):void{
			isMouseDown = true;
			forwardMouseEvent(e);
		}
		private function up(e:MouseEvent):void{
			isMouseDown = false;
			forwardMouseEvent(e);
		}

		private function forwardMouseEvent(e:MouseEvent):void{
			if(isEnable==false)return;
			
			this.target = e.target;
			this.mousePt.x = e.stageX;
			this.mousePt.y = e.stageY;
			dispatchEvent(new MouseEvent(e.type,e.bubbles,e.cancelable,e.stageX,e.stageY,e.relatedObject,e.ctrlKey,e.altKey,e.shiftKey,e.buttonDown,e.delta));
		}

		private function forwardKeyboardEvent(e:KeyboardEvent):void{
			if(isEnable==false)return;
			this.target = e.target;
			dispatchEvent(e);
		}

		private var isEnable:Boolean = true;
		public function enable():void{
			isEnable = true;
		}

		public function disable():void{
			isEnable = false;
		}
		
		public function getObjectsUnderPoint():Array{
			return this.stage.getObjectsUnderPoint(mousePt);
		}
	}
}
