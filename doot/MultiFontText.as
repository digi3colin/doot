package doot {
	import doot.multifont.UnicodeScriptsTable;
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.utils.StringUtils;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderEvent;
	import com.fastframework.net.LoaderFactory;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class MultiFontText extends FASTEventDispatcher{
		public static const EVENT_READY:String = "EVENT_READY";
		public static const EVENT_CHANGE:String = "EVENT_CHANGE";
		public static const EVENT_LOAD_RANGE_START:String = "EVENT_LOAD_RANGE_START";
		public static const EVENT_LOAD_RANGE_READY : String = "EVENT_LOAD_RANGE_READY";
		public static const EVENT_LOAD_RANGE_CHANGE : String = "EVENT_LOAD_RANGE_CHANGE";

		private var text : String;
		private var fontShortName : String;
		private var loadAsset:LoadAsset;
		private var mcCmap:Sprite;
		
		private var cmap : BitmapData;
		private var fontCount : int;

		public function MultiFontText(fontShortName:String,fontCount:int) {
			//4 byte utf8 have 1FFFFF code point.
			//1FFFFF = 2097151 bits = 262144 bytes;
			//codepoint=0x4E12, codeRange=0x4E1, fontRange=0x4E
			//every fontRange has 16 code point = 16348
			this.fontShortName = fontShortName;
			this.fontCount = fontCount;
			loadAsset = new LoadAsset();
			loadAsset.when(LoadAsset.EVENT_READY,loadReady);

			var cmapLoader:ILoader = LoaderFactory.instance().getSWFLoader(mcCmap = new Sprite());
			cmapLoader.once(LoaderEvent.READY, onCmapLoaded);
			cmapLoader.load(ResolveLink.instance().create('cmap.png',false,false));
		}

		private function onCmapLoaded(e:Event):void{
			cmap = new BitmapData(mcCmap.width, mcCmap.height,false,0);
			cmap.draw(mcCmap);
			dispatchEvent(new Event(MultiFontText.EVENT_READY));
		}

		private function loadReady(e:Event):void{
			dispatchEvent(new Event(MultiFontText.EVENT_LOAD_RANGE_READY));
		}

		public function setText(text:String):void{
			var codePoints:Vector.<int> = StringUtils.toCharCode(text);
			this.text = text;

			for(var i:int=0;i<codePoints.length;i++){
				loadAsset.loadAsset('font/'+getFontSet(codePoints[i], 'script', fontCount));
			}
		}

		public function getHTMLText(latinSize:int=12,hanSize:int=8):String{
			if(loadAsset.getPendingCount()>0)return '...';

			//parse every char with specific font.
			var result:String = '';
			var codePoints:Vector.<int> = StringUtils.toCharCode(text);
			var count:int = codePoints.length;

			for(var i:int=0;i<count;i++){
				result += '<font face="'+getFontName(codePoints[i], 'script', cmap)+'" size="'+getFontSize(codePoints[i],latinSize,hanSize)+'">'+String.fromCharCode(codePoints[i])+'<font>';
			}
			return result;
		}

		private function getFontSize(charCode:int,latinFontSize:int,hanFontSize:int):String{
			var scriptCode:int = cmap.getPixel(charCode&0xFF,charCode>>8)&0xFFFF0;
			var script:String = UnicodeScriptsTable.instance().getScriptByCode(scriptCode);

			switch(script){
				case UnicodeScriptsTable.Latin:
					return latinFontSize.toString();
				case UnicodeScriptsTable.Han:
					return hanFontSize.toString();
				default:
					return latinFontSize.toString();
			}
		}

		public function getFontSet(charCode:int,fontName:String,fontCount:int=16):String{
			//unicode code point
			var codeCount:int = fontCount<<4;
			var snap:int = Math.floor(charCode/codeCount)*codeCount;
			return fontName+'_'+StringUtils.fillPrefixZero(snap.toString(16), 5)+'.swf';
		}

		public function getFontName(charCode : int, fontName : String,cmap:BitmapData=null) : String {
			//search code map, if charCode fall in cat 1, use xxxx1
			var subset:int = (cmap==null)?0:cmap.getPixel(charCode&0xFF,charCode>>8)&0xF;
			if(subset==0xF)return 'no_font';
			var snap:int = charCode&0xFFFF0|subset;

			return fontName+'_'+StringUtils.fillPrefixZero(snap.toString(16),5);
		}

		public function getCharCodeScriptCode(charCode : int, cmap:BitmapData) : int {
			return cmap.getPixel(charCode&0xFF,charCode>>8);
		}
	}
}