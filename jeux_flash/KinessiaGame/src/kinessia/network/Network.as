package kinessia.network {

	import net.user1.reactor.IClient;
	import net.user1.reactor.Reactor;
	import net.user1.reactor.ReactorEvent;
	import net.user1.reactor.Room;

	/**
	 * @author Aymeric
	 */
	public class Network {

		private var _reactor:Reactor;
		private var _room:Room;

		public function Network() {

			_reactor = new Reactor();

			_reactor.connect("localhost", 9110);

			_reactor.addEventListener(ReactorEvent.READY, _createRoom);
		}

		private function _createRoom(rEvt:ReactorEvent):void {

			_room = _reactor.getRoomManager().createRoom("Kinessia");
			_room.join();

			_room.addMessageListener("CHAT_MESSAGE", _chatMessageLisener);
		}

		private function _chatMessageLisener(fromClient:IClient, messageText:String):void {
			trace("Guest" + fromClient.getClientID() + " says: " + messageText);
		}
	}
}
