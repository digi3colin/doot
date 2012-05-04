package doot.sprite {
	import doot.model.UserInput;
	import doot.sprite.transform.ITransformBehaviour;
	import doot.sprite.transform.SpriteDrawTransform;
	import doot.sprite.transform.SpriteTransform;

	import com.fastframework.core.EventDispatcherUtils;
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteSelectable extends Sprite implements IFASTEventDispatcher, ITransformBehaviour {
		public static const EVENT_CHANGE : String = Event.CHANGE;
		private var imp:ITransformBehaviour;
		public var disableToolOption:int=0;

		public function SpriteSelectable(x:Number,y:Number) {
			this.x = x;
			this.y = y;
			imp = (x==0)?new SpriteDrawTransform(this):new SpriteTransform(this);

			this.when(MouseEvent.MOUSE_OVER, select);
		}

		private function select(e:MouseEvent):void{
			//user doing something.. dont focus it.
			if(UserInput.instance().isMouseDown==true)return;
			//ready to select this sprite;
			SpriteSelected.instance().select(this);
		}

		public function when(eventType : String, callback : Function) : * {
			this.addEventListener(eventType, callback, false,0,true);
			return this;
		}

		public function once(eventType : String, callback : Function) : * {
			EventDispatcherUtils.instance().once(this, eventType, callback);
			return this;
		}

		public function rotate(radian:Number):void{
			imp.rotate(radian);
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function getRotate():Number{
			return imp.getRotate();
		}

		public function scale(s:Number):void{
			imp.scale(s);
			dispatchEvent(new Event(SpriteSelectable.EVENT_CHANGE));
		}

		public function getScale():Number{
			return imp.getScale();
		}

		public function translate(tx:Number,ty:Number):void{
			imp.translate(tx, ty);
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function remove():Boolean{
			if(SpriteSelected.instance().selectedSprite()===this){
				SpriteSelected.instance().deselect();
			}
			if(this.parent==null)return false;
			this.parent.removeChild(this);
			return true;
		}

		public function getBoundPoints():Array{
			var bbox:Rectangle = this.getBounds(this);
			return [
				this.localToGlobal(new Point(bbox.x,bbox.y)),
				this.localToGlobal(new Point(bbox.x+bbox.width,bbox.y)),
				this.localToGlobal(new Point(bbox.x+bbox.width,bbox.y+bbox.height)),
				this.localToGlobal(new Point(bbox.x,bbox.y+bbox.height))
				];
		}

		public function getGlobalCenter() : Point {
			var bbox:Rectangle = this.getBounds(this);
			return this.localToGlobal(new Point(bbox.x+bbox.width*0.5,bbox.y+bbox.height*0.5));
		}
		
		public function getAllowOption():int{
			return disableToolOption;
		}
	}
}
