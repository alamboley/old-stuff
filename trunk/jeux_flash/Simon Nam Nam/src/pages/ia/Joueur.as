package pages.ia {

	import pages.ia.event.JoueurDispatcher;
	import pages.ia.event.JoueurEvent;
	import pages.son.PlaylistSon;

	import flash.display.MovieClip;
	import flash.display.Stage;

	/**
	 * @author Aymeric
	 */

	public class Joueur extends MovieClip {

		private var _stage:Stage;
		private var _seqJoueur:Array;
		private var _nbSon:uint, _nbSonPlay:uint;

		public function Joueur($stage:Stage) {

			_stage = $stage;

			var joueurDispatcher:JoueurDispatcher = new JoueurDispatcher(_stage);
			joueurDispatcher.addEventListener(JoueurEvent.SCROLLB, _playSoundEvent);
			joueurDispatcher.addEventListener(JoueurEvent.SCROLLB_ESPACE, _playSoundEvent);
			joueurDispatcher.addEventListener(JoueurEvent.SCROLLH, _playSoundEvent);
			joueurDispatcher.addEventListener(JoueurEvent.SCROLLH_ESPACE, _playSoundEvent);
		}

		public function reproduireSequence($nbSon:uint):void {

			_nbSon = $nbSon;
			_nbSonPlay = 0;

			for (var i:uint; i < _nbSon; ++i) {
				trace(PlaylistSon.getPlaylist()[i][0]);
			}

			_seqJoueur = [];
		}

		private function _playSoundEvent(jEvt:JoueurEvent):void {

			switch (jEvt.type) {

				case "SCROLLB":
					PlaylistSon.getSoundGroup().playMySound(0);
					_seqJoueur.push("myMusic1");
					break;

				case "SCROLLB_ESPACE":
					PlaylistSon.getSoundGroup().playMySound(1);
					_seqJoueur.push("myMusic2");
					break;

				case "SCROLLH":
					PlaylistSon.getSoundGroup().playMySound(2);
					_seqJoueur.push("myMusic3");
					break;

				case "SCROLLH_ESPACE":
					PlaylistSon.getSoundGroup().playMySound(3);
					_seqJoueur.push("myMusic4");
					break;
			}
			++_nbSonPlay;
			_checkSequence();
		}

		private function _checkSequence():void {

			var reussite:uint;
			for (var i:uint; i < _nbSonPlay + 1; ++i) {
				if (PlaylistSon.getPlaylist()[i][0] == _seqJoueur[i]) {
					++reussite;
				}
			}

			if (_nbSonPlay == _nbSon) {
				if (reussite == _nbSon) {
					this.dispatchEvent(new IAEvent(IAEvent.JOUEUR_COMPLETE));
				} else {
					this.dispatchEvent(new IAEvent(IAEvent.JOUEUR_FAIL));
				}
			}
		}
	}
}
