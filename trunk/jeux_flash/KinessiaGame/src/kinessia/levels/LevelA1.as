package kinessia.levels {

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class LevelA1 extends ALevel {

		public function LevelA1(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			_addMusicalSensor();
		}
		
		override public function destroy():void {
			
			super.destroy();
		}
	}
}
