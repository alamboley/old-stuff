package kinessia {

	import kinessia.levels.ALevel;
	import kinessia.levels.LevelManager;
	import kinessia.network.Network;

	import com.citrusengine.core.CitrusEngine;

	/**
	 * @author Aymeric
	 */
	public class Main extends CitrusEngine {

		private var _levelManager:LevelManager;
		private var _network:Network;

		public function Main() {

			super();
			
			_network = new Network();

			this.console.addCommand("fullscreen", _fullscreen);
			this.console.addCommand("play", _playGame);

			sound.addSound("KinessiaTheme", "sounds/KinessiaTheme.mp3");
			sound.addSound("Collect", "sounds/jump.mp3");
			sound.addSound("Hurt", "sounds/hurt.mp3");
			sound.addSound("Jump", "sounds/jump.mp3");
			sound.addSound("Kill", "sounds/kill.mp3");
			sound.addSound("Skid", "sounds/skid.mp3");
			sound.addSound("Walk", "sounds/jump.mp3");
			sound.addSound("Si", "sounds/si.mp3");
			sound.addSound("Do", "sounds/do.mp3");
			sound.addSound("Re", "sounds/re.mp3");
			sound.addSound("Mi", "sounds/mi.mp3");

			//sound.playSound("KinessiaTheme");

			_levelManager = new LevelManager();
			_levelManager.onLevelChanged.add(_onLevelChanged);
			state = _levelManager.currentLevel;
		}

		private function _onLevelChanged(lvl:ALevel):void {

			state = lvl;

			lvl.lvlEnded.add(_nextLevel);
			lvl.restartLevel.add(_restartLevel);
		}

		private function _restartLevel():void {
			state = _levelManager.currentLevel;
		}

		private function _nextLevel():void {

			_levelManager.nextLevel();
		}

		private function _fullscreen():void {
			stage.displayState = "fullScreen";
		}

		private function _playGame():void {
			this.playing = !this.playing;
		}
	}
}
