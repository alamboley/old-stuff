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
					_grille[i][j] = "vide";
				}
			}
		}
		
		static public function getInstance():Array {
			return _grille;
		}
		
		static public function setCoup($jeton:String, $indiceX:uint, $indiceY:uint):void {
			
			if (_grille[$indiceX][$indiceY] != "vide") {
				trace("erreur, position déjà occupée");
			} else {
				_grille[$indiceX][$indiceY] = $jeton;
			}
			
		}
	}
}
