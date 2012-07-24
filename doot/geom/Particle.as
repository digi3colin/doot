package doot.geom {
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Particle extends Pt3{
		public var vx:Number=0;
		public var vy:Number=0;
		public var vz:Number=0;
	
		public var ax:Number=0;
		public var ay:Number=0;
		public var az:Number=0;
	
		public var g : Number = 0;
		public var life : Number=0;
		public var color: Number=0;
		public var size:Number=0;
		
		public var airResistance:Number=1;

		public var id:int=0;

		public function Particle(x:Number=0,y:Number=0,z:Number=0,life:Number=600,color:Number=0,size:Number=1,id:int=0){
			super(x,y,z);
			this.life = life;
			this.color = color;
			this.size  = size;
			this.id = id;
		}

		public function step():void{
			if(life<0)return;
			//vf = vi+at;
			//d = (vi+vf)*.5;
			x += (vx+(vx=(vx+ax)))*.5;
			y += (vy+(vy=(vy+ay+g)))*.5;
			z += (vz+(vz=(vz+az)))*.5;

			if(vy<-airResistance)vy=-airResistance;
			if(vy>airResistance)vy=airResistance;
			life--;
		}
	}
}
