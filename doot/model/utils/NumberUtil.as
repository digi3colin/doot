package doot.model.utils {
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class NumberUtil {
		public static function randomRange(min:Number,max:Number):Number{
			return Math.random()*(max-min)+min;
		}
	}
}
