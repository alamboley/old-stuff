package pages.decor.porte {

	import pages.decor.DecorEvent;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Aymeric
	 */
	public class AnimPorte extends MovieClip {

		public var btn_gagner:MovieClip;
		public var btn_perdu:MovieClip;

		public var pseudo:TextField;

		public function AnimPorte() {

			btn_gagner.visible = false;
			btn_perdu.visible = false;

			btn_gagner.addEventListener(MouseEvent.CLICK, _goScore);
			btn_perdu.addEventListener(MouseEvent.CLICK, _goScore);
		}

		private function _goScore(mEvt:MouseEvent):void {

			btn_gagner.removeEventListener(MouseEvent.CLICK, _goScore);
			btn_perdu.removeEventListener(MouseEvent.CLICK, _goScore);

			this.dispatchEvent(new DecorEvent(DecorEvent.ENREGISTRER_SCORE));
		}

	}
}
