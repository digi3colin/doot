package doot {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Paging extends FASTEventDispatcher {
		public static const EVENT_REACH_FIRST_PAGE:String 	= "EVENT_REACH_FIRST_PAGE";
		public static const EVENT_REACH_LAST_PAGE:String 	= "EVENT_REACH_LAST_PAGE";
		public static const EVENT_PAGE_COUNT_CHANGE:String 	= "EVENT_PAGE_COUNT_CHANGE";
		public static const EVENT_PAGE_CHANGE : String 		= "EVENT_PAGE_CHANGE";

		private var maxPage : int=0;
		private var pageId : int=0;

		public function Paging() {
		}

		public function setMaxPage(maxPage:int):void{
			this.maxPage = maxPage;
			dispatchEvent(new Event(Paging.EVENT_PAGE_COUNT_CHANGE));
		}

		public function setPage(pageId:int):void{
			this.pageId = pageId;
			dispatchEvent(new Event(Paging.EVENT_PAGE_CHANGE));
			if(pageId>=maxPage)dispatchEvent(new Event(Paging.EVENT_REACH_LAST_PAGE));
			if(pageId<=0)dispatchEvent(new Event(Paging.EVENT_REACH_FIRST_PAGE));
		}

		public function next():void{
			if(pageId>=maxPage)return;
			setPage(pageId+1);
		}

		public function prev():void{
			if(pageId<=0)return;
			setPage(pageId-1);
		}

		public function getMaxPage() : int {
			return maxPage;
		}

		public function getPage() : int {
			return pageId;
		}
	}
}
