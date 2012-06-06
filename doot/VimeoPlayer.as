package doot {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class VimeoPlayer extends FASTEventDispatcher{
		public static const EVENT_PLAY_STOP:String = "EVENT_PLAYEND";
		public static const EVENT_PLAY_START:String = "EVENT_PLAYSTART";
		private var vid:Video;
		private var url:String;
		public function VimeoPlayer(vid:Video,url:String){
			this.vid = vid;
			this.url = url;
		}

		public function play():void{
			var nc:NetConnection = new NetConnection();
			nc.connect(null);
 
			var ns:NetStream = new NetStream(nc);
			ns.client = {
						onMetaData:ns_onMetaData,
						onCuePoint:ns_onCuePoint
						};

			ns.addEventListener(NetStatusEvent.NET_STATUS, onPlayStatus);
			ns.play(url);

			vid.attachNetStream(ns);
			vid.smoothing = true;
		}

		private function ns_onMetaData(obj:Object):void {}

		private function ns_onCuePoint(obj:Object):void {}

		private function onPlayStatus(e:NetStatusEvent):void{
			switch(e.info['code']){
				case('NetStream.Play.Start'):
					dispatchEvent(new Event(VimeoPlayer.EVENT_PLAY_START));
				break;
				case('NetStream.Play.Stop'):
					dispatchEvent(new Event(VimeoPlayer.EVENT_PLAY_STOP));
				break;
			};
		}
	}
}
