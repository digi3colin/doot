﻿package doot {
	import flash.filters.DropShadowFilter;
	import doot.model.UserInput;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.FASTMouse;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class DragItem extends FASTEventDispatcher{
		private static var ins : DragItem;
		public static const EVENT_DROP : String = 'EVENT_DROP';
		private var context:Sprite;
		private var mcToDrop:DisplayObject;
		public static function instance():DragItem{
			return ins||new DragItem();
		}
		
		public function DragItem(){
			if(ins!=null)return;
			ins = this;
			context = new Sprite();
			context.filters = [new DropShadowFilter(2, 90, 0, 0.5, 3, 3)];
		}
		
		public function setView(mc:Sprite):void{
			mc.addChild(context);
		};
		
		public function drag(mcToDrop:DisplayObject):void{
			context.addChild(this.mcToDrop = mcToDrop);

			UserInput.instance().addEventListener(UserInput.MOUSE_UP, drop);
			UserInput.instance().addEventListener(UserInput.MOUSE_MOVE, move);
		}
		
		private function move(e:Event):void{
			this.mcToDrop.x = FASTMouse.x;
			this.mcToDrop.y = FASTMouse.y;
		}
		
		private function drop(e:Event):void{
			UserInput.instance().removeEventListener(UserInput.MOUSE_UP, drop);
			UserInput.instance().removeEventListener(UserInput.MOUSE_MOVE, move);

			context.removeChild(mcToDrop);
			dispatchEvent(new Event(DragItem.EVENT_DROP));
			this.mcToDrop = null;
		}

		public function getViewToDrop():DisplayObject{
			return this.mcToDrop;
		}
	}
}