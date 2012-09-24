package doot{
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public final class LocaleKeyCollection {
		private var langKey:Object = {};
		private var keys:Vector.<Locale>;
		public function LocaleKeyCollection(xKeys:XMLList){
			keys = new Vector.<Locale>();

			var keyCount:int = xKeys.length();
			for(var i:int=0;i<keyCount;i++){
				var key:XML = xKeys[i];
				this.addKey(parseInt(key['@id']), key['@lang'], parseInt(key['@parent']));
			}
		}

		public function addKey(id:int,lang:String,parent:int):void{
			langKey[lang] = id;
			keys[id] = new Locale(lang,parent);
		}

		public function getKeyIdByLang(lang:String):int{
			if(langKey[lang]==undefined){
				//try search asia_xx
				var guessLang:Array = lang.split('_');
				lang = ((guessLang.length>1)?guessLang[1]:guessLang[0]);
			}
			return langKey[lang];
		}

		public function getParentByKeyId(id:int):int{
			return keys[id].parent;
		}

		public function count() : int {
			return keys.length;
		}
	}
}

final class Locale{
	public var lang:String;
	public var parent:int;
	public function Locale(lang:String,parent:int){
		this.lang = lang;
		this.parent = parent;
	}
}