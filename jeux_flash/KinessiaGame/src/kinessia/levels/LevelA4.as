package kinessia.levels {

	import com.citrusengine.objects.platformer.Sensor;

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
			
			var restartLevel:Sensor = Sensor(getObjectByName("RestartLevel"));
			restartLevel.onBeginContact.add(_restartLevel);
		}
	}
}
