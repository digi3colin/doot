package doot {
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerStageSetup {
		public function ControllerStageSetup(stg : Stage,align:String=StageAlign.TOP_LEFT,scaleMode:String=StageScaleMode.NO_SCALE) {
			stg.align = align;
			stg.scaleMode = scaleMode;
		}
	}
}
