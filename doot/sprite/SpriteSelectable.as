﻿package doot.sprite {
	import doot.model.UserInput;

	import com.fastframework.core.EventDispatcherUtils;
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteSelectable extends Sprite implements IFASTEventDispatcher{
		private var mtx:Matrix;
		private var ox:Number;
		private var oy:Number;
		private var r:Number;
		private var s:Number;

		public function SpriteSelectable(x:Number,y:Number) {
			this.ox = this.x = x;
			this.oy = this.y = y;
			this.mtx = new Matrix();
			this.r = 0;
			this.s = 1;

			this.when(MouseEvent.MOUSE_OVER, this, over);
		}

		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this, eventType, whichObject, callFunction);
			return this;
		}

		public function once(eventType : String, whichObject : Object, callback : Function) : * {
			EventDispatcherUtils.instance().once(this, eventType, whichObject, callback);
			return this;
		}

		private function over(e:MouseEvent):void{
			if(UserInput.instance().isMouseDown)return;
			SpriteSelected.instance().select(this);
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

		public function rotate(radian:Number):void{
			if(ox==0){
				var bbox:Rectangle = this.getBounds(this);
				var center:Point = mtx.transformPoint(new Point(bbox.x+bbox.width*0.5,bbox.y+bbox.height*0.5));
				mtx.translate(-center.x, -center.y);
				mtx.rotate(radian-r);
				mtx.translate(center.x, center.y);

				this.transform.matrix = mtx;
			}else{
				this.rotation = radian*180/Math.PI;
			}
			r = radian;
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function getRotate():Number{
			return r;
		}

		public function scale(s:Number):void{
			if(ox==0){
				var bbox:Rectangle = this.getBounds(this);
				var center:Point = mtx.transformPoint(new Point(bbox.x+bbox.width*0.5,bbox.y+bbox.height*0.5));
				mtx.translate(-center.x, -center.y);
				mtx.scale(1/this.s, 1/this.s);
				mtx.scale(s,s);
				mtx.translate(center.x, center.y);

				this.transform.matrix = mtx;
			}else{
				this.scaleX = s;
				this.scaleY = s;
			}
			this.s = s;
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function getScale():Number{
			return s;
		}

		public function translate(tx:Number,ty:Number):void{
			if(ox==0){
				mtx.translate(tx, ty);

				this.transform.matrix = mtx;
			}else{
				this.x = x+tx;
				this.y = y+ty;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function remove():Boolean{
			if(this.parent==null)return false;
			this.parent.removeChild(this);
			dispatchEvent(new Event(Event.CHANGE));
			return true;
		}

		public function getGlobalCenter() : Point {
			var bbox:Rectangle = this.getBounds(this);
			return this.localToGlobal(new Point(bbox.x+bbox.width*0.5,bbox.y+bbox.height*0.5));
		}
	}
}
