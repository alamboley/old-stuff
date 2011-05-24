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

		public function Network() {
			
			_ce = CitrusEngine.getInstance();
			
			_uniqueID = "CHAT_MESSAGE"; //_generateRandomString(7);

			_reactor = new Reactor();

			_reactor.connect("localhost", 9110);
			//_reactor.connect("tryunion.com", 80);

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

			_room = _reactor.getRoomManager().createRoom("Kinessia");
			_room.join();

			_room.addMessageListener(_uniqueID, _messageFromIphone);
			
			_ce.addEventListener(NetworkEvent.START_MICRO, _messageToIphone);
			_ce.addEventListener(NetworkEvent.COIN_TAKEN, _messageToIphone);
		}

		private function _messageToIphone(nEvt:NetworkEvent):void {
			
			switch (nEvt.type) {
				
				case NetworkEvent.START_MICRO:
					_room.sendMessage(_uniqueID, true, null, "startMicro");					
					break;
					
				case NetworkEvent.COIN_TAKEN:
					_room.sendMessage(_uniqueID, true, null, "coinTaken");
					break;
			}
			
			
		}

		private function _messageFromIphone(fromClient:IClient, message:String):void {
			
			trace(message);
			
			switch (message) {
				
				case "pauseGame":
					_ce.dispatchEvent(new NetworkEvent(NetworkEvent.PAUSE_GAME));
					break;
				
				case "jump":
					_ce.dispatchEvent(new NetworkEvent(NetworkEvent.JUMP));
					break;
					
				case "onground":
					_ce.dispatchEvent(new NetworkEvent(NetworkEvent.ONGROUND));
					break;
					
				case "left":
					_ce.dispatchEvent(new NetworkEvent(NetworkEvent.LEFT));
					break;
					
				case "right":
					_ce.dispatchEvent(new NetworkEvent(NetworkEvent.RIGHT));
					break;
					
				case "immobile":
					_ce.dispatchEvent(new NetworkEvent(NetworkEvent.IMMOBILE));
					break;
			}
		}

		public function get uniqueID():String {
			return _uniqueID;
		}
	}
}
