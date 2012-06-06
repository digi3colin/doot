package doot {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderEvent;
	import com.fastframework.net.LoaderFactory;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class LoadAsset extends FASTEventDispatcher {
		public static const EVENT_CHANGE:String 	= "EVENT_CHANGE";
		public static const EVENT_START:String 		= "EVENT_START";
		public static const EVENT_READY : String	= "EVENT_READY";

		private var reqestedAssetsMap:ByteArray;
		private var loadedAssetsMap:ByteArray;

		private var pendingRequestCount : int = 0;
		private var dictContextId : Dictionary;


		public function LoadAsset(size:int) {
			reqestedAssetsMap 			= new ByteArray();
			loadedAssetsMap 			= new ByteArray();
			dictContextId 				= new Dictionary(true);

			reqestedAssetsMap.length 	= loadedAssetsMap.length = size;
		}
		
		public function loadAsset(id:int,prefix:String,extension:String):void{
			if(this.checkNeedLoad(id)==false)return;
			
			var requestAssetsBytePosition:uint = id>>3;
			reqestedAssetsMap.position = requestAssetsBytePosition;
			var requestedAssetByte:uint = reqestedAssetsMap.readUnsignedByte();

			if(((id&7) & requestedAssetByte)!=0)return;
			reqestedAssetsMap.position = requestAssetsBytePosition;
			reqestedAssetsMap.writeByte(requestedAssetByte|(id&7));

			//codePoint 0x4E00 - 0x4EFF, fontRange will be 4E 
			var context:Sprite = new Sprite();
			var ld:ILoader = LoaderFactory.instance().getSWFLoader(context);
			ld.once(LoaderEvent.READY, onAssetLoaded);
			ld.once(LoaderEvent.IO_ERROR, onIOError);

			dictContextId[context] = id;

			pendingRequestCount++;
			ld.load(ResolveLink.instance().create(prefix+'_'+id.toString(16)+'.'+extension));
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

		public function checkNeedLoad(id : int) : Boolean {
			reqestedAssetsMap.position = loadedAssetsMap.position = id>>3;
			if(((id&7) & (reqestedAssetsMap.readUnsignedByte() | loadedAssetsMap.readUnsignedByte()))==0){
				return true;
			}

			return false;
		}

		public function getPendingCount() : Number {
			return pendingRequestCount;
		}
	}
}
