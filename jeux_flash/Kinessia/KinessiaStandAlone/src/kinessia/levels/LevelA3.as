package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Declik;
	import kinessia.events.KinessiaEvent;

	import com.citrusengine.objects.platformer.Sensor;

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class LevelA3 extends ALevel {
		
		private var _pacmanSensor:Sensor;

		public function LevelA3(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}

		override public function initialize():void {

			super.initialize();

			_addContactRestartLevel();

			_pacmanSensor = Sensor(getObjectByName("Pacman"));
			_pacmanSensor.onBeginContact.addOnce(_addPacman);
			
			stage.addEventListener(KinessiaEvent.END_PACMAN, _endPacman);
		}
		
		override public function destroy():void {
			
			super.destroy();
		}

		private function _addPacman(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_hud.putText(3);
				_hud.information.visible = true;

				cEvt.fixture.GetBody().GetUserData().kill = true;

				_declik.controlsEnabled = false;
				_declik.visible = false;
				
				_ce.dispatchEvent(new KinessiaEvent(KinessiaEvent.START_PACMAN));
			}
		}

		private function _endPacman(kEvt:KinessiaEvent):void {
			
			_declik.controlsEnabled = true;
			_declik.visible = true;
			
			_hud.information.visible = false;
		}
	}
}
