package doot.view {
	import doot.utils.FASTMouse;
	import doot.view.events.ButtonClipEvent;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.log.FASTLog;

	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;


	/**
	 * @author Colin
	 */
	final public class ButtonEvt extends FASTEventDispatcher implements IButtonClip{
		private var _focus:Boolean = false;
		private var _select:Boolean = false;

		private var overDelay 	:Number=0;
		private var outDelay	:Number=0;
		private var timerOver	:Timer;
		private var timerOut	:Timer;
		private var elements 	:Dictionary;

		private var hitarea:SimpleButton;

		public function ButtonEvt(hitarea:SimpleButton){
			elements = new Dictionary(true);

			this.hitarea = hitarea;
			hitarea.addEventListener(MouseEvent.ROLL_OVER,  over,	false,0,true);
			hitarea.addEventListener(MouseEvent.ROLL_OUT,   out,	false,0,true);
			hitarea.addEventListener(MouseEvent.CLICK,		click,	false,0,true);
			hitarea.addEventListener(MouseEvent.MOUSE_DOWN, down,	false,0,true);
			
			timerOver = new Timer(overDelay,1);
			timerOver.addEventListener(TimerEvent.TIMER, doOver, false, 0, true);

			timerOut = new Timer(overDelay,1);
			timerOut.addEventListener(TimerEvent.TIMER, doOut, false, 0, true);
		}

		private function onOverOut(e:MouseEvent):void{
			timerOut.reset();
			timerOver.reset();
			FASTMouse.x = e.stageX;
			FASTMouse.y = e.stageY;
		}

		private function over(e:MouseEvent):void{
			onOverOut(e);

			if(overDelay==0){
				doOver();
			}else{
				timerOver.start();
			}
		}
	
		private function doOver():void{
			dispatchEvent(new Event(ButtonClipEvent.MOUSE_OVER));
			dispatchEvent(new Event(ButtonClipEvent.ROLL_OVER));
		}

		private function out(e:MouseEvent):void{
			onOverOut(e);

			if(outDelay==0){
				doOut();
			}else{
				timerOut.start();
			}
		}
		
		private function doOut():void{
			dispatchEvent(new Event(ButtonClipEvent.MOUSE_OUT));
			dispatchEvent(new Event(ButtonClipEvent.ROLL_OUT));
		}

		private function click(e:MouseEvent):void {
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(SimpleButton(e.target)) + ":click/mouseup",	FASTLog.LOG_LEVEL_DETAIL);
			dispatchEvent(new Event(ButtonClipEvent.MOUSE_UP));
			dispatchEvent(new Event(ButtonClipEvent.CLICK));
		}
	
		private function down(e:MouseEvent):void{
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(SimpleButton(e.target))+":mousedown",		FASTLog.LOG_LEVEL_DETAIL);
			dispatchEvent(new Event(ButtonClipEvent.MOUSE_DOWN));
		}

		private function reset():void{
			dispatchEvent(new Event(ButtonClipEvent.RESET));
		}

		public function addElement(element:IButtonElement):IButtonClip{
			elements[element] = 0;
			this.when(ButtonClipEvent.MOUSE_OVER , element.buttonOver);
			this.when(ButtonClipEvent.MOUSE_OUT  , element.buttonOut);
			this.when(ButtonClipEvent.MOUSE_DOWN , element.buttonDown);
			this.when(ButtonClipEvent.RESET      , element.buttonReset);

			//immediate reset the element's status.
			element.init(this);
			return this;
		}

		public function getElements():Dictionary{
			return elements;
		}
	
		public function select(bln:Boolean = true) : IButtonClip {
			this._select = bln;
			reset();
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(SimpleButton(hitarea))+":select:"+bln,FASTLog.LOG_LEVEL_DETAIL);
			dispatchEvent(new Event(ButtonClipEvent.SELECT));
			return this;
		}

		public function setMouseOverDelay(miniSecond : int) : IButtonClip {
			overDelay = miniSecond;
			return this;
		}
		
		public function setMouseOutDelay(miniSecond : int) : IButtonClip {
			outDelay = miniSecond;
			return this;
		}
	
		public function clearMouseOver() : IButtonClip {
			timerOver.reset();
			return this;
		}
	
		public function clearMouseOut() : IButtonClip {
			timerOut.reset();
			return this;
		}

		public function getSelect() : Boolean {
			return this._select;
		}

		public function focus(bln : Boolean = true) : IButtonClip {
			this._focus = bln;
			reset();
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(SimpleButton(hitarea))+":focus:"+bln,FASTLog.LOG_LEVEL_DETAIL);
			dispatchEvent(new Event(ButtonClipEvent.FOCUS));
			return this;
		}

		public function getFocus() : Boolean {
			return this._focus;
		}

	}
}