package afp.events {

	import flash.display.Loader;
	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class CameraEvent extends Event {
		
		static public const CAPTURED_PICTURE:String = "CAPTURED_PICTURE";
		
		public var picture:Loader;

		public function CameraEvent(type:String, image:Loader = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			
			picture = image;
		}
	}
}
