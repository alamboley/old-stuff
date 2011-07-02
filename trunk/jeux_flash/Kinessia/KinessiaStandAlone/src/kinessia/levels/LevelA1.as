package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Conservateur;
	import kinessia.characters.Declik;

	import flash.display.MovieClip;

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
			
			_ce.sound.playSound("KinessiaTheme");

			_conservateur = Conservateur(getFirstObjectByType(Conservateur));
			_conservateur.onBeginContact.addOnce(_talk);
			_conservateur.onEndContact.addOnce(_notTalk);
			_conservateur.anim = "idle";
		}

		private function _talk(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {
				_conservateur.anim = "talk";
			}
		}
		
		private function _notTalk(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				_conservateur.anim = "idle";
			}
		}

		override public function destroy():void {

			super.destroy();
		}
	}
}
