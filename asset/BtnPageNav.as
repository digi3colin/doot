package asset {
	import doot.motion.MotionTween;
	import doot.pixel.ColorConversion;
	import doot.view.IButtonClip;
	import doot.view.IButtonElement;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class BtnPageNav extends Sprite implements IButtonElement{
		public var icon:Sprite;
		private var mtIcon:MotionTween;
		public function BtnPageNav() {
			mtIcon = new MotionTween(this['icon'],{dur:4});
		}

		public function buttonOver(e : Event) : void {
			mtIcon.startTween({
				c:ColorConversion.hexToColor(0xFFFFFF, 1)
			});
		}

		public function buttonOut(e : Event) : void {
			init(IButtonClip(e.target));
		}

		public function buttonDown(e : Event) : void {
			init(IButtonClip(e.target));
		}

		public function buttonReset(e : Event) : void {
			init(IButtonClip(e.target));
		}

		public function init(btn : IButtonClip) : void {
			mtIcon.startTween({
				c:btn.getSelect()?
					ColorConversion.hexToColor(0, 1):
					ColorConversion.hexToColor(ColorConversion.ORGINAL_COLOR_NUMBER, 1)
			});
		}
	}
}
