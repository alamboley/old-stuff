package {
	import flash.display.Shape;
	import flash.filters.BlurFilter;

	/**
	 * @author Aymeric
	 */
	public class Star extends Shape {
		
		private var _vitesseX:Number;
		private var _vitesseY:Number;
		
		public function Star(couleur:uint, opacite:Number) {
			
			this.graphics.beginFill(couleur, opacite);
			this.graphics.drawCircle(0, 0, Math.random() * 4);
			this.graphics.endFill();
			
			this.filters = [new BlurFilter()];
			
			_vitesseX = Math.random() * 3;
			_vitesseY = Math.random() * 3;
		}
		
		public function get vitesseX():Number {
			return _vitesseX;
		}
		
		public function get vitesseY():Number {
			return _vitesseY;
		}
	}
}
