package doot.view {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;


	/**
	 * @author colin
	 */

	public class SmartTextField extends FASTEventDispatcher implements ISmartTextField {
		private var _validateFunction:Function;
		private var _submitFunction:Function;
		private var base:TextField;
		private var oText:String;
		
		public var alwaysCheck:Boolean;
		public var focusClear:Boolean;
		public var invalidMsg:String;
		
		public static const EVENT_VALID:String = "EVENT_VALID";
		public static const EVENT_INVALID:String = "EVENT_INVALID";
		public static const EVENT_RESET:String = "EVENT_RESET";
		public static const EVENT_CHANGE:String = Event.CHANGE;
		public static const EVENT_FOCUS_IN : String = FocusEvent.FOCUS_IN;
		public static const EVENT_FOCUS_OUT : String = FocusEvent.FOCUS_OUT;

		public function SmartTextField(txf:TextField,alwaysCheck:Boolean=false,focusClear:Boolean=false,invalidMsg:String='input invalid.'){
			oText = txf.text;
			base = txf;
			base.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown,false,0,true);
			base.addEventListener(FocusEvent.FOCUS_OUT, focusOut,false,0,true);
			base.addEventListener(FocusEvent.FOCUS_IN, focusIn,false,0,true);
			base.addEventListener(Event.CHANGE, onChange,false,0,true);

			this.alwaysCheck = alwaysCheck;
			this.focusClear = focusClear;
			this.invalidMsg = invalidMsg;
		}

		public function setValidateFunction(fnt:Function):void{
			_validateFunction = fnt;
		}

		public function validate(...e):Boolean{
			if(validateWithoutEventDispatch()){
				dispatchEvent(new Event(SmartTextField.EVENT_VALID));
				return true;
			}else{
				dispatchEvent(new Event(SmartTextField.EVENT_INVALID));
				return false;
			}
			return false;
		}

		public function validateWithoutEventDispatch():Boolean{
			var result:Boolean=false;
			if(_validateFunction!=null){
				result = _validateFunction(getValue());
			}else{
				result=true;
			}			
			if(result==false){
				return false;
			}
			return result;
		}

		public function setSubmit(fnt:Function):void{
			_submitFunction = fnt;
		}

		public function getTextField():TextField{
			return base;
		}

		public function getValue():String{
			if(base.text==oText)return '';
			return base.text;
		}
		
		public function clear():void{
			base.text = "";
			dispatchEvent(new Event(SmartTextField.EVENT_RESET));
		}

		public function focus():void{
			if(base.stage==null){
				base.addEventListener(Event.ADDED_TO_STAGE, onAddStage, false, 0, true);
				return;
			}
			doFocus();
		}

		private function onAddStage(e:Event):void{
			doFocus();
		}

		private function doFocus():void{
			base.stage.focus = base;
			base.setSelection(0, 0);	
		}

		private function onChange(e:Event):void{
			dispatchEvent(new Event(SmartTextField.EVENT_CHANGE));
		}

		private function onKeyDown(e:KeyboardEvent):void{
			if(alwaysCheck==true){
				validate();
			}
			if(e.keyCode==13)submit();
		}

		private function submit():Boolean{
			if(validate()==false)return false;
			if(_submitFunction==null)return false;

			_submitFunction();
			return true;
		}
		
		private function focusOut(e:FocusEvent):void{
			validate();
			if(base.text=="")base.text = oText;
			dispatchEvent(new Event(SmartTextField.EVENT_FOCUS_OUT));
		}
		
		private function focusIn(e:FocusEvent):void{
			if(focusClear==true && (oText==base.text||base.text=="-"||base.text=="0")){
				base.text="";
			}
			dispatchEvent(new Event(SmartTextField.EVENT_FOCUS_IN));	
		}
	}
}
