package pages.decor.platine {

	import com.gaiaframework.api.Gaia;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;
	import com.greensock.text.SplitTextField;

	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Aymeric
	 */
	 
	public class Ecran extends Platine {

		public var scoreAffichage:TextField;
		
		private var _score:int;
		private var _stf:SplitTextField;

		public function Ecran() {
			
			_refresh();
			
			var tf:TextFormat = new TextFormat();
			tf.font = Gaia.api.getFontName("RockwellBold");
			tf.size = 24; 
			tf.color = 0xB72200;
			
			scoreAffichage.defaultTextFormat = tf;
		}
		
		public function get score():int {
			return _score;
		}
		
		public function set score(value:int):void {
			_score += value;
			
			_stf = new SplitTextField(scoreAffichage, SplitTextField.TYPE_LINES);
			TweenMax.allTo(_stf.textFields, 0.4, {blurFilter:{blurX:20}, x:"100", autoAlpha:0, ease:Quad.easeIn, yoyo:false, onComplete:_destroyEffect}, 0.35);
		}
		
		private function _destroyEffect():void {
			_stf.destroy();
			
			_refresh();
		}
		
		private function _refresh():void {
			scoreAffichage.text = "SCORE : " + String(_score);
		}
	}
}
