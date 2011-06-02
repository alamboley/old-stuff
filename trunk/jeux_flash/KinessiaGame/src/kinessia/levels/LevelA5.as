package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Declik;
	import kinessia.effects.DrawCircle;
	import kinessia.network.NetworkEvent;
	import kinessia.objects.Catapulte;
	import kinessia.objects.Circle;
	import kinessia.objects.Croquis;
	import kinessia.objects.Piece;

	import com.citrusengine.objects.platformer.Platform;

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */
	public class LevelA5 extends ALevel {
		
		private var _catapulte:Catapulte;
		private var _circle:Circle;
		
		private var _croquis1:Croquis;
		private var _croquis2:Croquis;
		
		private var _piece:Piece;

		public function LevelA5(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}

		override public function initialize():void {

			super.initialize();

			_addContactRestartLevel();

			_catapulte = Catapulte(getFirstObjectByType(Catapulte));
			_catapulte.initJoint(Platform(getObjectByName("PlatformJoint")));
			_catapulte.know(_declik);
			_catapulte.onBeginContact.add(_hitCatapulte);
			
			_croquis1 = Croquis(getObjectByName("Croquis1"));
			_croquis2 = Croquis(getObjectByName("Croquis2"));

			_piece = Piece(getFirstObjectByType(Piece));
			_piece.onBeginContact.add(_pieceTaken);
			
			_ce.addEventListener(NetworkEvent.CIRCLE_DRAW, _circleDraw);

			// var walker:TheWalker = new TheWalker("theWalker", {x:50});
			// add(walker);
		}
		
		override public function destroy():void {
			
			super.destroy();
		}

		private function _hitCatapulte(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_catapulte.onBeginContact.remove(_hitCatapulte);

				_ce.dispatchEvent(new NetworkEvent(NetworkEvent.START_CATAPULTE));
				
				_croquis1.anim = _croquis2.anim = "white";
			}
		}

		private function _circleDraw(nEvt:NetworkEvent):void {
			
			_ce.removeEventListener(NetworkEvent.CIRCLE_DRAW, _circleDraw);
			
			_circle = new Circle("Circle", {view:DrawCircle, x:450, y:50, radius:15});
			add(_circle);
			_circle.gravity = 0;

			var timer:Timer = new Timer(200, 1);
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
				
				_croquis1.anim = _croquis2.anim = "black";

				_ce.dispatchEvent(new NetworkEvent(NetworkEvent.END_CATAPULTE));
			}
		}
	}
}
