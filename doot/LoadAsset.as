package doot {
	import doot.net.LoaderEvent;
	import doot.net.LoaderFactory;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.net.ILoader;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class LoadAsset extends FASTEventDispatcher {
		public static const EVENT_CHANGE:String 	= "EVENT_CHANGE";
		public static const EVENT_START:String 		= "EVENT_START";
		public static const EVENT_READY : String	= "EVENT_READY";

		private var reqestedAssets:Array;
		private var pendingRequestCount : int = 0;

		public function LoadAsset() {
			reqestedAssets = [];
		}

		public function loadAsset(file:String):void{
			if(reqestedAssets[file]!=null)return;
			reqestedAssets[file] = false;

			var context:Sprite = new Sprite();
			var ld:ILoader = LoaderFactory.instance().getSWFLoader(context);
			ld.once(LoaderEvent.READY, onAssetLoaded);
			ld.once(LoaderEvent.IO_ERROR, onIOError);

			pendingRequestCount++;
			
			ld.load(ResolveLink.instance().create(file));
		}

		private function onAssetLoaded(e:Event):void{
			pendingRequestCount--;
			
			dispatchEvent(new Event(LoadAsset.EVENT_CHANGE));
			if(pendingRequestCount<=0){
				dispatchEvent(new Event(LoadAsset.EVENT_READY));
			}
		}
		
		private function onIOError(e:Event):void{
			pendingRequestCount--;
		}

		public function getPendingCount() : Number {
			return pendingRequestCount;
		}
	}
}
