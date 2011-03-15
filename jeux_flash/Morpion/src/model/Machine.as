package model {

	import flash.events.EventDispatcher;

	/**
	 * @author Aymeric
	 */
	public class Machine extends EventDispatcher {

		private var _seriesJoueur:uint, _seriesMachine:uint;

		public function Machine() {

		}

		public function jouer($profondeur:int):void {

			var max:int = int.MIN_VALUE;
			var tmp:int, maxX:uint, maxY:uint;

			for (var i:uint; i < 3; ++i) {

				for (var j:uint = 0; j < 3; ++j) {

					if (TabGrille.getInstance()[i][j] == 0) {

						TabGrille.getInstance()[i][j] = 1;
						tmp = _min(--$profondeur);

						if (tmp > max || (tmp == max) && (Math.random() > 0.5)) {

							max = tmp;
							maxX = i;
							maxY = j;
						}

						TabGrille.getInstance()[i][j] == 0;
					}
				}
			}

			TabGrille[maxX][maxY] = 1;
		}

		private function _min($profondeur:int):int {

			var result:uint = gagnant();
			if ($profondeur == 0 || result != 0) {
				return _eval();
			}

			var min:int = int.MAX_VALUE;
			var tmp:int;

			for (var i:uint; i < 3; ++i) {

				for (var j:uint = 0; j < 3; ++j) {

					if (TabGrille.getInstance()[i][j] == 0) {

						TabGrille.getInstance()[i][j] = 1;
						tmp = _max(--$profondeur);

						if (tmp < min || (tmp == min) && (Math.random() > 0.5)) {
							min = tmp;
						}

						TabGrille.getInstance()[i][j] == 0;
					}

				}
			}

			return min;
		}

		private function _max($profondeur:int):int {

			var result:uint = gagnant();
			if ($profondeur == 0 || result != 0) {
				return _eval();
			}

			var max:int = int.MIN_VALUE;
			var tmp:int;

			for (var i:uint; i < 3; ++i) {

				for (var j:uint = 0; j < 3; ++j) {

					if (TabGrille.getInstance()[i][j] == 0) {

						TabGrille.getInstance()[i][j] = 2;
						tmp = _min(--$profondeur);

						if (tmp > max || (tmp == max) && (Math.random() > 0.5)) {
							max = tmp;
						}

						TabGrille.getInstance()[i][j] == 0;
					}

				}
			}

			return max;
		}

		private function _eval():int {

			var vainqueur:uint, nbPions:uint;

			for (var i:uint; i < 3; ++i) {

				for (var j:uint = 0; j < 3; ++j) {

					if (TabGrille.getInstance()[i][j] != 0) {
						++nbPions;
					}
				}
			}

			if (vainqueur == gagnant()) {

				if (vainqueur == 1) {
					return int.MAX_VALUE - nbPions;
				} else if (vainqueur == 2) {
					return int.MIN_VALUE + nbPions;
				} else {
					return 0;
				}
			}

			_nbSeries(2);

			return _seriesJoueur - _seriesMachine;
		}

		private function _nbSeries(n:uint):void {
			
			var compteur1:uint, compteur2:uint;
			_seriesJoueur = _seriesMachine = 0;
			
			//Diagonale descendante
			
			for (var i:uint = 0; i < 3; ++i) {
				
				if (TabGrille.getInstance()[i][i] == 1) {
					
					++compteur1;
					compteur2 = 0;
					
					if (compteur1 == n) {
						++_seriesJoueur;
					}
					
				} else if (TabGrille.getInstance()[i][i] == 2) {
					
					++compteur2;
					compteur1 = 0;
					
					if (compteur2 == n)  {
						++_seriesMachine;
					}
				}
			}
			
			compteur1 = compteur2 = 0;
			
			//Diagonale montante
			
			for (var i:uint = 0; i < 3; ++i) {
				
				if (TabGrille.getInstance()[i][2 - i] == 1) {
					
					++compteur1;
					compteur2 = 0;
					
					if (compteur1 == n) {
						++_seriesJoueur;
					}
					
				} else if (TabGrille.getInstance()[i][2 - i] == 2) {
					
					++compteur2;
					compteur1 = 0;
					
					if (compteur2 == n) {
						++_seriesMachine;
					}
				}
			}
			
			//En ligne
			
			for (var i:uint = 0; i < 3; ++i) {
				
				compteur1 = compteur2 = 0;
				
				//Horizontalement
				
				for (var j:uint = 0; j < 3; ++j) {
					
					if (TabGrille.getInstance()[i][j] == 1) {
						
						++compteur1;
						compteur2 = 0;
						
						if (compteur1 == n) {
							++_seriesJoueur;
						}
						
						
					} else if (TabGrille.getInstance()[i][j]) {
						
						++compteur2;
						compteur1 = 0;
						
						if (compteur2 == n) {
							++_seriesMachine;
						}
					}
				}
				
				compteur1 = compteur2 = 0;
				
				//Verticalement
				
				for (var j:uint = 0; j < 3; ++j) {
					
					if (TabGrille.getInstance()[j][i] == 1) {
						
						++compteur1;
						compteur2 = 0;
						
						if (compteur1 == n) {
							++_seriesJoueur;
						}
						
					} else if (TabGrille.getInstance()[j][i] == 2) {
						
						++compteur2;
						compteur1 = 0;
						
						if (compteur2 == n) {
							++_seriesMachine;
						}
					}
				}
			}
		}

		private function gagnant():uint {

			_nbSeries(3);

			if (_seriesJoueur != 0) {
				return 1;
			} else if (_seriesMachine != 0) {
				return 2;
			} else {

				for (var i:uint; i < 3; ++i) {

					for (var j:uint; j < 3; ++j) {

						if (TabGrille.getInstance() == 0) {
							return 0;
						}
					}
				}
			}

			return 3;
		}
	}
}
