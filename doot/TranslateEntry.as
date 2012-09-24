package doot{
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class TranslateEntry {
		private var entries:Vector.<String>;
		private var langs:LocaleKeyCollection;

		public function TranslateEntry(xEntries:XMLList,langCollection:LocaleKeyCollection){
			langs = langCollection;
			entries = new Vector.<String>(langCollection.count());
			var entryCount:int = xEntries.length();
			var entry:XML;

			for(var i:int=0;i<entryCount;i++){
				entry = xEntries[i];
				entries[langCollection.getKeyIdByLang(String(entry.name()))] = entry.toString();
			}
		}
		
		public function getTranslatedString(langKey:int):String{
			var result:String = entries[langKey];

			//if result is null, search it's parent's text
			var keyId:int = langKey;
			var lastKey:int=-1;
			while(result==null){
				keyId = langs.getParentByKeyId(keyId);
				result = entries[keyId];

				if(lastKey == keyId)return result;//search end. no string found
				lastKey = keyId;
			}
			return result;
		}
		
		public function getTranslatedStringByLang(lang:String):String{
			return getTranslatedString(langs.getKeyIdByLang(lang));
		}
	}
}
