package pages.decor {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class DecorEvent extends Event {
		
		public static const BAFFLE:String = "BAFFLE";

		public function DecorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
