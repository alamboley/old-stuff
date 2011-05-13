package kinessia.levels {

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class LevelA4 extends ALevel {

		public function LevelA4(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			_addContactRestartLevel();
		}
	}
}
