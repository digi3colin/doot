package doot{
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SlideShow extends FASTEventDispatcher {
		public static const EVENT_CHANGE:String = "EVENT_CHANGE";
		public static const EVENT_START:String = "EVENT_START";
		public static const EVENT_END:String = "EVENT_END";

		private var currentId:int=-1;
		private var timer:Timer;
		private var count:int=0;

		public function SlideShow() {
			timer = new Timer(3000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer, false, 0, true);
		}

		private function onTimer(e:Event):void{
			next();
		}

		public function setCount(count:int):void{
			this.count = count;
		}

		public function getCount():int{
			return count;
		}

		public function getCurrentId():int{
			return currentId;
		}

		public function start() : void {
			currentId = 0;
			timer.reset();
			timer.start();
			dispatchEvent(new Event(SlideShow.EVENT_CHANGE));
			dispatchEvent(new Event(SlideShow.EVENT_START));
		}

		public function next():void{
			if(currentId>=count-1){
				timer.stop();
				dispatchEvent(new Event(SlideShow.EVENT_END));
				return;
			}

			currentId++;
			dispatchEvent(new Event(SlideShow.EVENT_CHANGE));
		}

		public function pause():void{
			timer.stop();
		}

		public function resume():void{
			timer.reset();
			timer.start();
		}
	}
}
