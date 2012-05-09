package doot {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Confirm extends FASTEventDispatcher implements IConfirm {
		public static const EVENT_CONFIRM:String = 'EVENT_CONFIRM';

		public function confirm() : void {
			dispatchEvent(new Event(Confirm.EVENT_CONFIRM));
		}
	}
}
