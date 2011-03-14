package model {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class ModelEvent extends Event {
		
		static public const POSER_PION:String = "POSER_PION";
		
		public var posX:uint, posY:uint;

		public function ModelEvent(type:String, $posX:uint, $posY:uint, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			posX = $posX;
			posY = $posY;
			
			super(type, bubbles, cancelable);
		}
	}
}
