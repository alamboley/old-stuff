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

		public function Network() {
			
			_ce = CitrusEngine.getInstance();

			_reactor = new Reactor();

			_reactor.connect("localhost", 9110);

			_reactor.addEventListener(ReactorEvent.READY, _createRoom);
		}

		private function _createRoom(rEvt:ReactorEvent):void {

			_room = _reactor.getRoomManager().createRoom("Kinessia");
			_room.join();

			_room.addMessageListener("CHAT_MESSAGE", _chatMessageLisener);
		}

		private function _chatMessageLisener(fromClient:IClient, message:String):void {
			trace("Guest" + fromClient.getClientID() + " says: " + message);
			
			switch (message) {
				
				case "jump":
					_ce.dispatchEvent(new NetworkEvent(NetworkEvent.JUMP));
					break;
					
				case "onground":
					_ce.dispatchEvent(new NetworkEvent(NetworkEvent.ONGROUND));
					
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
	}
}
