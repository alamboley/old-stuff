package afp.pages {

	import com.greensock.TweenMax;

	/**
	 * @author Aymeric
	 */
	public class PageImage extends APage {
		
		public var scene:Scene;

		public function PageImage() {
			
			super();
			
			 scene = new Scene();
			 addChild(scene);
		}
		
		override public function hide():void {
			
			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}
	}
}
