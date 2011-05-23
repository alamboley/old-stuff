package kinessia.network {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class NetworkEvent extends Event {
		
		public static const ADD_COIN:String = "ADD_COIN";
		
		public static const START_MICRO:String = "START_MICRO";

		public function NetworkEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
