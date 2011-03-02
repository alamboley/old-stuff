package pages.decor {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class DecorEvent extends Event {
		
		public static const BAFFLE:String = "BAFFLE";
		
		public static const DISQUE_BAS:String = "DISQUE_BAS";
		public static const DISQUE_HAUT:String = "DISQUE_HAUT";
		public static const FADER_SCRASH_BAS:String = "FADER_SCRASH_BAS";
		public static const FADER_SCRASH_HAUT:String = "FADER_SCRASH_HAUT";

		public function DecorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
