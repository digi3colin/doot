﻿package doot.model.i18n {	import doot.I18n;	import com.fastframework.core.SingletonError;	import flash.display.DisplayObjectContainer;	/**	 * @author colin	 */	public class I18nString implements I18n{		private static var ins : I18nString;		public static const PANEL_TITLE_MAKECARD : String = "PANEL_TITLE_MAKECARD";		public static const PANEL_DESC_MAKECARD : String = "PANEL_DESC_MAKECARD";		public static function instance():I18nString {			return ins || new I18nString();		}		private var imp:I18n;		public function I18nString() {			if(ins!=null){throw new SingletonError(this);}ins = this;			imp = new I18n__en();		}		public function t(key : String) : String {			return imp.t(key);		}		public function switchLanguageByMovieClipPath(mc:DisplayObjectContainer):void{			if(mc.loaderInfo.loaderURL.indexOf("/eng/")!=-1){				imp = new I18n__en();			}else{				imp = new I18n__zh_hk();			};		}	}}