package view {

	import flash.display.Shape;

	/**
	 * @author Aymeric
	 */
	public class Cercle extends AJeton {

		public function Cercle() {
			
			super.type = "cercle";

			jeton = new Shape();

			jeton.graphics.beginFill(0xFF0000, 1);
			jeton.graphics.drawCircle(0, 0, 20);
			jeton.graphics.endFill();
			
			addChild(jeton);
		}
	}
}
