package doot.view {
	import com.fastframework.core.FASTEventDispatcher;
	import doot.view.events.ButtonClipEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;


	/**
	 * @author Colin
 */
	final public class ButtonClip extends FASTEventDispatcher implements IButtonClip{
		private var base:ButtonEvt;
		private var repeatTimer:Timer;

		public function ButtonClip(view:DisplayObjectContainer) {
		    base = new ButtonEvt(MovieClipTools.findButton(view));
		    base.when(ButtonClipEvent.MOUSE_DOWN,	down);
		    base.when(ButtonClipEvent.MOUSE_UP,		up);

			//fix the event in target
			base.when(ButtonClipEvent.MOUSE_OVER,	forwardEvent);
			base.when(ButtonClipEvent.MOUSE_OUT, 	forwardEvent);
			base.when(ButtonClipEvent.ROLL_OVER, 	forwardEvent);
			base.when(ButtonClipEvent.ROLL_OUT, 	forwardEvent);
			base.when(ButtonClipEvent.MOUSE_DOWN, 	forwardEvent);
			base.when(ButtonClipEvent.MOUSE_UP, 	forwardEvent);
			base.when(ButtonClipEvent.RESET, 		forwardEvent);
			base.when(ButtonClipEvent.CLICK, 		forwardEvent);
			base.when(ButtonClipEvent.SELECT, 		forwardEvent);

		}

		private function forwardEvent(e:Event):void{
			//flash will change the ButtonClipEvent to MouseEvent.. :(
			this.dispatchEvent(e);
//			this.dispatchEvent(new ButtonClipEvent(e.type,e.highlight,e.mouseX,e.mouseY,e.bubbles,e.cancelable));
		}

		public function addElement(element : IButtonElement) : IButtonClip {
	        base.addElement(element);
	        return this;
		}
		
		public function select(bln:Boolean=true) : IButtonClip {
	        base.select(bln);
	        return this;
		}
		
		public function setMouseOverDelay(miniSecond : int) : IButtonClip {
	        base.setMouseOverDelay(miniSecond);
	        return this;
		}
		
		public function setMouseOutDelay(miniSecond : int) : IButtonClip {
	        base.setMouseOutDelay(miniSecond);
	        return this;
		}
		
		public function clearMouseOver() : IButtonClip {
	        base.clearMouseOver();
	        return this;
		}

		public function clearMouseOut() : IButtonClip {
	        base.clearMouseOut();
	        return this;
		}

		public function setRepeat(ms:Number=33):void{
			if(this.repeatTimer==null){
				this.repeatTimer = new Timer(ms,0);
				this.repeatTimer.addEventListener(TimerEvent.TIMER, repeatClick,false, 0, true);
				return;
			}
			this.repeatTimer.delay = ms;
		}

		private function down(e:Event):void{
			if(this.repeatTimer==null)return;
			repeatTimer.start();
		}
		
		private function up(e:Event):void{
			if(this.repeatTimer==null)return;
			repeatTimer.stop();
		}

		private function repeatClick(e:TimerEvent):void{
			dispatchEvent(new Event(ButtonClipEvent.CLICK));
		}

		public function focus(bln : Boolean = true) : IButtonClip {
			base.focus(bln);
			return this;
		}

		public function getSelect() : Boolean {
			return base.getSelect();
		}

		public function getFocus() : Boolean {
			return base.getFocus();
		}

		public function getElements() : Dictionary {
			return base.getElements();
		}
	}
}