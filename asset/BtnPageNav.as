package asset {
	import com.fastframework.core.utils.Conversion;
	import com.fastframework.motion.MotionTween;
	import com.fastframework.view.IButtonClip;
	import com.fastframework.view.IButtonElement;

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
				c:Conversion.hexToColor(0xFFFFFF, 1)
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
					Conversion.hexToColor(0, 1):
					Conversion.hexToColor(-1, 1)
			});
		}
	}
}
