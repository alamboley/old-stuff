package pages.ia {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class IAEvent extends Event {
		
		public static const MACHINE_COMPLETE:String = "MACHINE_COMPLETE";
		public static const JOUEUR_COMPLETE:String = "JOUEUR_COMPLETE";
		public static const JOUEUR_SEQUENCE_ECHEC:String = "JOUEUR_SEQUENCE_ECHEC";
		public static const JOUEUR_FAIL:String = "JOUEUR_FAIL";
		public static const JOUEUR_WIN:String = "JOUEUR_WIN";
		
		public static const SCORE_SEQUENCE_REUSSIE:String = "SCORE_SEQUENCE_REUSSIE";
		public static const SCORE_SON_REUSSI:String = "SCORE_SON_REUSSI";
		public static const SCORE_SON_ERREUR:String = "SCORE_SON_ERREUR";
		
		public var addScore:int;

		public function IAEvent(type:String, $addScore:int = 0, bubbles:Boolean = false, cancelable:Boolean = false) {
			addScore = $addScore;
			super(type, bubbles, cancelable);
		}
	}
}
