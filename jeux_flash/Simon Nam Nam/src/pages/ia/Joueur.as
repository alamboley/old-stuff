package pages.ia {

	import pages.decor.DecorEvent;
	import pages.ia.event.JoueurDispatcher;
	import pages.ia.event.JoueurEvent;
	import pages.son.PlaylistSon;

	import flash.display.MovieClip;
	import flash.display.Stage;

	/**
	 * @author Aymeric
	 */

	public class Joueur extends MovieClip {

		private const _NB_MAX_SEQUENCE:uint = PlaylistSon.getPlaylist().length;

		private var _stage:Stage;
		private var _seqJoueur:Array;
		private var _nbSon:uint, _nbSonPlay:uint;

		private var _fini:Boolean;

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
					PlaylistSon.getMySound("myMusic1").play();
					_seqJoueur.push("myMusic1");
					this.dispatchEvent(new DecorEvent(DecorEvent.DISQUE_BAS));
					break;

				case "SCROLLB_ESPACE":
					PlaylistSon.getMySound("myMusic2").play();
					_seqJoueur.push("myMusic2");
					this.dispatchEvent(new DecorEvent(DecorEvent.FADER_SCRASH_BAS));
					break;

				case "SCROLLH":
					PlaylistSon.getMySound("myMusic3").play();
					_seqJoueur.push("myMusic3");
					this.dispatchEvent(new DecorEvent(DecorEvent.DISQUE_HAUT));
					break;

				case "SCROLLH_ESPACE":
					PlaylistSon.getMySound("myMusic4").play();
					_seqJoueur.push("myMusic4");
					this.dispatchEvent(new DecorEvent(DecorEvent.FADER_SCRASH_HAUT));
					break;
			}
			++_nbSonPlay;
			_checkSequence();
		}

		private function _checkSequence():void {

			if (_fini == false) {

				var reussite:uint;
				for (var i:uint; i < _nbSonPlay; ++i) {
					if (PlaylistSon.getPlaylist()[i][0] == _seqJoueur[i]) {
						++reussite;
					}
				}

				if (_nbSonPlay == _nbSon) {

					if (reussite == _NB_MAX_SEQUENCE) {
						this.dispatchEvent(new IAEvent(IAEvent.JOUEUR_WIN));
						_fini = true;
					} else if (reussite == _nbSon) {
						this.dispatchEvent(new IAEvent(IAEvent.JOUEUR_COMPLETE));
						this.dispatchEvent(new DecorEvent(DecorEvent.SCORE_SEQUENCE_REUSSIE, 10));
					} else {
						this.dispatchEvent(new IAEvent(IAEvent.JOUEUR_FAIL));
						_fini = true;
					}
				}
			}
		}
	}
}
