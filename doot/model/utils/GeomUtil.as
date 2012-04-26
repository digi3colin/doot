package doot.model.utils {
	import flash.geom.Rectangle;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class GeomUtil {
		public static function isPointInRect(x:Number,y:Number,rect:Rectangle):Boolean{
			return (x > rect.left && x < rect.right && y > rect.top && y < rect.bottom);
		}
	}
}
