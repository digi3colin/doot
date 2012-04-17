package doot.sprite {
	import doot.sprite.transform.ITransformBehaviour;

	import com.fastframework.core.IFASTEventDispatcher;

	import flash.text.TextField;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class TextSpriteSelectable extends SpriteSelectable implements IFASTEventDispatcher, ITransformBehaviour {
		private var txf:TextField;

		public function TextSpriteSelectable(x : Number, y : Number) {
			super(x,y);
		}

		public function setText(str:String):void{
			txf.text = str;
		}
	}
}
