package pages.decor.platine {

	import com.greensock.TweenMax;
	import com.greensock.easing.Back;

	/**
	 * @author Aymeric
	 */

	public class Disque extends APlatine {

		public function Disque() {
			
		}

		public function animBas():void {
			
			TweenMax.to(this, 0.1, {rotation:20, onComplete:_animBas});
		}
		
		public function animHaut():void {
			
			TweenMax.to(this, 0.1, {rotation:-50, onComplete:_animHaut});
		}
		
		private function _animBas():void {
			TweenMax.to(this, 0.3, {rotation:-50, ease:Back.easeOut});
		}
		
		private function _animHaut():void {
			TweenMax.to(this, 0.3, {rotation:20, ease:Back.easeOut});
		}
	}
}
