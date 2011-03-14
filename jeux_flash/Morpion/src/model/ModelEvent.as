package model {

	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class ModelEvent extends Event {
		
		static public const POSER_PION:String = "POSER_PION";
		
		public var indiceX:uint, indiceY:uint;

		public function ModelEvent(type:String, $indiceX:uint, $indiceY:uint, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			indiceX = $indiceX;
			indiceY = $indiceY;
			
			super(type, bubbles, cancelable);
		}
	}
}