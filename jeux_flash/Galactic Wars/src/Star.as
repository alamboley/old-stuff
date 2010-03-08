package {
	import flash.display.Shape;

	/**
	 * @author Aymeric
	 */
	public class Star extends Shape {
		
		public var vitesse:Number;
		
		public function Star(couleur:uint, opacite:Number) {
			
			this.graphics.beginFill(couleur, opacite);
			this.graphics.drawCircle(0, 0, 3);
			this.graphics.endFill();
			
			vitesse = Math.random() * 10/10 + 0.5;
		}
	}
}
