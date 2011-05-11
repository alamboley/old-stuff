package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Declik;
	import kinessia.objects.MusicalSensor;

	import com.citrusengine.core.CitrusObject;

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
			
			var musicalSensors:Vector.<CitrusObject> = getObjectsByType(MusicalSensor);
			for each (var musicalSensor:MusicalSensor in musicalSensors) {
				musicalSensor.onBeginContact.add(_playSound);
			}
		}

		private function _playSound(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				_ce.sound.playSound(cEvt.fixture.GetBody().GetUserData().song, 1, 0);
			}
		}
	}
}
