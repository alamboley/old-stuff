package view {

	import flash.display.Shape;

	/**
	 * @author Aymeric
	 */
	public class Carre extends AJeton {

		public function Carre() {
			
			super.type = "carre";

			jeton = new Shape();
			
			jeton.graphics.beginFill(0x0000FF, 1);
			jeton.graphics.drawRect(0, 0, 40, 40);
			jeton.graphics.endFill();
			
			addChild(jeton);
		}
	}
}
