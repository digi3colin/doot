package asset {
	import doot.IDrop;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class DropSprite extends Sprite implements IDrop {
		public static const EVENT_DROP:String = "EVENT_DROP";
		public function DropSprite() {
		}
		
		public function drop():void{
			dispatchEvent(new Event(DropSprite.EVENT_DROP));
		}
	}
}
