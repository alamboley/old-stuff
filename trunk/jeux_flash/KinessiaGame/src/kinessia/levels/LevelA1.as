package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Conservateur;
	import kinessia.characters.Declik;
	import kinessia.network.NetworkEvent;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class LevelA1 extends ALevel {

		private var _conservateur:Conservateur;

		public function LevelA1(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}

		override public function initialize():void {

			super.initialize();

			_addMusicalSensor();

			_conservateur = Conservateur(getFirstObjectByType(Conservateur));
			_conservateur.onBeginContact.addOnce(_talk);

			_ce.addEventListener(NetworkEvent.SKIP, _skip);
		}

		private function _talk(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_ce.dispatchEvent(new NetworkEvent(NetworkEvent.TALK));
				
				_conservateur.anim = "talk";
				_ce.sound.playSound("Conservateur", 1, 0);
				_ce.sound.getSoundChannel("Conservateur").addEventListener(Event.SOUND_COMPLETE, _soundComplete);
				_declik.controlsEnabled = false;
			}
		}

		private function _soundComplete(evt:Event):void {

			_ce.dispatchEvent(new NetworkEvent(NetworkEvent.SKIP));
		}

		private function _skip(nEvt:NetworkEvent):void {

			_ce.removeEventListener(NetworkEvent.SKIP, _skip);

			if (_ce.sound.currPlayingSounds["Conservateur"] != undefined) {

				_ce.sound.playSound("KinessiaTheme");

				_ce.sound.stopSound("Conservateur");
				_conservateur.anim = "idle";
				_ce.sound.getSoundChannel("Conservateur").removeEventListener(Event.SOUND_COMPLETE, _soundComplete);
				_declik.controlsEnabled = true;
			}
		}

		override public function destroy():void {

			super.destroy();
		}
	}
}
