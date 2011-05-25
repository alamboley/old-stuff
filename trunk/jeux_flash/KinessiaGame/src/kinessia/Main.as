package kinessia {

	import kinessia.levels.ALevel;
	import kinessia.levels.LevelManager;
	import kinessia.network.Network;
	import kinessia.network.NetworkEvent;
	import kinessia.pacman.Pacman;

	import com.citrusengine.core.CitrusEngine;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author Aymeric
	 */
	public class Main extends CitrusEngine {

		private var _levelManager:LevelManager;
		private var _network:Network;
		
		private var _pacman:Pacman;

		public function Main() {

			super();
			
			//_network = new Network();
			this.addEventListener(NetworkEvent.PAUSE_GAME, _pauseGame);
			
			this.addEventListener(NetworkEvent.START_PACMAN, _pacmanGame);
			stage.addEventListener(NetworkEvent.END_PACMAN, _pacmanGame);

			this.console.addCommand("fullscreen", _fullscreen);
			this.console.addCommand("pause", _pauseGame);

			sound.addSound("KinessiaTheme", "sounds/KinessiaTheme.mp3");
			sound.addSound("Collect", "sounds/collect.mp3");
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
			
			var loader:Loader = new Loader();
			loader.load(new URLRequest("images/logo.png"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _addLogo);
		}

		private function _addLogo(evt:Event):void {
			
			addChild(evt.target.loader.content);
			
			evt.target.removeEventListener(Event.COMPLETE, _addLogo);
			evt.target.loader.unloadAndStop();
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
		
		private function _pacmanGame(nEvt:NetworkEvent):void {
			
			if (nEvt.type == NetworkEvent.START_PACMAN) {
			
				this.removeEventListener(NetworkEvent.START_PACMAN, _pacmanGame);
				
				_pacman = new Pacman();
				addChild(_pacman);
				_pacman.x = 350;
				_pacman.y = 300;
				
			} else {
				
				this.removeEventListener(NetworkEvent.END_PACMAN, _pacmanGame);
				
				_pacman.destroy();
				removeChild(_pacman);
				_pacman = null;
			}
		}

		private function _fullscreen():void {
			stage.displayState = "fullScreen";
		}

		private function _pauseGame(nEvt:NetworkEvent = null):void {
			this.playing = !this.playing;
		}
	}
}
