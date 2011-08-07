﻿package defenseofaegir {

	import defenseofaegir.levels.ALevel;
	import defenseofaegir.levels.LevelManager;
	import defenseofaegir.utils.FPSMemCounter;

	import com.citrusengine.core.CitrusEngine;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="1000", height="650")]

	/**
	 * @author Aymeric
	 */
	public class Main extends CitrusEngine {

		private var _levelManager:LevelManager;

		public function Main() {

			super();
			
			FPSMemCounter.init(stage, this);

			_levelManager = new LevelManager();
			_levelManager.onLevelChanged.add(_onLevelChanged);
		}

		private function _onLevelChanged(lvl:ALevel):void {

			state = lvl;

			lvl.lvlEnded.add(_nextLevel);
		}

		private function _nextLevel():void {

			_levelManager.nextLevel();
		}
	}
}