package com {

	import model.TabGrille;

	/**
	 * @author Aymeric
	 */
	public class Tools {

		public function Tools() {

		}

		static public function posXToIndiceX($posX:uint):uint {

			if ($posX < 150) {
				return 0;
			} else if ($posX > 150 && $posX < 300) {
				return 1;
			} else {
				return 2;
			}
		}
		
		static public function posYToIndiceY($posY:uint):uint {

			if ($posY < 150) {
				return 0;
			} else if ($posY > 150 && $posY < 300) {
				return 1;
			} else {
				return 2;
			}
		}

		static public function cellIsEmpty($indiceX:uint, $indiceY:uint):Boolean {

			if (TabGrille.getInstance()[$indiceX][$indiceY] == 0) {
				return true;
			} else {
				return false;
			}
		}
	}
}
