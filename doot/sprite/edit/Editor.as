package doot.sprite.edit {
	import doot.sprite.SpriteSelectable;
	import doot.sprite.SpriteSelected;

	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Editor extends FASTEventDispatcher{
		public static const EVENT_EDIT_START:String 	= 'EVENT_EDIT_START';
		public static const EVENT_EDIT_END:String   	= 'EVENT_EDIT_END';
		public static const EVENT_EDIT:String   		= 'EVENT_EDIT';
		public static const EVENT_HIDE_ALL_TOOL:String	= 'EVENT_HIDE_ALL_TOOL';
		public static const EVENT_SHOW_ALL_TOOL:String  = 'EVENT_SHOW_ALL_TOOL';
		public static const EVENT_SHOW_BASIC_TOOL:String= 'EVENT_SHOW_BASIC_TOOL';
		
		private var delayShowAll:Number = 500;
		private var timerShowAll : Timer;
		private var spriteSelected : SpriteSelected;
		private var targetSprite : SpriteSelectable;
		private var drawArea:Rectangle;

		public function Editor(){
			this.drawArea = drawArea;
			
			spriteSelected = SpriteSelected.instance();
			spriteSelected.when(SpriteSelected.EVENT_SELECT, 	onSpriteSelected);
			spriteSelected.when(SpriteSelected.EVENT_DESELECT,  onDeselect);

			timerShowAll = new Timer(delayShowAll,1);
			timerShowAll.addEventListener(TimerEvent.TIMER, onShowAllTool, false, 0, true);
		}

		public function editStart():void{
			dispatchEvent(new Event(Editor.EVENT_EDIT_START));
		}

		public function editEnd():void{
			dispatchEvent(new Event(Editor.EVENT_EDIT_END));
		}

		public function getTargetSprite():SpriteSelectable{
			return this.targetSprite;
		}
		
		private function spriteEditing(e:Event):void{
			dispatchEvent(new Event(Editor.EVENT_EDIT));
		}
		
		private function onShowAllTool(e:Event):void{
			dispatchEvent(new Event(Editor.EVENT_SHOW_ALL_TOOL));
		}

		private function onSpriteSelected(e:Event) : void {
			targetSprite = spriteSelected.selectedSprite();
			targetSprite.addEventListener(SpriteSelectable.EVENT_CHANGE, spriteEditing);
			timerShowAll.start();
			dispatchEvent(new Event(Editor.EVENT_SHOW_BASIC_TOOL));
		}

		private function onDeselect(e:Event):void{
			if(targetSprite==null)return;
			targetSprite.removeEventListener(SpriteSelectable.EVENT_CHANGE, spriteEditing);
			targetSprite = null;
			timerShowAll.reset();
			dispatchEvent(new Event(Editor.EVENT_HIDE_ALL_TOOL));
		}
	}
}
