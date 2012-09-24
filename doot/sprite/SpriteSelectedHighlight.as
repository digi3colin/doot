package doot.sprite {
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class SpriteSelectedHighlight {
		private var selectedSprite:SpriteSelectable;
		private var highlighter:Sprite;

		public function SpriteSelectedHighlight(){
			SpriteSelected.instance().addEventListener(SpriteSelected.EVENT_SELECT, onSpriteSelect,false,-900,true);
			SpriteSelected.instance().when(SpriteSelected.EVENT_DESELECT, onDeselect);

			highlighter = new Sprite();
			highlighter.mouseEnabled = false;
		}

		private function onSpriteSelect(e:Event):void{
			if(this.highlighter.parent!=null)this.highlighter.parent.removeChild(this.highlighter);
			if(this.selectedSprite!=null){
				selectedSprite.removeEventListener(Event.CHANGE, updateBoundBox);
			}

			this.selectedSprite = SpriteSelected.instance().selectedSprite();
			var spriteParent:DisplayObjectContainer = this.selectedSprite.parent;

			//move the bounding box under the selected sprite;
			var selectedSpriteDepth:int = spriteParent.getChildIndex(selectedSprite);
			spriteParent.addChildAt(this.highlighter,selectedSpriteDepth);

			this.selectedSprite.addEventListener(Event.CHANGE, updateBoundBox);

			updateBoundBox();
		}

		private function onDeselect(e:Event):void{
			if(this.highlighter.parent!=null)this.highlighter.parent.removeChild(this.highlighter);
			if(this.selectedSprite!=null)selectedSprite.removeEventListener(Event.CHANGE, updateBoundBox);
			this.selectedSprite = null;
			this.highlighter.graphics.clear();
		}

		private function updateBoundBox(...e):void{
			//move the bounding box under the selected sprite;
			var g:Graphics = highlighter.graphics;
			g.clear();
			if(this.selectedSprite.parent == null)return;

			var bboxPoints:Array = SpriteSelected.instance().selectedSprite().getBoundPoints();

			g.beginFill(1,0.08);

			g.moveTo(Point(bboxPoints[0]).x, Point(bboxPoints[0]).y);
			for(var i:int=1;i<bboxPoints.length;i++){
				g.lineTo(Point(bboxPoints[i]).x, Point(bboxPoints[i]).y);
			}
			g.lineTo(Point(bboxPoints[0]).x, Point(bboxPoints[0]).y);		
		}
	}
}
