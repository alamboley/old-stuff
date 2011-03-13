package view {

	import flash.display.Sprite;

	/**
	 * @author Aymeric
	 */
	public class Grille extends Sprite {

		public function Grille() {
			
			this.graphics.lineStyle(2, 0x000000, 1);
			
			this.graphics.moveTo(150, 0);
			this.graphics.lineTo(150, 450);
			
			this.graphics.moveTo(300, 0);
			this.graphics.lineTo(300, 450);
			
			
			this.graphics.moveTo(0, 150);
			this.graphics.lineTo(450, 150);
			
			this.graphics.moveTo(0, 300);
			this.graphics.lineTo(450, 300);
		}
		
		public function addJeton($jeton:AJeton):void {
			
		}
	}
}
