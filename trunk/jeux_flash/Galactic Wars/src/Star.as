package {
	import flash.display.Shape;

	/**
	 * @author Aymeric
	 */
	public class Star extends Shape {
		
		public var vitesse:Number;
		
		public function Star(couleur:uint, opacite:Number) {
			
			this.graphics.beginFill(couleur, opacite);
			this.graphics.drawCircle(Math.random()*600, Math.random()*500, 3);
			this.graphics.endFill();
			
			vitesse = Math.random() * 10/10 + 0.5;
		}
	}
}
