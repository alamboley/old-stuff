package pages.event {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	 
	public class JeuEvent extends Event {
		
		public static const SCROLLH:String = "SCROLLH";
		public static const SCROLLB:String = "SCROLLB";
		public static const SCROLLH_ESPACE:String = "SCROLLH_ESPACE";
		public static const SCROLLB_ESPACE:String = "SCROLLB_ESPACE";

		public function JeuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
