package model {

	/**
	 * @author Aymeric
	 */
	public class TabGrille {

		static private var _grille:Array;

		public function TabGrille() {

		}

		static public function init():void {

			_grille = new Array();

			for (var i:uint; i < 3; ++i) {

				_grille[i] = new Array(3);

				for (var j:uint = 0; j < 3; ++j) {
					_grille[i][j] = 0;
				}
			}
		}

		static public function getInstance():Array {
			return _grille;
		}

		static public function setCoup($jeton:String, $indiceX:uint, $indiceY:uint):void {

			switch ($jeton) {

				case "vide":
					_grille[$indiceX][$indiceY] = 0;
					break;

				case "carre":
					_grille[$indiceX][$indiceY] = 1;
					break;

				case "cercle":
					_grille[$indiceX][$indiceY] = 2;
					break;
			}
		}
	}
}
