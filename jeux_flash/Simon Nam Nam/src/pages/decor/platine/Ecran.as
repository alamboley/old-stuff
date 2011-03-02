package pages.decor.platine {

	import com.gaiaframework.api.Gaia;

	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Aymeric
	 */
	 
	public class Ecran extends APlatine {

		public var scoreAffichage:TextField;
		
		private var _score:int;

		public function Ecran() {
			
			var tf:TextFormat = new TextFormat();
			tf.font = Gaia.api.getFontName("RockwellBold");
			tf.size = 24; 
			tf.color = 0xB72200;
			
			scoreAffichage.defaultTextFormat = tf;
			
			// TODO ask nico bush pourquoi bug :
			//scoreAffichage.embedFonts = true;
			//scoreAffichage.setTextFormat(tf);
			
			scoreAffichage.text = "SCORE : " + String(_score);
		}
		
		public function get score():int {
			return _score;
		}
		
		public function set score(value:int):void {
			_score += value;
			_refresh();
		}
		
		private function _refresh():void {
			scoreAffichage.text = "SCORE : " + String(_score);
		}
	}
}
