/**
 * @author Colin
 */
package doot.view {
	import flash.events.Event;

	public interface IButtonElement {
		function buttonOver(e:Event):void;
		function buttonOut(e:Event):void;
		function buttonDown(e:Event):void;
		function buttonReset(e:Event):void;
		function init(btn:IButtonClip):void;
	}
}