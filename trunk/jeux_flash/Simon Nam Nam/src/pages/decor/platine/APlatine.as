package pages.decor.platine {

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class APlatine extends MovieClip {
		
		public var disque:Disque;
		public var ecran:Ecran;
		public var fader:Fader;

		public function APlatine() {
			
		}
		
		public function init():void {
			
		}
		
		public function ajoutScore($value:int):void {
			ecran.score = $value;
		}
		
		public function animPerso(sequence:String):void {

			switch (sequence) {
				
				case "DISQUE_BAS":
					disque.animBas();
					break;
					
				case "FADER_SCRASH_BAS":
					disque.animBas();
					fader.anim();
					break;
					
				case "DISQUE_HAUT":
					disque.animHaut();
					break;
					
				case "FADER_SCRASH_HAUT":
					disque.animHaut();
					fader.anim();
					break;
			}
			
		}
	}
}
