package {
	import flash.display.Shape;

	/**
	 * @author Aymeric
	 */
	public class Star extends Shape {
		
		public function Star(couleur:uint, opacite:Number) {
			
			this.graphics.beginFill(couleur, opacite);
			this.graphics.drawCircle(Math.random()*600, Math.random()*500, 3);
			this.graphics.endFill();
			
			var vitesse:Number = Math.random() * 10/10 + 0.5;
		}
	}
}
