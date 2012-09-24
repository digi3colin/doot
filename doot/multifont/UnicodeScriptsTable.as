package doot.multifont {
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	//ref: http://en.wikipedia.org/wiki/Scripts_in_Unicode
	public class UnicodeScriptsTable {
		public static const Arabic            :String="Arabic"            ;
		public static const Armenian          :String="Armenian"          ;
		public static const Balinese          :String="Balinese"          ;
		public static const Bamum             :String="Bamum"             ;
		public static const Batak             :String="Batak"             ;
		public static const Bengali           :String="Bengali"           ;
		public static const Bopomofo          :String="Bopomofo"          ;
		public static const Braille           :String="Braille"           ;
		public static const Buginese          :String="Buginese"          ;
		public static const Buhid             :String="Buhid"             ;
		public static const CanadianAboriginal:String="CanadianAboriginal";
		public static const Cham              :String="Cham"              ;
		public static const Cherokee          :String="Cherokee"          ;
		public static const Common            :String="Common"            ;
		public static const Coptic            :String="Coptic"            ;
		public static const Cyrillic          :String="Cyrillic"          ;
		public static const Devanagari        :String="Devanagari"        ;
		public static const Ethiopic          :String="Ethiopic"          ;
		public static const Georgian          :String="Georgian"          ;
		public static const Glagolitic        :String="Glagolitic"        ;
		public static const Greek             :String="Greek"             ;
		public static const Gujarati          :String="Gujarati"          ;
		public static const Gurmukhi          :String="Gurmukhi"          ;
		public static const Han               :String="Han"               ;
		public static const Hangul            :String="Hangul"            ;
		public static const Hanunoo           :String="Hanunoo"           ;
		public static const Hebrew            :String="Hebrew"            ;
		public static const Hiragana          :String="Hiragana"          ;
		public static const Inherited         :String="Inherited"         ;
		public static const Javanese          :String="Javanese"          ;
		public static const Kannada           :String="Kannada"           ;
		public static const Katakana          :String="Katakana"          ;
		public static const KayahLi           :String="KayahLi"           ;
		public static const Khmer             :String="Khmer"             ;
		public static const Lao               :String="Lao"               ;
		public static const Latin             :String="Latin"             ;
		public static const Lepcha            :String="Lepcha"            ;
		public static const Limbu             :String="Limbu"             ;
		public static const Lisu              :String="Lisu"              ;
		public static const Malayalam         :String="Malayalam"         ;
		public static const Mandaic           :String="Mandaic"           ;
		public static const MeeteiMayek       :String="MeeteiMayek"       ;
		public static const Mongolian         :String="Mongolian"         ;
		public static const Myanmar           :String="Myanmar"           ;
		public static const NewTaiLue         :String="NewTaiLue"         ;
		public static const Nko               :String="Nko"               ;
		public static const Ogham             :String="Ogham"             ;
		public static const OlChiki           :String="OlChiki"           ;
		public static const Oriya             :String="Oriya"             ;
		public static const PhagsPa           :String="PhagsPa"           ;
		public static const Rejang            :String="Rejang"            ;
		public static const Runic             :String="Runic"             ;
		public static const Samaritan         :String="Samaritan"         ;
		public static const Saurashtra        :String="Saurashtra"        ;
		public static const Sinhala           :String="Sinhala"           ;
		public static const Sundanese         :String="Sundanese"         ;
		public static const SylotiNagri       :String="SylotiNagri"       ;
		public static const Syriac            :String="Syriac"            ;
		public static const Tagalog           :String="Tagalog"           ;
		public static const Tagbanwa          :String="Tagbanwa"          ;
		public static const TaiLe             :String="TaiLe"             ;
		public static const TaiTham           :String="TaiTham"           ;
		public static const TaiViet           :String="TaiViet"           ;
		public static const Tamil             :String="Tamil"             ;
		public static const Telugu            :String="Telugu"            ;
		public static const Thaana            :String="Thaana"            ;
		public static const Thai              :String="Thai"              ;
		public static const Tibetan           :String="Tibetan"           ;
		public static const Tifinagh          :String="Tifinagh"          ;
		public static const Vai               :String="Vai"               ;
		public static const Yi                :String="Yi"                ;

		public static var ins:UnicodeScriptsTable;
		public static function instance():UnicodeScriptsTable{
			return ins || new UnicodeScriptsTable();
		}
		
		private var script:Array = [];
		private var code:Array = [];
		public function UnicodeScriptsTable(){
			if(ins!=null)return;
			ins = this;
			script[UnicodeScriptsTable.Arabic]             = 0x011000;
			script[UnicodeScriptsTable.Armenian]           = 0x012000;
			script[UnicodeScriptsTable.Balinese]           = 0x013000;
			script[UnicodeScriptsTable.Bamum]              = 0x014000;
			script[UnicodeScriptsTable.Batak]              = 0x015000;
			script[UnicodeScriptsTable.Bengali]            = 0x016000;
			script[UnicodeScriptsTable.Bopomofo]           = 0x017000;
			script[UnicodeScriptsTable.Braille]            = 0x018000;
			script[UnicodeScriptsTable.Buginese]           = 0x019000;
			script[UnicodeScriptsTable.Buhid]              = 0x01a000;
			script[UnicodeScriptsTable.CanadianAboriginal] = 0x01b000;
			script[UnicodeScriptsTable.Cham]               = 0x01c000;
			script[UnicodeScriptsTable.Cherokee]           = 0x01d000;
			script[UnicodeScriptsTable.Common]             = 0x01e000;
			script[UnicodeScriptsTable.Coptic]             = 0x01f000;
			script[UnicodeScriptsTable.Cyrillic]           = 0x021000;
			script[UnicodeScriptsTable.Devanagari]         = 0x022000;
			script[UnicodeScriptsTable.Ethiopic]           = 0x023000;
			script[UnicodeScriptsTable.Georgian]           = 0x024000;
			script[UnicodeScriptsTable.Glagolitic]         = 0x025000;
			script[UnicodeScriptsTable.Greek]              = 0x026000;
			script[UnicodeScriptsTable.Gujarati]           = 0x027000;
			script[UnicodeScriptsTable.Gurmukhi]           = 0x028000;
			script[UnicodeScriptsTable.Han]                = 0x029000;
			script[UnicodeScriptsTable.Hangul]             = 0x02a000;
			script[UnicodeScriptsTable.Hanunoo]            = 0x02b000;
			script[UnicodeScriptsTable.Hebrew]             = 0x02c000;
			script[UnicodeScriptsTable.Hiragana]           = 0x02d000;
			script[UnicodeScriptsTable.Inherited]          = 0x02e000;
			script[UnicodeScriptsTable.Javanese]           = 0x02f000;
			script[UnicodeScriptsTable.Kannada]            = 0x031000;
			script[UnicodeScriptsTable.Katakana]           = 0x022000;
			script[UnicodeScriptsTable.KayahLi]            = 0x033000;
			script[UnicodeScriptsTable.Khmer]              = 0x034000;
			script[UnicodeScriptsTable.Lao]                = 0x035000;
			script[UnicodeScriptsTable.Latin]              = 0x036000;
			script[UnicodeScriptsTable.Lepcha]             = 0x037000;
			script[UnicodeScriptsTable.Limbu]              = 0x038000;
			script[UnicodeScriptsTable.Lisu]               = 0x039000;
			script[UnicodeScriptsTable.Malayalam]          = 0x03a000;
			script[UnicodeScriptsTable.Mandaic]            = 0x03b000;
			script[UnicodeScriptsTable.MeeteiMayek]        = 0x03c000;
			script[UnicodeScriptsTable.Mongolian]          = 0x03d000;
			script[UnicodeScriptsTable.Myanmar]            = 0x03e000;
			script[UnicodeScriptsTable.NewTaiLue]          = 0x03f000;
			script[UnicodeScriptsTable.Nko]                = 0x041000;
			script[UnicodeScriptsTable.Ogham]              = 0x042000;
			script[UnicodeScriptsTable.OlChiki]            = 0x043000;
			script[UnicodeScriptsTable.Oriya]              = 0x044000;
			script[UnicodeScriptsTable.PhagsPa]            = 0x045000;
			script[UnicodeScriptsTable.Rejang]             = 0x046000;
			script[UnicodeScriptsTable.Runic]              = 0x047000;
			script[UnicodeScriptsTable.Samaritan]          = 0x048000;
			script[UnicodeScriptsTable.Saurashtra]         = 0x049000;
			script[UnicodeScriptsTable.Sinhala]            = 0x04a000;
			script[UnicodeScriptsTable.Sundanese]          = 0x04b000;
			script[UnicodeScriptsTable.SylotiNagri]        = 0x04c000;
			script[UnicodeScriptsTable.Syriac]             = 0x04d000;
			script[UnicodeScriptsTable.Tagalog]            = 0x04e000;
			script[UnicodeScriptsTable.Tagbanwa]           = 0x04f000;
			script[UnicodeScriptsTable.TaiLe]              = 0x051000;
			script[UnicodeScriptsTable.TaiTham]            = 0x052000;
			script[UnicodeScriptsTable.TaiViet]            = 0x053000;
			script[UnicodeScriptsTable.Tamil]              = 0x054000;
			script[UnicodeScriptsTable.Telugu]             = 0x055000;
			script[UnicodeScriptsTable.Thaana]             = 0x056000;
			script[UnicodeScriptsTable.Thai]               = 0x057000;
			script[UnicodeScriptsTable.Tibetan]            = 0x058000;
			script[UnicodeScriptsTable.Tifinagh]           = 0x059000;
			script[UnicodeScriptsTable.Vai]                = 0x05a000;
			script[UnicodeScriptsTable.Yi]                 = 0x05b000;

			code[0x011000]=UnicodeScriptsTable.Arabic            ;
			code[0x012000]=UnicodeScriptsTable.Armenian          ;
			code[0x013000]=UnicodeScriptsTable.Balinese          ;
			code[0x014000]=UnicodeScriptsTable.Bamum             ;
			code[0x015000]=UnicodeScriptsTable.Batak             ;
			code[0x016000]=UnicodeScriptsTable.Bengali           ;
			code[0x017000]=UnicodeScriptsTable.Bopomofo          ;
			code[0x018000]=UnicodeScriptsTable.Braille           ;
			code[0x019000]=UnicodeScriptsTable.Buginese          ;
			code[0x01a000]=UnicodeScriptsTable.Buhid             ;
			code[0x01b000]=UnicodeScriptsTable.CanadianAboriginal;
			code[0x01c000]=UnicodeScriptsTable.Cham              ;
			code[0x01d000]=UnicodeScriptsTable.Cherokee          ;
			code[0x01e000]=UnicodeScriptsTable.Common            ;
			code[0x01f000]=UnicodeScriptsTable.Coptic            ;
			code[0x021000]=UnicodeScriptsTable.Cyrillic          ;
			code[0x022000]=UnicodeScriptsTable.Devanagari        ;
			code[0x023000]=UnicodeScriptsTable.Ethiopic          ;
			code[0x024000]=UnicodeScriptsTable.Georgian          ;
			code[0x025000]=UnicodeScriptsTable.Glagolitic        ;
			code[0x026000]=UnicodeScriptsTable.Greek             ;
			code[0x027000]=UnicodeScriptsTable.Gujarati          ;
			code[0x028000]=UnicodeScriptsTable.Gurmukhi          ;
			code[0x029000]=UnicodeScriptsTable.Han               ;
			code[0x02a000]=UnicodeScriptsTable.Hangul            ;
			code[0x02b000]=UnicodeScriptsTable.Hanunoo           ;
			code[0x02c000]=UnicodeScriptsTable.Hebrew            ;
			code[0x02d000]=UnicodeScriptsTable.Hiragana          ;
			code[0x02e000]=UnicodeScriptsTable.Inherited         ;
			code[0x02f000]=UnicodeScriptsTable.Javanese          ;
			code[0x031000]=UnicodeScriptsTable.Kannada           ;
			code[0x022000]=UnicodeScriptsTable.Katakana          ;
			code[0x033000]=UnicodeScriptsTable.KayahLi           ;
			code[0x034000]=UnicodeScriptsTable.Khmer             ;
			code[0x035000]=UnicodeScriptsTable.Lao               ;
			code[0x036000]=UnicodeScriptsTable.Latin             ;
			code[0x037000]=UnicodeScriptsTable.Lepcha            ;
			code[0x038000]=UnicodeScriptsTable.Limbu             ;
			code[0x039000]=UnicodeScriptsTable.Lisu              ;
			code[0x03a000]=UnicodeScriptsTable.Malayalam         ;
			code[0x03b000]=UnicodeScriptsTable.Mandaic           ;
			code[0x03c000]=UnicodeScriptsTable.MeeteiMayek       ;
			code[0x03d000]=UnicodeScriptsTable.Mongolian         ;
			code[0x03e000]=UnicodeScriptsTable.Myanmar           ;
			code[0x03f000]=UnicodeScriptsTable.NewTaiLue         ;
			code[0x041000]=UnicodeScriptsTable.Nko               ;
			code[0x042000]=UnicodeScriptsTable.Ogham             ;
			code[0x043000]=UnicodeScriptsTable.OlChiki           ;
			code[0x044000]=UnicodeScriptsTable.Oriya             ;
			code[0x045000]=UnicodeScriptsTable.PhagsPa           ;
			code[0x046000]=UnicodeScriptsTable.Rejang            ;
			code[0x047000]=UnicodeScriptsTable.Runic             ;
			code[0x048000]=UnicodeScriptsTable.Samaritan         ;
			code[0x049000]=UnicodeScriptsTable.Saurashtra        ;
			code[0x04a000]=UnicodeScriptsTable.Sinhala           ;
			code[0x04b000]=UnicodeScriptsTable.Sundanese         ;
			code[0x04c000]=UnicodeScriptsTable.SylotiNagri       ;
			code[0x04d000]=UnicodeScriptsTable.Syriac            ;
			code[0x04e000]=UnicodeScriptsTable.Tagalog           ;
			code[0x04f000]=UnicodeScriptsTable.Tagbanwa          ;
			code[0x051000]=UnicodeScriptsTable.TaiLe             ;
			code[0x052000]=UnicodeScriptsTable.TaiTham           ;
			code[0x053000]=UnicodeScriptsTable.TaiViet           ;
			code[0x054000]=UnicodeScriptsTable.Tamil             ;
			code[0x055000]=UnicodeScriptsTable.Telugu            ;
			code[0x056000]=UnicodeScriptsTable.Thaana            ;
			code[0x057000]=UnicodeScriptsTable.Thai              ;
			code[0x058000]=UnicodeScriptsTable.Tibetan           ;
			code[0x059000]=UnicodeScriptsTable.Tifinagh          ;
			code[0x05a000]=UnicodeScriptsTable.Vai               ;
			code[0x05b000]=UnicodeScriptsTable.Yi                ;
		}

		public function addScript(scriptName:String,codeId:int):void{
			script[scriptName] = codeId;
			code[codeId] = scriptName;
		}

		public function getCodeByScript(scriptName : String) : uint {
			return script[scriptName];
		}
		
		public function getScriptByCode(codeId:int):String{
			return code[codeId];
		}
	}
}
