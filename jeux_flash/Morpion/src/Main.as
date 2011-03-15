package {

	import com.base86.Tools;
	import model.Joueur;
	import model.Machine;
	import model.ModelEvent;
	import model.TabGrille;

	import view.Carre;
	import view.Cercle;
	import view.Grille;

	import flash.display.Sprite;

	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite {

		private var _grille:Grille;
		private var _joueur:Joueur;
		private var _machine:Machine;
		
		private var _nbCasesJouees:uint;

		public function Main() {

			initJeu();
		}

		private function initJeu():void {

			TabGrille.init();

			_grille = new Grille();
			addChild(_grille);

			_joueur = new Joueur(stage);
			_joueur.addEventListener(ModelEvent.POSER_PION, _joueurAJoue);
			
			_machine = new Machine();
			
			_machine.jouer(3);
			
			Tools.pr(TabGrille.getInstance());

			_joueur.pouvoirJouer();
		}

		private function _joueurAJoue(mEvt:ModelEvent):void {

			_grille.addJeton(new Carre(), mEvt.indiceX, mEvt.indiceY);

			_ajouterCoup("Joueur", mEvt.indiceX, mEvt.indiceY);
		}

		private function _ajouterCoup($personnage:String, $tabIndiceX:uint, $tabIndiceY:uint):void {


			if ($personnage == "Joueur") {

				TabGrille.setCoup("carre", $tabIndiceX, $tabIndiceY);
				
				++_nbCasesJouees;

			} else {

				TabGrille.setCoup("cercle", $tabIndiceX, $tabIndiceY);
				_grille.addJeton(new Cercle(), $tabIndiceX * Grille.tailleCell, $tabIndiceY * Grille.tailleCell);

				_joueur.pouvoirJouer();
			}
		}
	}
}