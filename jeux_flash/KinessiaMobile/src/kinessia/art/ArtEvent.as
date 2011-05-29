package kinessia.art {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class ArtEvent extends Event {
		
		public static const REMOVE_HOME:String = "REMOVE_HOME";

		public function ArtEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
