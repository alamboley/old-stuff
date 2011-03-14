package model {

	import com.Tools;

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

		public function pouvoirJouer():void {
			_stage.addEventListener(MouseEvent.CLICK, _jouer);
		}

		private function _jouer(mEvt:MouseEvent):void {

			if (Tools.cellIsEmpty(Tools.posXToIndiceX(_stage.mouseX), Tools.posYToIndiceY(_stage.mouseY)) == true) {

				_stage.removeEventListener(MouseEvent.CLICK, _jouer);

				this.dispatchEvent(new ModelEvent(ModelEvent.POSER_PION, Tools.posXToIndiceX(_stage.mouseX), Tools.posYToIndiceY(_stage.mouseY)));

			} else {
				trace("Joueur : case occupée");
			}
		}
	}
}
