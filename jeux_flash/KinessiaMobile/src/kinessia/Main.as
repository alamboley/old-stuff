package kinessia {

	import kinessia.network.Network;

	import flash.display.Sprite;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite {
		
		private var _network:Network;

		public function Main() {
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_network = new Network();
			addChild(_network); //Network is a Sprite instead of an EventDispatcher because of the EnterFrame
		}
	}
}