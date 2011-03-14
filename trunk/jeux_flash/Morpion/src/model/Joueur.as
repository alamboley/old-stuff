package model {

	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	/**
	 * @author Aymeric
	 */

	public class Joueur extends EventDispatcher {

		private var _stage:Stage;

		public function Joueur($stage:Stage) {

			_stage = $stage;
		}

		public function pouvoirJouer($autoriser:Boolean):void {

			if ($autoriser == true) {
				
				_stage.addEventListener(MouseEvent.CLICK, _jouer);
			}
		}

		private function _jouer(mEvt:MouseEvent):void {

			_stage.removeEventListener(MouseEvent.CLICK, _jouer);

			this.dispatchEvent(new ModelEvent(ModelEvent.POSER_PION, _stage.mouseX, _stage.mouseY));
		}
	}
}
