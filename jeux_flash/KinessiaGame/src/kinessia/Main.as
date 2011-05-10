package kinessia {

	import kinessia.level.ALevel;
	import kinessia.level.LevelManager;

	import com.citrusengine.core.CitrusEngine;

	/**
	 * @author Aymeric
	 */
	public class Main extends CitrusEngine {

		private var _levelManager:LevelManager;

		public function Main() {

			super();

			this.console.addCommand("fullscreen", _fullscreen);
			this.console.addCommand("play", _playGame);

			_levelManager = new LevelManager();
			_levelManager.onLevelChanged.add(_onLevelChanged);
			state = _levelManager.currentLevel;
		}

		private function _onLevelChanged(lvl:ALevel):void {

			// state = _levelManager.currentLevel;
			state = lvl;
		}

		private function _fullscreen():void {
			stage.displayState = "fullScreen";
		}

		private function _playGame():void {
			this.playing = !this.playing;
		}
	}
}
