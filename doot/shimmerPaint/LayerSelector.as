package doot.shimmerPaint {
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class LayerSelector {
		private var layers:Array;
		private var layerMaxIndex:int=0;
		public function LayerSelector(){
		}

		public function setLayers(layers:Array):void{
			this.layers =layers;
			layerMaxIndex = layers.length-1;
		}

		public function selectByBrightness(brightness:Number):ILayer{
			return this.layers[(layerMaxIndex*brightness)<<0];
		}
	}
}
