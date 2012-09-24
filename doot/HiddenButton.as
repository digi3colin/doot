package doot {
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class HiddenButton extends Sprite{
		public function HiddenButton(w:Number=100,h:Number=100){
			var hitSprite:Sprite = new Sprite();
			hitSprite.graphics.beginFill(0, 1);
			hitSprite.graphics.drawRect(0, 0, 100, 100);

			this.addChild(new SimpleButton(null, null, null, hitSprite));
			this.scaleX = w*0.01;
			this.scaleY = h*0.01;
		}
	}
}
