package afp.pages {

	import com.greensock.TweenMax;

	/**
	 * @author Aymeric
	 */
	public class PageHome extends APage {

		public function PageHome() {
			super();
		}
		
		override public function hide():void {
			
			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}
	}
}
