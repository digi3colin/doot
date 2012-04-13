package doot.sprite {
	import doot.model.UserInput;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.FASTMouse;
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteSelected extends FASTEventDispatcher implements IFASTEventDispatcher{
		private var _selectedSprite:SpriteSelectable;
		private var preSelectSprite:SpriteSelectable;
		private var selectTimer:Timer;
		private var delay:int = 250;

		private static var ins : SpriteSelected;
		public static const EVENT_SELECT : String = Event.SELECT;
		public static const EVENT_DESELECT:String = 'deselect';

		public static function instance():SpriteSelected {
			return ins || new SpriteSelected();
		}

		public function SpriteSelected(){
			if(ins!=null){return;}ins = this;
			selectTimer = new Timer(delay,1);
			selectTimer.addEventListener(TimerEvent.TIMER, doSelect,false, 0, true);
		}

		public function select(mc:SpriteSelectable):void{
			preSelectSprite = mc;

			selectTimer.reset();
			selectTimer.start();
		}

		private function doSelect(e:TimerEvent):void{
			//the sprite already selected.. do nothing.
			if(_selectedSprite==preSelectSprite)return;
			//check user still over the sprite;
			UserInput.instance().updateMouse();
			if(preSelectSprite.hitTestPoint(FASTMouse.x, FASTMouse.y, true)==false)return;

			_selectedSprite = preSelectSprite;
			dispatchEvent(new Event(SpriteSelected.EVENT_SELECT));		
		}

		public function deselect():void{
			selectTimer.reset();

			_selectedSprite = null;
			preSelectSprite = null;
			dispatchEvent(new Event(SpriteSelected.EVENT_DESELECT));
		}

		public function selectedSprite() : SpriteSelectable {
			return _selectedSprite;
		}
	}
}
