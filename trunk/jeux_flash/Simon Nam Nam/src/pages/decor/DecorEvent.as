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
		
		public static const SCORE_SEQUENCE_REUSSIE:String = "SCORE_SEQUENCE_REUSSIE";
		public static const SCORE_SEQUENCE_ECHEC:String = "SCORE_SEQUENCE_ECHEC";
		
		public var addScore:int;

		public function DecorEvent(type:String, $addScore:int = 0, bubbles:Boolean = false, cancelable:Boolean = false) {
			addScore = $addScore;
			super(type, bubbles, cancelable);
		}
	}
}
