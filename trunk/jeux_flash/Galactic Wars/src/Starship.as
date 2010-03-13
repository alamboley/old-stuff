package {
	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class Starship extends MovieClip {
		
		private var vaisseau:MovieClip;
		
		public function Starship() {
			
			vaisseau = new Vaisseau();
			addChild(vaisseau);
		}
		
		public function rotateLeft():void {
			vaisseau.rotationZ -= 15;
			if (vaisseau.rotationZ < -360) {
				vaisseau.rotationZ = 0;
			}
		}
		
		public function rotateRight():void {
			vaisseau.rotationZ += 15;
			if (vaisseau.rotationZ > 360) {
				vaisseau.rotationZ = 0;
			}
		}
		
		public function rotatePosition():int {
			return vaisseau.rotationZ;
		}
	}
}
