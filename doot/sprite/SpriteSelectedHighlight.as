package doot.sprite {
	import com.fastframework.core.SingletonError;
	import com.moet.birthday.card.DrawContexts;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteSelectedHighlight {
		private static var ins : SpriteSelectedHighlight;
		public static function instance():SpriteSelectedHighlight {
			return ins || new SpriteSelectedHighlight();
		}

		public function SpriteSelectedHighlight(){
			if(ins!=null){throw new SingletonError(this);}ins = this;
			
			SpriteSelected.instance().addEventListener(Event.SELECT, onSpriteSelect,false,999,true);
			highlighter = new Sprite();
			highlighter.mouseEnabled = false;
		}

		private var selectedSprite:SpriteSelectable;
		private var highlighter:Sprite;

		private function onSpriteSelect(...e):void{
			if(this.selectedSprite!=null)selectedSprite.removeEventListener(Event.CHANGE, updateBoundBox);
			//nothing selected, clear the highlighter;
			if(SpriteSelected.instance().selectedSprite()==null){
				highlighter.graphics.clear();
				return;
			}


			this.selectedSprite = SpriteSelected.instance().selectedSprite();
			this.selectedSprite.when(Event.CHANGE, this, updateBoundBox);

			updateBoundBox();
			//move the bounding box under the selected sprite;
			DrawContexts.instance().addAsset(this.highlighter);
		}

		private function updateBoundBox(...e):void{
			//move the bounding box under the selected sprite;
			var g:Graphics = highlighter.graphics;
			g.clear();
			if(this.selectedSprite.parent == null)return;

			var bboxPoints:Array = SpriteSelected.instance().selectedSprite().getBoundPoints();

			g.beginFill(1,0.05);

			g.moveTo(Point(bboxPoints[0]).x, Point(bboxPoints[0]).y);
			for(var i:int=1;i<bboxPoints.length;i++){
				g.lineTo(Point(bboxPoints[i]).x, Point(bboxPoints[i]).y);
			}
			g.lineTo(Point(bboxPoints[0]).x, Point(bboxPoints[0]).y);		
		}
	}
}
