package {

	import model.Joueur;
	import model.ModelEvent;
	import model.TabGrille;

	import view.Carre;
	import view.Cercle;
	import view.Grille;

	import com.base86.Tools;

	import flash.display.Sprite;

	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite {

		private var _grille:Grille;
		private var _joueur:Joueur;

		public function Main() {

			initJeu();
		}

		private function initJeu():void {

			TabGrille.init();

			_grille = new Grille();
			addChild(_grille);

			_joueur = new Joueur(stage);
			_joueur.addEventListener(ModelEvent.POSER_PION, _joueurAJoue);

			_joueur.pouvoirJouer(true);

			_grille.addJeton(new Cercle(), 152, 152);
			_grille.addJeton(new Carre(), 5, 152);


			TabGrille.setCoup("cercle", 1, 1);
			TabGrille.setCoup("carre", 0, 1);
		}

		private function _joueurAJoue(mEvt:ModelEvent):void {

			_grille.addJeton(new Carre(), mEvt.posX, mEvt.posY);

			_ajouterCoup("Joueur", mEvt.posX, mEvt.posY);
		}

		private function _ajouterCoup($personnage:String, $posX:uint, $posY:uint):void {

			var tabIndiceX:uint, tabIndiceY:uint;

			if ($personnage == "Joueur") {

				if ($posX < 150) {
					tabIndiceX = 0;
				} else if ($posX > 150 && $posX < 300) {
					tabIndiceX = 1;
				} else {
					tabIndiceX = 2;
				}

				if ($posY < 150) {
					tabIndiceY = 0;
				} else if ($posY > 150 && $posY < 300) {
					tabIndiceY = 1;
				} else {
					tabIndiceY = 2;
				}

				TabGrille.setCoup("carre", tabIndiceX, tabIndiceY);

			} else {
				TabGrille.setCoup("cercle", tabIndiceX, tabIndiceY);
			}
		}
	}
}