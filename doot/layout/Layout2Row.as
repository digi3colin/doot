package doot.layout{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Layout2Row implements IBoxLayout {
		private var layoutScale:Number;
		private var w:Number;
		private var h:Number;
		private var objSizes:Vector.<Rectangle>;

		public function Layout2Row(w:Number=1000,h:Number=567){
			this.w = w;
			this.h = h;
			layoutScale = w/1000;
			objSizes = new <Rectangle>[new Rectangle(0,0,layoutScale*180,layoutScale*230),new Rectangle(0,0,layoutScale*180,layoutScale*100),new Rectangle(0,0,layoutScale*10,layoutScale*10)];
		}

		public function compose(displayObjects : Vector.<DisplayObject>) : Vector.<Matrix> {
			//return transform matrix array for positioning.
			//all origins at left top
			var views:Vector.<ViewObject> = new Vector.<ViewObject>();
			var bound:Rectangle;
			for(var i:int=0;i<displayObjects.length;i++){
				bound = displayObjects[i].getBounds(displayObjects[i]);
				views[i] = new ViewObject(bound.width,bound.height);
			}

			return layout(views);
		}

		private function fitScale(view:ViewObject,suggestW:Number,suggestH:Number):Number{
			//scale
			//resize require;
			var ratioFlo:Number = view.width/view.height;
			var ratioFix:Number = suggestW/suggestH;
	
			return (ratioFlo<ratioFix)?
						(suggestH/view.height):
						(suggestW/view.width);
		}

		private function layout(views:Vector.<ViewObject>):Vector.<Matrix>{
			//position for first row;
			var posX:Number = 0;
			var posY:Number = h*0.8;//*0.8;
			var padding:Number = layoutScale*40;//20*2
			var groupLineSpace:Number = layoutScale*280;

			var currAssetGroupId:Number = 0;
			var results:Vector.<Matrix> = new Vector.<Matrix>();
			var assetGroups:Vector.<Vector.<ViewObject>> = new Vector.<Vector.<ViewObject>>();
			var groupWidth:Number= w-padding;
			var space:Number = layoutScale*10;
			var vo:ViewObject;
			var scale:Number;
			var right:Number;

			for(var i:int=0;i<views.length;i++){
				vo = views[i];

				scale= fitScale(vo,objSizes[currAssetGroupId].width,objSizes[currAssetGroupId].height);
				vo.transform = new Matrix(scale,0,0,scale,posX,posY);

				right = vo.width*scale+posX;

				//check over flow
				if(right>groupWidth){
					posY-=groupLineSpace;
					posX=0;			
					currAssetGroupId++;
					i--;
					continue;
				}

				if(assetGroups.length<=currAssetGroupId){
					assetGroups[currAssetGroupId] = new Vector.<ViewObject>();
				}

				assetGroups[currAssetGroupId].push(vo);
				results[i] = vo.transform;

				posX= right+space;
			}

			alignCenter(assetGroups);

			return results;
		}

		private function alignCenter(assetGroups:Vector.<Vector.<ViewObject>>):void{
			var bottomCurveAmp:Number = layoutScale*100;
			var upperCurveAmp:Number = layoutScale*50;
	
			var asset:ViewObject;
			var assets:Vector.<ViewObject>;
			var assetCenterX:Number;
			var assetHalfHeight:Number;
			var lastAsset:ViewObject;
			var groupWidth:Number;
			var padding:Number;

			for(var i:int=0;i<assetGroups.length;i++){
				assets = assetGroups[i];
				lastAsset = assets[assets.length-1];
				groupWidth = lastAsset.transform.tx+lastAsset.width*lastAsset.transform.a;
				padding = (w-groupWidth)*0.5;

				for(var j:int=0;j<assets.length;j++){
					asset = assets[j];
					assetCenterX = (asset.transform.tx+asset.width*asset.transform.a*.5)+padding;//*.5;
					assetHalfHeight=(asset.height*asset.transform.a*.5);
					//Math.sin(n*Math.PI)*amplitude
					asset.transform.translate(
									padding, 
									(i==0)?(Math.sin(assetCenterX/w*Math.PI)*bottomCurveAmp-bottomCurveAmp-assetHalfHeight):(Math.sin(assetCenterX/w*Math.PI)*-upperCurveAmp+upperCurveAmp-assetHalfHeight));
					//curve layout for bottom group.
				}
			}
		}
	}
}

import flash.geom.Matrix;
final class ViewObject{
	public var width:Number;
	public var height:Number;
	public var transform : Matrix;

	public function ViewObject(width : Number, height : Number) {
		this.width = width;
		this.height = height;
	}
}