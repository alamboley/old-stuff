package pages.ia.event {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	 
	public class JoueurEvent extends Event {
		
		public static const SCROLLH:String = "SCROLLH";
		public static const SCROLLB:String = "SCROLLB";
		public static const SCROLLH_ESPACE:String = "SCROLLH_ESPACE";
		public static const SCROLLB_ESPACE:String = "SCROLLB_ESPACE";

		public function JoueurEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
