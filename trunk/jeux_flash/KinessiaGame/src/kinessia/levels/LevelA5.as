package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Declik;
	import kinessia.network.NetworkEvent;
	import kinessia.objects.BodyPlatform;
	import kinessia.objects.Catapulte;
	import kinessia.objects.Piece;

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class LevelA5 extends ALevel {

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
			
			//var walker:TheWalker = new TheWalker("theWalker", {x:50});
			//add(walker);
		}
		
		private function _hitCatapulte(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_ce.dispatchEvent(new NetworkEvent(NetworkEvent.START_CATAPULTE));
			}
		}
		
		private function _pieceTaken(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_declik.velocityCatapulte = null;
				
				_ce.dispatchEvent(new NetworkEvent(NetworkEvent.END_CATAPULTE));
			}
		}
	}
}
