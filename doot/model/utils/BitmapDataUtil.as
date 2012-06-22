package doot.model.utils {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class BitmapDataUtil {
		public static function clipBlank(bd:BitmapData):BitmapData{
			//capture the miniumn screen area;
			var bbox:Rectangle = bd.getColorBoundsRect(0xFF000000, 0x00000000,false);

			//if the mc is blank, return a blank 100x100 bitmapdata;
			if(bbox.width==0||bbox.height==0){
				return new BitmapData(100,100,true,0);
			}

			var bdCapture:BitmapData = new BitmapData(bbox.width,bbox.height,true,0);
			bdCapture.draw(bd,new Matrix(1,0,0,1,-bbox.x,-bbox.y));

			return bdCapture;
		}
	}
}
