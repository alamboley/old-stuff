package kinessia.level {

	import org.osflash.signals.Signal;

	/**
	 * @author Aymeric
	 */
	public class LevelManager {
		
		public var onLevelChanged:Signal;

		private var _levels:Array = [LevelA1, LevelA2, LevelA3];
		private var _currentIndex:uint;
		private var _currentLevel:ALevel;

		public function LevelManager() {
			
			onLevelChanged = new Signal(ALevel);
			_currentIndex = 0;
			gotoLevel();
		}
		

		public function destroy():void {
			onLevelChanged.removeAll();
		}

		public function nextLevel():void {
			
			if (_currentIndex < _levels.length - 1)
				++_currentIndex;

			gotoLevel();
		}

		public function prevLevel():void {
			
			if (_currentIndex > 0)
				--_currentIndex;

			gotoLevel();
		}

		public function gotoLevel():void {
			
			if (_currentLevel != null)
				_currentLevel.lvlEnded.remove(_onLevelEnded);
				
			_currentLevel = ALevel(new _levels[_currentIndex]());
			_currentLevel.lvlEnded.add(_onLevelEnded);
			onLevelChanged.dispatch(currentLevel);
		}

		private function _onLevelEnded():void {
			
		}


		public function get currentLevel():ALevel {
			return _currentLevel;
		}

		public function set currentLevel(currentLevel:ALevel):void {
			_currentLevel = currentLevel;
		}
	}
}
