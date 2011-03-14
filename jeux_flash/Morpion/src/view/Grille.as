package view {

	import flash.display.Sprite;

	/**
	 * @author Aymeric
	 */
	public class Grille extends Sprite {
		
		private const _TAILLE_CELL:uint = 150;
		
		private var _posX:uint, _posY:uint;

		public function Grille() {
			
			this.graphics.lineStyle(2, 0x000000, 1);
			
			this.graphics.moveTo(_TAILLE_CELL, 0);
			this.graphics.lineTo(_TAILLE_CELL, _TAILLE_CELL * 3);
			
			this.graphics.moveTo(_TAILLE_CELL * 2, 0);
			this.graphics.lineTo(_TAILLE_CELL * 2, _TAILLE_CELL * 3);
			
			
			this.graphics.moveTo(0, _TAILLE_CELL);
			this.graphics.lineTo(_TAILLE_CELL * 3, _TAILLE_CELL);
			
			this.graphics.moveTo(0, _TAILLE_CELL * 2);
			this.graphics.lineTo(_TAILLE_CELL * 3, _TAILLE_CELL * 2);
		}
		
		public function addJeton($jeton:AJeton, $posX:uint, $posY:uint):void {
			
			if ($posX < 150) {
				_posX = ($jeton.type == "cercle") ?  _TAILLE_CELL * 0.5 : _TAILLE_CELL * 0.5 - $jeton.width * 0.5; 
			} else if ($posX > 150 && $posX < 300) {
				_posX = ($jeton.type == "cercle") ?  _TAILLE_CELL * 1.5 : _TAILLE_CELL * 1.5 - $jeton.width * 0.5; 
			} else {
				_posX = ($jeton.type == "cercle") ?  _TAILLE_CELL * 2.5 : _TAILLE_CELL * 2.5 - $jeton.width * 0.5; 
			}
			
			if ($posY < 150) {
				_posY = ($jeton.type == "cercle") ?  _TAILLE_CELL * 0.5 : _TAILLE_CELL * 0.5 - $jeton.height * 0.5; 
			} else if ($posY > 150 && $posY < 300) {
				_posY = ($jeton.type == "cercle") ?  _TAILLE_CELL * 1.5 : _TAILLE_CELL * 1.5 - $jeton.height * 0.5;
			} else {
				_posY = ($jeton.type == "cercle") ?  _TAILLE_CELL * 2.5 : _TAILLE_CELL * 2.5 - $jeton.height * 0.5;
			}
			
			this.addChild($jeton);
			$jeton.x = _posX;
			$jeton.y = _posY;
		}
	}
}
