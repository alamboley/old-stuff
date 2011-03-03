package pages.ia {

	import pages.decor.DecorEvent;
	import pages.ia.event.JoueurDispatcher;
	import pages.ia.event.JoueurEvent;
	import pages.son.PlaylistSon;

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */

	public class Joueur extends MovieClip {

		private const _NB_MAX_SEQUENCE:uint = PlaylistSon.getPlaylist().length;
		
		private var _nbVie:int;

		private var _stage:Stage;
		private var _seqJoueur:Array;
		private var _nbSon:uint, _nbSonPlay:uint;
		
		private var _timerScore:Timer;

		private var _fini:Boolean;

		public function Joueur($stage:Stage) {

			_stage = $stage;
			_nbVie = 4;

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
				
				if (PlaylistSon.getPlaylist()[_nbSonPlay - 1][0] == _seqJoueur[_nbSonPlay - 1]) {
					this.dispatchEvent(new IAEvent(IAEvent.SCORE_SON_REUSSI, 10));
				} else {
					--_nbVie;
					trace(_nbVie);
					this.dispatchEvent(new IAEvent(IAEvent.SCORE_SON_ERREUR, -100));
				}

				if (_nbSonPlay == _nbSon) {

					if (reussite == _NB_MAX_SEQUENCE) {
						
						this.dispatchEvent(new IAEvent(IAEvent.JOUEUR_WIN));
						_fini = true;
						
					} else if (reussite == _nbSon) {
						
						this.dispatchEvent(new IAEvent(IAEvent.JOUEUR_COMPLETE));
						
						_timerScore = new Timer(400, 1);
						_timerScore.addEventListener(TimerEvent.TIMER_COMPLETE, _timerComplete);
						
						_timerScore.start();
											
					} else {
						
						if (_nbVie <= 0) {
							this.dispatchEvent(new IAEvent(IAEvent.JOUEUR_FAIL));
							_fini = true;
						} else {
							this.dispatchEvent(new IAEvent(IAEvent.JOUEUR_SEQUENCE_ECHEC));
						}
					}
				}
			}
		}

		private function _timerComplete(tEvt:TimerEvent):void {
			
			_timerScore.removeEventListener(TimerEvent.TIMER_COMPLETE, _timerComplete);
			_timerScore = null;
			
			this.dispatchEvent(new IAEvent(IAEvent.SCORE_SEQUENCE_REUSSIE, 50));
		}
	}
}
