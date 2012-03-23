package doot.model.i18n {
	import doot.I18n;
	/**
	 * @author colin
	 */
	public class I18n__en implements I18n {
		public var PANEL_TITLE_MAKECARD : String = "Make the card";
		public var PANEL_DESC_MAKECARD : String = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet elit nisl, eget tempor urna.';
		
		public function t(key : String) : String {
			return this[key];
		}
	}
}
