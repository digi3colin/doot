package doot.sprite {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.core.SingletonError;

	import flash.events.Event;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteSelected extends FASTEventDispatcher implements IFASTEventDispatcher{
		private static var ins : SpriteSelected;
		public static function instance():SpriteSelected {
			return ins || new SpriteSelected();
		}

		public function SpriteSelected(){
			if(ins!=null){throw new SingletonError(this);}ins = this;
		}

		private var _selectedSprite:SpriteSelectable;
		public function select(mc:SpriteSelectable=null):void{
			this._selectedSprite = mc;
			dispatchEvent(new Event(Event.SELECT));
		}

		public function selectedSprite() : SpriteSelectable {
			return this._selectedSprite;
		}
	}
}
