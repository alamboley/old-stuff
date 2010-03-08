package {
	import flash.display.Shape;

	/**
	 * @author Aymeric
	 */
	public class Star extends Shape {
		
		protected var _vitesse:Number;
		
		public function Star(couleur:uint, opacite:Number) {
			
			this.graphics.beginFill(couleur, opacite);
			this.graphics.drawCircle(0, 0, Math.random() * 4);
			this.graphics.endFill();
			
			_vitesse = Math.random() * 1.1;
		}
		
		public function get vitesse():Number {
			return _vitesse;
		}
	}
}
