package kinessia.network {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class NetworkEvent extends Event {
		
		public static const PAUSE_GAME:String = "PAUSE_GAME";
		
		public static const COIN_TAKEN:String = "COIN_TAKEN";
		
		public static const START_MICRO:String = "START_MICRO";
		public static const STOP_MICRO:String = "STOP_MICRO";
		
		public static const START_PACMAN:String = "START_PACMAN";
		public static const END_PACMAN:String = "END_PACMAN";
		
		public static const START_CATAPULTE:String = "START_CATAPULTE";
		public static const END_CATAPULTE:String = "END_CATAPULTE";
		
		public static const JUMP:String = "JUMP";
		public static const ONGROUND:String = "ONGROUND";
		public static const STATIONARY:String = "STATIONARY";
		
		public static const LEFT:String = "LEFT";
		public static const RIGHT:String = "RIGHT";
		public static const IMMOBILE:String = "IMMOBILE";
		
		public static const FLY:String = "FLY";
		public static const NOT_FLY:String = "NOT_FLY";

		public function NetworkEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
