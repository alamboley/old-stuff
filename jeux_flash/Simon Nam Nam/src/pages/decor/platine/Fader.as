package pages.decor.platine {

	import com.greensock.TweenMax;
	import com.greensock.easing.Back;

	/**
	 * @author Aymeric
	 */
	 
	public class Fader extends APlatine {

		public function Fader() {
			
		}
		
		public function anim():void {
			
			TweenMax.to(this, 0.1, {x:45, y:135, onComplete:_anim});
		}
		
		private function _anim():void {
			TweenMax.to(this, 0.3, {x:60, y:140, ease:Back.easeOut});
		}
	}
}
