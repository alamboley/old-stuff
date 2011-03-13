package view {

	import flash.display.Shape;

	/**
	 * @author Aymeric
	 */
	public class Cercle extends AJeton {

		public function Cercle() {

		}

		override protected function dessinerJeton():void {
			
			jeton = new Shape();
			
			jeton.graphics.beginFill(0xFF0000, 1);
			jeton.graphics.drawCircle(0, 0, 15);
			jeton.graphics.endFill();
		}

	}
}
