package {

	import model.Joueur;
	import model.Machine;
	import model.ModelEvent;
	import model.TabGrille;

	import view.Carre;
	import view.Cercle;
	import view.Grille;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite {

		public var btn_rejouer:Sprite;

		private var _grille:Grille;
		private var _joueur:Joueur;
		private var _machine:Machine;

		private var _nbCasesJouees:uint;

		private var _changeOrder:Boolean;

		public function Main() {

			btn_rejouer.buttonMode = true;
			btn_rejouer.mouseChildren = false;
			btn_rejouer.visible = false;

			initJeu();
		}

		private function initJeu():void {

			TabGrille.init();

			_grille = new Grille();
			addChild(_grille);

			btn_rejouer.addEventListener(MouseEvent.CLICK, _restartGame);

			_joueur = new Joueur(stage);
			_joueur.addEventListener(ModelEvent.POSER_PION, _aJoue);

			_machine = new Machine();
			_machine.addEventListener(ModelEvent.POSER_PION, _aJoue);

			// _machine.jouer(3);

			// Tools.pr(TabGrille.getInstance());

			_joueur.pouvoirJouer();
		}

		private function _aJoue(mEvt:ModelEvent):void {

			++_nbCasesJouees;

			if (mEvt.target == _machine) {

				_grille.addJeton(new Cercle(), mEvt.indiceX, mEvt.indiceY);
				TabGrille.setCoup("cercle", mEvt.indiceX, mEvt.indiceY);

				if (_nbCasesJouees < 9) {
					_joueur.pouvoirJouer();
				}
				
			} else {
				
				_grille.addJeton(new Carre(), mEvt.indiceX, mEvt.indiceY);
				TabGrille.setCoup("carre", mEvt.indiceX, mEvt.indiceY);
				
				if (_nbCasesJouees < 9) {
					_machine.jouer(3);
				}
				
			}

			if (_nbCasesJouees == 9) {
				_endGame();
			}
		}

		private function _endGame():void {

			btn_rejouer.visible = true;

			this.setChildIndex(btn_rejouer, this.numChildren - 1);
		}

		private function _restartGame(mEvt:MouseEvent):void {

			btn_rejouer.visible = false;

			_nbCasesJouees = 0;
			TabGrille.init();
			_grille.removeJeton();

			_changeOrder = !_changeOrder;

			if (_changeOrder == true) {
				_machine.jouer(3);
			} else {
				_joueur.pouvoirJouer();
			}
		}
	}
}