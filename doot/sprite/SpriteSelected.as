package doot.sprite {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.events.Event;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteSelected extends FASTEventDispatcher implements IFASTEventDispatcher{
		private var _selectedSprite:SpriteSelectable;
		private static var ins : SpriteSelected;
		public static const SELECT : String = Event.SELECT;
		public static const DESELECT:String = 'deselect';

		public static function instance():SpriteSelected {
			return ins || new SpriteSelected();
		}

		public function SpriteSelected(){
			if(ins!=null){return;}ins = this;
		}

		public function select(mc:SpriteSelectable):void{
			_selectedSprite = mc;
			dispatchEvent(new Event(SpriteSelected.SELECT));
		}

		public function deselect():void{
			_selectedSprite = null;
			dispatchEvent(new Event(SpriteSelected.DESELECT));
		}

		public function selectedSprite() : SpriteSelectable {
			return _selectedSprite;
		}
	}
}
