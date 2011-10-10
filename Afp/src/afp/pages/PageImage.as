package afp.pages {

	import com.greensock.TweenMax;

	import flash.events.MouseEvent;

	/**
	 * @author Aymeric
	 */
	public class PageImage extends APage {
		
		public var scene:Scene;

		public function PageImage() {
			
			super();
			
			 scene = new Scene();
			 addChild(scene);
			 
			 scene.logo.addEventListener(MouseEvent.CLICK, _goHome);
		}

		private function _goHome(mEvt:MouseEvent):void {
			
			scene.logo.removeEventListener(MouseEvent.CLICK, _goHome);
			
			_gotoPage.dispatch(0);
		}
		
		override public function hide():void {
			
			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}
	}
}
