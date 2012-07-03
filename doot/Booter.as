package doot {
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderLoader;
	import flash.display.Sprite;



	/**
	 * The wrapper for main.swf to display the loading progress as soon as possible
	*/

	final public class Booter{
		private var controllers:Array = [];

		public function Booter(mc:Sprite) {
			ResolveLink.instance().setup(mc,Config.TESTING_SERVER);
			var loader:ILoader = new LoaderLoader();

			Template.bg = mc['mc_bg'];
			controllers.push(new ControllerStageSetup(mc.stage));
			controllers.push(new ControllerFileSizeWarning(mc,7168));
			controllers.push(new ControllerBooter(mc,loader));
			controllers.push(new ControllerProgressBar(mc,loader));
		}
	}
}