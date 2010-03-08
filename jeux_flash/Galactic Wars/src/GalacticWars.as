package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * @author Aymeric
	 */
	public class GalacticWars extends Sprite {
		
		private const MAX_STARS:uint = 80;
		
		private var conteneur:Sprite;
		
		private var gauche:Boolean = false;
		private var droite:Boolean = false;
		private var haut:Boolean = false;
		private var bas:Boolean = false;
		private var vitesseX:int = 15;
		private var vitesseY:int = 15;

		public function GalacticWars() {
			
			addStars();
			conteneur.addEventListener(KeyboardEvent.KEY_DOWN, toucheDown);
			conteneur.addEventListener(KeyboardEvent.KEY_UP, toucheUP);
			conteneur.addEventListener(Event.ENTER_FRAME, deplacement);
		}
		
		private function addStars():void {
			
			conteneur = new Sprite();
			addChild(conteneur);
			stage.focus = conteneur;
			var star:Star;
			
			for (var i:uint = 0; i < MAX_STARS; i++) {
				star = new Star(Math.random() * 0xFFFFFF, Math.random());
				star.name = "star" + i;
				conteneur.addChild(star);
			}
		}
		
		private function toucheDown(k:KeyboardEvent):void {
			
			if (k.keyCode == Keyboard.LEFT) {
				gauche = true;
			}
			if (k.keyCode == Keyboard.RIGHT) {
				droite = true;
			}
			if (k.keyCode == Keyboard.UP) {
				haut = true;
			}
			if (k.keyCode == Keyboard.DOWN) {
				bas = true;
			}
		}
		
		private function toucheUP(k:KeyboardEvent):void {
			
			if (k.keyCode == Keyboard.LEFT) {
				gauche = false;
			}
			if (k.keyCode == Keyboard.RIGHT) {
				droite = false;
			}
			if (k.keyCode == Keyboard.UP) {
				haut = false;
			}
			if (k.keyCode == Keyboard.DOWN) {
				bas = false;
			}
		}
		
		private function deplacement(e:Event):void {
			
			if (gauche) {
				conteneur.x += vitesseX;
			}
			if (droite) {
				conteneur.x -= vitesseX;
			}
			if (haut) {
				conteneur.y += vitesseY;
			}
			if (bas) {
				conteneur.y -= vitesseY;
			}
			// Mouvement perpétuel des étoiles :
			/*for (var i:uint = 0; i < MAX_STARS; i++) {
				if (conteneur.getChildByName("star" + i).x < 0) {
					conteneur.getChildByName("star" + i).x = 600;
				}
			}*/
		}
	}
}
