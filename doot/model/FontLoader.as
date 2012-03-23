package doot.model {
	import com.fastframework.core.FASTLog;
	import flash.events.ProgressEvent;
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.SingletonError;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderEvent;
	import com.fastframework.net.LoaderFactory;
	import doot.ResolveLink;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.Font;
	import flash.utils.Dictionary;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class FontLoader extends FASTEventDispatcher{
		private static var ins:FontLoader;
		public static function instance():FontLoader {
			return ins || new FontLoader();
		}

		private var mcFont:Sprite;
		private var dict:Dictionary;
		private var readyEvent:Event;

		public function FontLoader() {
			if(ins!=null){throw new SingletonError(this);}
			ins = this;
			mcFont = new Sprite();
			dict = new Dictionary(true);
			readyEvent = new Event(LoaderEvent.READY);
		}

		public function load(fontName:String,handler:Function,glyphs:String=''):String{
			//check if the font already loaded;
			for each(var f:Font in Font.enumerateFonts()){
				if(f.fontName==fontName){
					//font found, check glyphs
					if(glyphs=='' || (f.hasGlyphs(glyphs)==true)){
						handler(readyEvent);
						return fontName;
					}
					if(f.hasGlyphs(glyphs)==false){
						//glyphs not found, load additional font file and return the new font name;
						fontName = fontName+'_all';
						break;
					}
				}
			};
			//font not found, load the font file.
			if(dict[fontName]!=null){
				//font is loading. add handler to handlers;
				if(dict[handler] != true)(dict[fontName] as Array).push(handler);
				return fontName;
			}

			FASTLog.instance().log('Load External font files.',FASTLog.LOG_LEVEL_ACTION);
			dict[fontName] = [handler];
			dict[handler] = true;

			var ldFont:ILoader = LoaderFactory.instance().getSWFLoader(mcFont);
			ldFont.once(LoaderEvent.READY,this,function(e:Event):void{onFontLoaded(fontName);});
			ldFont.when(LoaderEvent.PROGRESS,this,onProgress);
			ldFont.load(ResolveLink.instance().create(fontName+'.swf'));

			return fontName;			
		}
		
		private function onFontLoaded(fontName:String):void{
			for each(var handler:Function in dict[fontName]){
				handler(readyEvent);
				delete dict[handler];
			};
			dict[fontName]='';
		}
		
		private function onProgress(e:ProgressEvent):void{
			dispatchEvent(e);
		}
	}
}
