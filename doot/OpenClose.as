package doot{
	import com.fastframework.core.FASTEventDispatcher;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;



	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class OpenClose extends FASTEventDispatcher implements IOpenClose {
		public static const EVENT_OPEN : String = Event.OPEN;
		public static const EVENT_CLOSE: String = Event.CLOSE;
		
		private var isOpen:Boolean;
		private var timerClose:Timer;

		public function OpenClose(closeDelay:Number = 300){
			timerClose = new Timer(closeDelay,1);
			timerClose.addEventListener(TimerEvent.TIMER, doClose, false, 0, true);
		}

		public function open() : void {

			timerClose.stop();
			if(isOpen==true)return;
			isOpen = true;
			dispatchEvent(new Event(OpenClose.EVENT_OPEN));
		}

		public function close() : void {

			timerClose.reset();
			timerClose.start();
		}

		private function doClose(e:Event):void{
			if(isOpen==false)return;
			isOpen = false;
			dispatchEvent(new Event(OpenClose.EVENT_CLOSE));		
		}

		public function toggle() : void {
			if(isOpen == true){
				close();
			}else{
				open();
			}
		}
	}
}
