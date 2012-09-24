package doot.view {
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.text.TextField;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public interface ISmartTextField extends IFASTEventDispatcher{
		function setValidateFunction(fnt:Function):void;
		function validate(...e):Boolean;
		function validateWithoutEventDispatch():Boolean;
		function setSubmit(fnt:Function):void;
		function getTextField():TextField;
		function getValue():String;
		function clear():void;
		function focus():void;
	}
}