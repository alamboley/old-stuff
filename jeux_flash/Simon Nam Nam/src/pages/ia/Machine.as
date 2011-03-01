package pages.ia {

	import pages.son.PlaylistSon;

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */

	public class Machine extends MovieClip {

		private const _MAX_SON:uint = PlaylistSon.getPlaylist().length;

		private var _timer:Timer;
		private var _posLecture:uint;
		private var _tailleSequence:uint;

		public function Machine() {

			_tailleSequence = 1;
		}

		public function definirSequence():void {

			_timer = new Timer(1500, _tailleSequence);

			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, _jouerSequence);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _finSequence);
		}

		private function _jouerSequence(tEvt:TimerEvent):void {

			if (_posLecture != _MAX_SON) {
				
				trace(PlaylistSon.getPlaylist()[_posLecture][0]);

				switch (PlaylistSon.getPlaylist()[_posLecture][0]) {

					case "myMusic1":
						PlaylistSon.getSoundGroup().playMySound(0);
						break;

					case "myMusic2":
						PlaylistSon.getSoundGroup().playMySound(1);
						break;

					case "myMusic3":
						PlaylistSon.getSoundGroup().playMySound(2);
						break;

					case "myMusic4":
						PlaylistSon.getSoundGroup().playMySound(3);
						break;
				}
				
				++_posLecture;

			} else {
				trace('tous les sons jouer');
			}
		}

		private function _finSequence(tEvt:TimerEvent):void {

			_posLecture = 0;
			_timer.removeEventListener(TimerEvent.TIMER, _jouerSequence);
			_timer = null;

			++_tailleSequence;
			definirSequence();
		}
	}
}
