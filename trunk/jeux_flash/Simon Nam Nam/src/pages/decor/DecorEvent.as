package pages.decor {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class DecorEvent extends Event {
		
		public static const BAFFLE:String = "BAFFLE";
		
		public static const ENCEINTE_ONDE:String = "ENCEINTE_ONDE";
		
		public static const ENREGISTRER_SCORE:String = "ENREGISTRER_SCORE";
		
		public static const MACHINE_INIT:String = "MACHINE_INIT";
		public static const MACHINE_SON1:String = "MACHINE_SON1";
		public static const MACHINE_SON2:String = "MACHINE_SON2";
		public static const MACHINE_SON3:String = "MACHINE_SON3";
		public static const MACHINE_SON4:String = "MACHINE_SON4";
		public static const MACHINE_A_TOI:String = "MACHINE_A_TOI";
		
		public static const DISQUE_BAS:String = "DISQUE_BAS";
		public static const DISQUE_HAUT:String = "DISQUE_HAUT";
		public static const FADER_SCRASH_BAS:String = "FADER_SCRASH_BAS";
		public static const FADER_SCRASH_HAUT:String = "FADER_SCRASH_HAUT";

		public function DecorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
