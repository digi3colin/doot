package doot.pixel {
	import flash.geom.ColorTransform;	
	
	/**
	 * @author colin
	 */
	final public class CSSColor {
		private var _color : uint = 0;
		private var _alpha : Number = 1;

		public const ALICEBLUE:String = "#F0F8FF";
		public const ANTIQUEWHITE:String = "FAEBD7";
		public const AQUA:String = "#00FFFF";
		public const AQUAMARINE:String = "#7FFFD4";
		public const AZURE:String = "#F0FFFF"; 
		public const BEIGE:String = "#F5F5DC";
		public const BISQUE:String = "#FFE4C4"; 
		public const BLACK:String = "#000000";
		public const BLANCHEDALMOND:String = "#FFEBCD"; 
		public const BLUE:String = "#0000FF";
		public const BLUEVIOLET:String = "#8A2BE2"; 
		public const BROWN:String = "#A52A2A";
		public const BURLYWOOD:String = "#DEB887"; 
		public const CADETBLUE:String = "#5F9EA0";
		public const CHARTREUSE:String = "#7FFF00";
		public const CHOCOLATE:String = "#D2691E";
		public const CORAL:String = "#FF7F50";
		public const CORNFLOWERBLUE:String = "#6495ED"; 
		public const CORNSILK:String = "#FFF8DC";
		public const CRIMSON:String = "#DC143C";
		public const CYAN:String = "#00FFFF";
		public const DARKBLUE:String = "#00008B"; 
		public const DARKCYAN:String = "#008B8B";
		public const DARKGOLDENROD:String = "#B8860B"; 
		public const DARKGRAY:String = "#A9A9A9";
		public const DARKGREY:String = "#A9A9A9";
		public const DARKGREEN:String = "#006400";
		public const DARKKHAKI:String = "#BDB76B";
		public const DARKMAGENTA:String = "#8B008B";
		public const DARKOLIVEGREEN:String = "#556B2F";
		public const DARKORANGE:String = "#FF8C00";
		public const DARKORCHID:String = "#9932CC";
		public const DARKRED:String = "#8B0000";
		public const DARKSALMON:String = "#E9967A"; 
		public const DARKSEAGREEN:String = "#8FBC8F";
		public const DARKSLATEBLUE:String = "#483D8B";
		public const DARKSLATEGRAY:String = "#2F4F4F";
		public const DARKSLATEGREY:String = "#2F4F4F";
		public const DARKTURQUOISE:String = "#00CED1";
		public const DARKVIOLET:String = "#9400D3";
		public const DEEPPINK:String = "#FF1493";
		public const DEEPSKYBLUE:String = "#00BFFF"; 
		public const DIMGRAY:String = "#696969";
		public const DIMGREY:String = "#696969";
		public const DODGERBLUE:String = "#1E90FF";
		public const FIREBRICK:String = "#B22222";
		public const FLORALWHITE:String = "#FFFAF0";
		public const FORESTGREEN:String = "#228B22";
		public const FUCHSIA:String = "#FF00FF";
		public const GAINSBORO:String = "#DCDCDC";
		public const GHOSTWHITE:String = "#F8F8FF";
		public const GOLD:String = "#FFD700";
		public const GOLDENROD:String = "#DAA520";
		public const GRAY:String = "#808080";
		public const GREY:String = "#808080";
		public const GREEN:String = "#008000";
		public const GREENYELLOW:String = "#ADFF2F";
		public const HONEYDEW:String = "#F0FFF0";
		public const HOTPINK:String = "#FF69B4";
		public const INDIANRED :String = "#CD5C5C";
		public const INDIGO :String = "#4B0082";
		public const IVORY:String = "#FFFFF0";
		public const KHAKI:String = "#F0E68C";
		public const LAVENDER:String = "#E6E6FA";
		public const LAVENDERBLUSH:String = "#FFF0F5";
		public const LAWNGREEN:String = "#7CFC00";
		public const LEMONCHIFFON:String = "#FFFACD";
		public const LIGHTBLUE:String = "#ADD8E6";
		public const LIGHTCORAL:String = "#F08080";
		public const LIGHTCYAN:String = "#E0FFFF";
		public const LIGHTGOLDENRODYELLOW:String = "#FAFAD2"; 
		public const LIGHTGRAY:String = "#D3D3D3";
		public const LIGHTGREY:String = "#D3D3D3"; 
		public const LIGHTGREEN:String = "#90EE90";
		public const LIGHTPINK:String = "#FFB6C1";
		public const LIGHTSALMON:String = "#FFA07A";
		public const LIGHTSEAGREEN:String = "#20B2AA"; 
		public const LIGHTSKYBLUE:String = "#87CEFA";
		public const LIGHTSLATEGRAY:String = "#778899";
		public const LIGHTSLATEGREY:String = "#778899";
		public const LIGHTSTEELBLUE:String = "#B0C4DE";
		public const LIGHTYELLOW:String = "#FFFFE0";
		public const LIME:String = "#00FF00";
		public const LIMEGREEN:String = "#32CD32";
		public const LINEN:String = "#FAF0E6";
		public const MAGENTA:String = "#FF00FF";
		public const MAROON:String = "#800000";
		public const MEDIUMAQUAMARINE:String = "#66CDAA";
		public const MEDIUMBLUE:String = "#0000CD";
		public const MEDIUMORCHID:String = "#BA55D3";
		public const MEDIUMPURPLE:String = "#9370D8";
		public const MEDIUMSEAGREEN:String = "#3CB371";
		public const MEDIUMSLATEBLUE:String = "#7B68EE";
		public const MEDIUMSPRINGGREEN:String = "#00FA9A";
		public const MEDIUMTURQUOISE:String = "#48D1CC";
		public const MEDIUMVIOLETRED:String = "#C71585";
		public const MIDNIGHTBLUE:String = "#191970";
		public const MINTCREAM:String = "#F5FFFA";
		public const MISTYROSE:String = "#FFE4E1";
		public const MOCCASIN:String = "#FFE4B5";
		public const NAVAJOWHITE:String = "#FFDEAD";
		public const NAVY:String = "#000080";
		public const OLDLACE:String = "#FDF5E6";
		public const OLIVE:String = "#808000";
		public const OLIVEDRAB:String = "#6B8E23";
		public const ORANGE:String = "#FFA500";
		public const ORANGERED:String = "#FF4500";
		public const ORCHID:String = "#DA70D6";
		public const PALEGOLDENROD:String = "#EEE8AA";
		public const PALEGREEN:String = "#98FB98";
		public const PALETURQUOISE:String = "#AFEEEE";
		public const PALEVIOLETRED:String = "#D87093";
		public const PAPAYAWHIP:String = "#FFEFD5";
		public const PEACHPUFF:String = "#FFDAB9";
		public const PERU:String = "#CD853F";
		public const PINK:String = "#FFC0CB";
		public const PLUM:String = "#DDA0DD";
		public const POWDERBLUE:String = "#B0E0E6";
		public const PURPLE:String = "#800080";
		public const RED:String = "#FF0000";
		public const ROSYBROWN:String = "#BC8F8F";
		public const ROYALBLUE:String = "#4169E1";
		public const SADDLEBROWN:String = "#8B4513";
		public const SALMON:String = "#FA8072";
		public const SANDYBROWN:String = "#F4A460";
		public const SEAGREEN:String = "#2E8B57";
		public const SEASHELL:String = "#FFF5EE";
		public const SIENNA:String = "#A0522D";
		public const SILVER:String = "#C0C0C0";
		public const SKYBLUE:String = "#87CEEB";
		public const SLATEBLUE:String = "#6A5ACD";
		public const SLATEGRAY:String = "#708090";
		public const SLATEGREY:String = "#708090";
		public const SNOW:String = "#FFFAFA";
		public const SPRINGGREEN:String = "#00FF7F";
		public const STEELBLUE:String = "#4682B4";
		public const TAN:String = "#D2B48C";
		public const TEAL:String = "#008080";
		public const THISTLE:String = "#D8BFD8";
		public const TOMATO:String = "#FF6347";
		public const TURQUOISE:String = "#40E0D0";
		public const VIOLET:String = "#EE82EE";
		public const WHEAT:String = "#F5DEB3";
		public const WHITE:String = "#FFFFFF";
		public const WHITESMOKE:String = "#F5F5F5";
		public const YELLOW:String = "#FFFF00";
		public const YELLOWGREEN:String="#9ACD32";

		public function CSSColor(str : String) {
			//rgb(255,221,0), rgba(255,255,255,1), #FFFFFF
			
			if(str.indexOf('#') != -1) {
				_color = parseInt("0x" + str.substr(1, 6));
				_alpha = 1;
			}else if(str.indexOf('rgb(') != -1) {
				_color = decStrToHexColor(str.substring(4, str.length - 1).split(","));
				_alpha = 1;
			}else if(str.indexOf('rgba(') != -1) {
				var components : Array = str.substring(5, str.length - 1).split(",");
				_color = decStrToHexColor(components);
				_alpha = components[3];
			}else {
				str = str.toUpperCase();
				try {
					_color = parseInt("0x" + String(this[str]).substr(1, 6));
					_alpha = 1;
				}catch(e : Error) {
					_color = 0x000000;
					_alpha = 1;
				}
			}
		}

		private function decStrToHexColor(components : Array) : Number {
			//255,255,0
			var cr : Number = Number(components[0]) << 16;
			var cg : Number = Number(components[1]) << 8;
			var cb : Number = Number(components[2]);
			return cr + cg + cb;
		}

		public function get color() : uint {
			return _color;
		}

		public function get alpha() : Number {
			return _alpha;
		}

		public function get rgba() : Number {
			return _color << 8 + Math.round(_alpha * 255);
		}
		
		public function get colorTransform():ColorTransform{
			var result:ColorTransform = new ColorTransform();
			result.color        = _color;
			result.redMultiplier  = 1;
			result.greenMultiplier= 1;
			result.blueMultiplier = 1;
			return result;
		}

		public static function toColorTransform(dRGB:Number,fAlpha:Number=1):ColorTransform{
			return ColorConversion.hexToColor(dRGB, fAlpha);
		}
	}
}
