package doot.geom {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Emitter extends Pt3{
		private var timer:Timer;
	
		public function Emitter(frequency:Number=0.5,x:Number=0,y:Number=0,z:Number=0){
			super(x,y,z);
	
			var pps:Number = frequency*1000 + Math.random()*500;
	
			timer = new Timer(pps,0);
			timer.addEventListener(TimerEvent.TIMER, emit, false, 0, true);
			timer.start();
		}

		private function emit(e:TimerEvent):void{
			ParticleFactory.instance().reserve(x,y,z);
		}
	}
}
