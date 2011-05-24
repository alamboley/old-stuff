package kinessia.pacman.objects {

	import kinessia.pacman.Objet;
	import kinessia.pacman.TypesObjets;
	/**
	 * @author Aymeric
	 */
	public class EndLevel extends Objet {

		public function EndLevel() {
			
			type = TypesObjets.OBJET;
			
			this.graphics.clear();
			this.graphics.beginFill(0x00FF00);
			this.graphics.drawRect(0, 0, 20, 20);
			this.graphics.endFill();
		}
	}
}
