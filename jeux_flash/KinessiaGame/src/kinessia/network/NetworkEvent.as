package kinessia.network {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class NetworkEvent extends Event {
		
		public static const PAUSE_GAME:String = "PAUSE_GAME";
		
		public static const START_MICRO:String = "START_MICRO";
		
		public static const JUMP:String = "JUMP";
		public static const ONGROUND:String = "ONGROUND";
		public static const LEFT:String = "LEFT";
		public static const RIGHT:String = "RIGHT";
		public static const IMMOBILE:String = "IMMOBILE";

		public function NetworkEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
