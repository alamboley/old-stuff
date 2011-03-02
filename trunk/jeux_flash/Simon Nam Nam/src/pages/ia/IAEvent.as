package pages.ia {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class IAEvent extends Event {
		
		public static const MACHINE_COMPLETE:String = "MACHINE_COMPLETE";
		public static const JOUEUR_COMPLETE:String = "JOUEUR_COMPLETE";
		public static const JOUEUR_FAIL:String = "JOUEUR_FAIL";
		public static const JOUEUR_WIN:String = "JOUEUR_WIN";

		public function IAEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
