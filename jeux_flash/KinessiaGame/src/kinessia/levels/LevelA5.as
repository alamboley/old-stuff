package kinessia.levels {

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import com.citrusengine.objects.platformer.Crate;

	import kinessia.effects.DrawCircle;

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Declik;
	import kinessia.network.NetworkEvent;
	import kinessia.objects.BodyPlatform;
	import kinessia.objects.Catapulte;
	import kinessia.objects.Piece;

	import com.citrusengine.objects.PhysicsObject;

	import flash.display.MovieClip;
	import flash.utils.setTimeout;

	/**
	 * @author Aymeric
	 */
	public class LevelA5 extends ALevel {

		private var _circle:PhysicsObject;

		public function LevelA5(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}

		override public function initialize():void {

			super.initialize();

			_addContactRestartLevel();

			var catapulte:Catapulte = Catapulte(getFirstObjectByType(Catapulte));
			catapulte.initJoint(BodyPlatform(getObjectByName("PlatformJoint")));
			catapulte.onBeginContact.add(_hitCatapulte);

			var piece:Piece = Piece(getFirstObjectByType(Piece));
			piece.onBeginContact.add(_pieceTaken);

			// var walker:TheWalker = new TheWalker("theWalker", {x:50});
			// add(walker);
		}

		private function _hitCatapulte(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {

				_ce.dispatchEvent(new NetworkEvent(NetworkEvent.START_CATAPULTE));

				var timer:Timer = new Timer(100, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, _createCircle);
				timer.start();
			}
		}

		private function _createCircle(tEvt:TimerEvent):void {
			
			tEvt.target.stop();
			tEvt.target.removeEventListener(TimerEvent.TIMER_COMPLETE, _createCircle);

			_circle = new PhysicsObject("Circle", {view:DrawCircle, x:450, y:50});
			add(_circle);
			_circle.gravity = 0;

			var timer:Timer = new Timer(250, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, _circleFall);
			timer.start();
		}

		private function _circleFall(tEvt:TimerEvent):void {
			
			_circle.gravity = 1.6;
			
			tEvt.target.stop();
			tEvt.target.removeEventListener(TimerEvent.TIMER_COMPLETE, _circleFall);			
		}

		private function _pieceTaken(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {

				_declik.velocityCatapulte = null;

				_ce.dispatchEvent(new NetworkEvent(NetworkEvent.END_CATAPULTE));
			}
		}
	}
}
