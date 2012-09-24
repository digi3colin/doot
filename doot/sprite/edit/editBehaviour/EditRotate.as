package doot.sprite.edit.editBehaviour {
	import doot.sprite.SpriteSelectable;
	import doot.sprite.SpriteSelected;
	import doot.sprite.edit.IEditToolBehaviour;
	import doot.utils.FASTMouse;

	import flash.geom.Point;




	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class EditRotate implements IEditToolBehaviour {
		private var op:Point;
		private var lr:Number;//last Rotation
		public function reset():void{
			op = SpriteSelected.instance().selectedSprite().getGlobalCenter();
			lr = Number.NaN;
		}

		public function click() : void {
		}

		public function move() : void {
			var x:Number = FASTMouse.x;
			var y:Number = FASTMouse.y;

			var dx:Number = x-op.x;
			var dy:Number = y-op.y;

			//if too close to the button, the angle will change too much.
			//do nothing.
			var d:Number = Math.sqrt(dx*dx+dy*dy);
			if(d<5)return;

			//if just reset, update the last rotation;
			if(isNaN(lr))lr = Math.atan2(dx,dy);
			var r:Number = Math.atan2(dx,dy);
			var dr:Number = lr-r;

			var mc:SpriteSelectable = SpriteSelected.instance().selectedSprite();
			mc.rotate(mc.getRotate()+dr);

			lr = r;
		}
	}
}