
/**
 * @author Colin
 */
package doot.view {
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.utils.Dictionary;
	public interface IButtonClip extends IFASTEventDispatcher{
		function addElement(element:IButtonElement):IButtonClip;
		function getElements():Dictionary;

		function setMouseOverDelay(miniSecond:int):IButtonClip;
		function clearMouseOver():IButtonClip;
		function setMouseOutDelay(miniSecond:int):IButtonClip;
		function clearMouseOut():IButtonClip;

		function select(bln:Boolean=true):IButtonClip;
		function focus(bln:Boolean=true):IButtonClip;
		
		function getSelect():Boolean;
		function getFocus():Boolean;

	}
}