package kinessia {

	import kinessia.levels.ALevel;
	import kinessia.levels.LevelManager;
	import kinessia.pacman.Pacman;

	import com.citrusengine.core.CitrusEngine;

	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	/**
	 * @author Aymeric
	 */
	public class Main extends CitrusEngine {

		private var _levelManager:LevelManager;

		private var _pacman:Pacman;

		private var _soundOn:Boolean;

		public function Main() {

			super();

			this.addEventListener(Event.ADDED_TO_STAGE, _init);
		}

		private function _init(evt:Event):void {

			this.removeEventListener(Event.ADDED_TO_STAGE, _init);

			this.console.addCommand("fullscreen", _fullscreen);
			this.console.addCommand("pause", _pauseGame);
			this.console.addCommand("sound", _soundGame);
			this.console.addCommand("reset", _restartLevel);
			this.console.addCommand("next", _nextLevel);
			this.console.addCommand("goto", _goto);

			sound.addSound("KinessiaTheme", "sounds/KinessiaTheme.mp3");
			sound.addSound("Collect", "sounds/collect.mp3");
			sound.addSound("Hurt", "sounds/hurt.mp3");
			sound.addSound("Jump", "sounds/jump.mp3");
			sound.addSound("Kill", "sounds/kill.mp3");
			sound.addSound("Si", "sounds/si.mp3");
			sound.addSound("Do", "sounds/do.mp3");
			sound.addSound("Re", "sounds/re.mp3");
			sound.addSound("Mi", "sounds/mi.mp3");

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
		
		private function _goto($level:uint):void {

			_levelManager.gotoLevel($level);
		}

		private function _pacmanGame($play:Boolean):void {

			if ($play) {

				_pacman = new Pacman();
				addChild(_pacman);
				_pacman.x = 350;
				_pacman.y = 300;

			} else {

				_pacman.destroy();
				removeChild(_pacman);
				_pacman = null;
			}
		}

		private function _fullscreen():void {

			if (stage.displayState == "normal") {
				stage.displayState = "fullScreen";
			} else {
				stage.displayState = "normal";
			}
		}

		private function _pauseGame():void {
			this.playing = !this.playing;
		}

		private function _soundGame():void {

			var st:SoundTransform = SoundMixer.soundTransform;

			if (_soundOn) {
				st.volume = 1;
			} else {
				st.volume = 0;
			}

			SoundMixer.soundTransform = st;
			_soundOn = !_soundOn;
		}
	}
}
