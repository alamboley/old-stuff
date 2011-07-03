package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Declik;
	import kinessia.characters.TheWalker;
	import kinessia.events.KinessiaEvent;
	import kinessia.gesture.Gesture;
	import kinessia.objects.Catapulte;
	import kinessia.objects.Croquis;
	import kinessia.objects.Piece;

	import com.citrusengine.objects.platformer.Platform;
	import com.citrusengine.objects.platformer.Sensor;

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class LevelA5 extends ALevel {
		
		private var _gesture:Gesture;
		
		private var _catapulte:Catapulte;
		
		private var _startCatapulte:Sensor;
		private var _croquis1:Croquis, _croquis2:Croquis;
		
		private var _piece:Piece;
		
		private var _startWalker:Sensor;
		private var _walker:TheWalker;

		public function LevelA5(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}

		override public function initialize():void {

			super.initialize();

			_addContactRestartLevel();

			_catapulte = Catapulte(getFirstObjectByType(Catapulte));
			_catapulte.initJoint(Platform(getObjectByName("PlatformJoint")));
			_catapulte.know(_declik);
			
			_startCatapulte = Sensor(getObjectByName("StartCatapulte"));
			_startCatapulte.onBeginContact.addOnce(_catapulteReady);
			_startCatapulte.onBeginContact.add(_showText);
			_startCatapulte.onEndContact.add(_hideText);
			
			_croquis1 = Croquis(getObjectByName("Croquis1"));
			_croquis2 = Croquis(getObjectByName("Croquis2"));

			_piece = Piece(getFirstObjectByType(Piece));
			_piece.onBeginContact.add(_pieceTaken);
			
			_startWalker = Sensor(getObjectByName("StartWalker"));
			_startWalker.onBeginContact.add(_awakeWalker);
			
			_walker = TheWalker(getFirstObjectByType(TheWalker));
		}
		
		override public function destroy():void {
			
			super.destroy();
		}
		
		override protected function _endLevel(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is TheWalker) {
				//lvlEnded.dispatch();
				
				_ce.playing = false;
			}
		}
		
		private function _showText(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_hud.putText(4);
				_hud.information.visible = true;
			}
		}
		
		private function _hideText(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_hud.information.visible = false;
			}
		}
		
		private function _catapulteReady(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_croquis1.anim = _croquis2.anim = "white";
				
				_gesture = new Gesture();
				addChild(_gesture);
				_gesture.addEventListener(KinessiaEvent.CIRCLE_IDENTIFIED, _catapulte.shot);
			}
		}

		private function _pieceTaken(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {

				_declik.velocityCatapulte = null;
				
				_croquis1.anim = _croquis2.anim = "black";
				
				_gesture.destroy();
				_gesture.removeEventListener(KinessiaEvent.CIRCLE_IDENTIFIED, _catapulte.shot);
				removeChild(_gesture);
				_gesture = null;
			}
		}
		
		private function _awakeWalker(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				_startWalker.kill = true;
				_walker.awake = true;
			}
		}
	}
}
