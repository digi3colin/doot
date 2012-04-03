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
		public static const CLICK:String = MouseEvent.CLICK;
		public static const MOUSE_DOWN:String = MouseEvent.MOUSE_DOWN;
		public static const MOUSE_MOVE:String = MouseEvent.MOUSE_MOVE;
		public static const MOUSE_UP:String = MouseEvent.MOUSE_UP;
		public static const KEY_DOWN:String = KeyboardEvent.KEY_DOWN;
		public static const KEY_UP:String = KeyboardEvent.KEY_UP;

		public var target:Object;
		public var mousePt:Point = new Point();
		public var isMouseDown:Boolean=false;
		private var isEnable:Boolean = true;

		private var stage:Stage;
		private static var ins : UserInput;
		private var listenMove : Boolean;
		public static function instance():UserInput {
			return ins || new UserInput();
		}

		public function UserInput() {
			if(ins!=null){return;}
			ins = this;
		}

		public override function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false):void{
			//mouse move is demanding... only add on require..
			if(listenMove!=true && type==MouseEvent.MOUSE_MOVE){
				stage.addEventListener(MouseEvent.MOUSE_MOVE, this.move);
				listenMove == true;
			}

			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public function setRoot(mc:InteractiveObject):UserInput{
			if(mc.stage ==null){
				mc.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				return this;
			}
			registerRoot(mc.stage);
			return this;
		};

		private function onAddedToStage(e:Event):void{
			InteractiveObject(e.target).removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			registerRoot(InteractiveObject(e.target).stage);
		}
		
		private function registerRoot(stage:Stage):void{
			if(this.stage!=null)return;
			this.stage = stage;

			stage.addEventListener(KeyboardEvent.KEY_UP,   this.forwardKeyboardEvent,false,9999);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.forwardKeyboardEvent,false,9999);
			stage.addEventListener(MouseEvent.CLICK,   	   this.up,false,9999);
			stage.addEventListener(MouseEvent.MOUSE_UP,    this.up,false,9999);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,  this.down,false,9999);
		}

		private function down(e:MouseEvent):void{
			isMouseDown = true;
			forwardMouseEvent(e);
		}
		private function up(e:MouseEvent):void{
			isMouseDown = false;
			forwardMouseEvent(e);
		}
		
		private function move(e:MouseEvent):void{
			if(this.hasEventListener(MouseEvent.MOUSE_MOVE))forwardMouseEvent(e);
		}

		private function forwardMouseEvent(e:MouseEvent):void{
			if(isEnable==false)return;
			trace('input forward',e.stageX,e.stageY);
			this.mousePt.x = e.stageX;
			this.mousePt.y = e.stageY;
			this.target = e.target;
			dispatchEvent(new MouseEvent(e.type,e.bubbles,e.cancelable,e.stageX,e.stageY,e.relatedObject,e.ctrlKey,e.altKey,e.shiftKey,e.buttonDown,e.delta));
		}

		private function forwardKeyboardEvent(e:KeyboardEvent):void{
			if(isEnable==false)return;
			this.target = e.target;
			dispatchEvent(e);
		}

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
