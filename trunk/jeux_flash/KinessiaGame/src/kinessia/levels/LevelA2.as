package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Declik;
	import kinessia.network.NetworkEvent;

	import com.citrusengine.objects.platformer.Sensor;

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class LevelA2 extends ALevel {

		public function LevelA2(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}

		override public function initialize():void {

			super.initialize();
			
			_addContactRestartLevel();
			
			_addMusicalSensor();
			
			var microphoneSensor:Sensor = Sensor(getObjectByName("Microphone"));
			microphoneSensor.onBeginContact.add(_addMicrophone);
		}
		
		private function _addMicrophone(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				cEvt.fixture.GetBody().GetUserData().kill = true;
				
				_ce.dispatchEvent(new NetworkEvent(NetworkEvent.START_MICRO));
			}
		}
	}
}
