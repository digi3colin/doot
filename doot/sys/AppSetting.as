package doot.sys {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.FASTLog;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.core.SingletonError;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderFactory;
	import doot.ResolveLink;
	import flash.events.Event;


	/**
	 * @author colin
	 */
	/**
	 * AppSetting handles session id from browser or retrive from server
	 */
	public class AppSetting extends FASTEventDispatcher implements IFASTEventDispatcher{
		private static var ins : AppSetting;
		public static const EVENT_SESSION_UPDATE : String = "EVENT_SESSION_UPDATE";
		public static function instance():AppSetting {
			return ins || new AppSetting();
		}

		public function AppSetting() {
			if(ins!=null){throw new SingletonError(this);}
			ins = this;
		}

		private var _session:String='';
		private var _lang:String = 'en';
		private var _city:String = 'asia';

		private var ldrSession:ILoader;
		public function setSession(str:String):void{
			if(_session!=''&&str==''){
				FASTLog.instance().log('Session already set to '+_session, FASTLog.LOG_LEVEL_ERROR);
				return;
			}
			if(str==""){
				if(ldrSession!=null)return;

				ldrSession = LoaderFactory.instance().getXMLLoader();
				ldrSession.when(Event.COMPLETE,this,session2);
				ldrSession.load(ResolveLink.instance().create('users/getSessionId.xml',true));

			}
			_session = str;
		}

		private function session2(e:Event):void{
			var xResult:XML = ldrSession.getContext();
			_session = xResult.@message;
			dispatchEvent(new Event(AppSetting.EVENT_SESSION_UPDATE));
		}

		public function getSession():String{
			return _session;
		}

		public function getLang():String{
			return _lang;
		}
		
		public function setLang(lang:String):void{
			this._lang = lang;
		}

		public function getCity():String{
			return _city;
		}
		
		public function setCity(city:String):void{
			this._city = city;
		}

		public function appendSessionURL(url:String):String{
			return url+((url.match(/\?/)==null)?'?':'&')+'sessionId='+_session;
		}
	}
}