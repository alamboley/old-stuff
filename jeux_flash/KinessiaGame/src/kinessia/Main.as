package kinessia {

	import com.citrusengine.core.CitrusEngine;
	import kinessia.levels.ALevel;
	import kinessia.levels.LevelManager;


	/**
	 * @author Aymeric
	 */
	public class Main extends CitrusEngine {
		
		private var _countLifes:uint;

		private var _levelManager:LevelManager;

		public function Main() {

			super();

			this.console.addCommand("fullscreen", _fullscreen);
			this.console.addCommand("play", _playGame);
			
			sound.addSound("Si", "sounds/si.mp3");
			sound.addSound("Do", "sounds/do.mp3");
			sound.addSound("Re", "sounds/re.mp3");
			sound.addSound("Mi", "sounds/mi.mp3");
			
			
			_countLifes = GameConst.nbrLifes;

			_levelManager = new LevelManager();
			_levelManager.onLevelChanged.add(_onLevelChanged);
			state = _levelManager.currentLevel;
		}

		private function _removeLife():void {
			
			--_countLifes;
			if (_countLifes == 0) {
				state = _levelManager.currentLevel;
			}
		}

		private function _onLevelChanged(lvl:ALevel):void {

			state = lvl;
			
			_countLifes = GameConst.nbrLifes;
			lvl.damageTaken.add(_removeLife);
			lvl.lvlEnded.add(_nextLevel);
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
