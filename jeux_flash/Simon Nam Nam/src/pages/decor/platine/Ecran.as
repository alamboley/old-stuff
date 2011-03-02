package pages.decor.platine {

	import flash.text.TextField;

	/**
	 * @author Aymeric
	 */
	 
	public class Ecran extends APlatine {

		public var scoreAffichage:TextField;
		
		private var _score:int;

		public function Ecran() {
			
			scoreAffichage.text = "SCORE : " + String(_score);
		}
		
		public function get score():int {
			return _score;
		}
		
		public function set score(value:int):void {
			_score = value;
			_refresh();
		}
		
		private function _refresh():void {
			scoreAffichage.text = "SCORE : " + String(_score);
		}
	}
}
