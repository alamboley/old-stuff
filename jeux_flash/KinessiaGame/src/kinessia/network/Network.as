package kinessia.network {

	import net.user1.reactor.IClient;
	import net.user1.reactor.Reactor;
	import net.user1.reactor.ReactorEvent;
	import net.user1.reactor.Room;

	import com.citrusengine.core.CitrusEngine;

	import flash.events.EventDispatcher;

	/**
	 * @author Aymeric
	 */
	public class Network extends EventDispatcher {
		
		private var _ce:CitrusEngine;
		private var _reactor:Reactor;
		private var _room:Room;
		
		private var _uniqueID:String;
		
		private var _tabMessageFromIphone:Array;
		private var _lengthTab:uint;

		public function Network() {
			
			_ce = CitrusEngine.getInstance();
			
			_uniqueID = "1234567"; //_generateRandomString(7);

			_reactor = new Reactor();

			_reactor.connect("localhost", 9110);
			//_reactor.connect("tryunion.com", 80);
			

			_tabMessageFromIphone = [];
			_tabMessageFromIphone = [NetworkEvent.PAUSE_GAME, NetworkEvent.JUMP, NetworkEvent.ONGROUND, NetworkEvent.STATIONARY, NetworkEvent.RIGHT, NetworkEvent.LEFT, NetworkEvent.IMMOBILE, NetworkEvent.CIRCLE_DRAW];
			_lengthTab = _tabMessageFromIphone.length;

			_reactor.addEventListener(ReactorEvent.READY, _createRoom);
		}
		
		private function _generateRandomString(newLength:uint = 1, userAlphabet:String = "123456789"):String{
			
				var alphabet:Array = userAlphabet.split("");
				var alphabetLength:int = alphabet.length;
				var randomLetters:String = "";
				for (var i:uint = 0; i < newLength; i++){
					randomLetters += alphabet[int(Math.floor(Math.random() * alphabetLength))];
				}
				return randomLetters;
			}

		private function _createRoom(rEvt:ReactorEvent):void {
			
			_reactor.removeEventListener(ReactorEvent.READY, _createRoom);

			_room = _reactor.getRoomManager().createRoom("Kinessia");
			_room.join();

			_room.addMessageListener(_uniqueID, _messageFromIphone);
			
			_ce.addEventListener(NetworkEvent.START_MICRO, _messageToIphone);
			_ce.addEventListener(NetworkEvent.STOP_MICRO, _messageToIphone);
			
			_ce.addEventListener(NetworkEvent.START_PACMAN, _messageToIphone);
			_ce.addEventListener(NetworkEvent.END_PACMAN, _messageToIphone);
			
			_ce.addEventListener(NetworkEvent.START_CATAPULTE, _messageToIphone);
			_ce.addEventListener(NetworkEvent.END_CATAPULTE, _messageToIphone);
			
			_ce.addEventListener(NetworkEvent.COIN_TAKEN, _messageToIphone);
		}

		private function _messageToIphone(nEvt:NetworkEvent):void {
			
			trace("Jeu envoit :" + nEvt.type);
			
			_room.sendMessage(_uniqueID, true, null, nEvt.type);
			
			
			switch (nEvt.type) {
				
				case NetworkEvent.START_MICRO:
					_ce.removeEventListener(NetworkEvent.START_MICRO, _messageToIphone);		
					break;
					
				case NetworkEvent.STOP_MICRO:
					_ce.removeEventListener(NetworkEvent.STOP_MICRO, _messageToIphone);
					break;
					
				case NetworkEvent.START_PACMAN:
					_ce.removeEventListener(NetworkEvent.START_PACMAN, _messageToIphone);
					break;
					
				case NetworkEvent.END_PACMAN:
					_ce.removeEventListener(NetworkEvent.END_PACMAN, _messageToIphone);
					break;
					
				case NetworkEvent.START_CATAPULTE:
					_ce.removeEventListener(NetworkEvent.START_CATAPULTE, _messageToIphone);
					break;
					
				case NetworkEvent.END_CATAPULTE:
					_ce.removeEventListener(NetworkEvent.END_CATAPULTE, _messageToIphone);
					break;
			}
			
		}

		private function _messageFromIphone(fromClient:IClient, message:String):void {
			
			if (_checkMessageFromIphone(message)) {
				trace("provient de l'iphone : " + message);
				_ce.dispatchEvent(new NetworkEvent(message));
			}
		}
		
		private function _checkMessageFromIphone(message:String):Boolean {
			
			for (var i:uint = 0; i < _lengthTab; ++i) {
				
				if (message == _tabMessageFromIphone[i])
					return true;
			}
			
			return false;
		}

		public function get uniqueID():String {
			return _uniqueID;
		}
	}
}
