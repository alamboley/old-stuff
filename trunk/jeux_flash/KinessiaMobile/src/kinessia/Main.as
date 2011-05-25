package kinessia {

	import kinessia.network.Network;
	import kinessia.network.NetworkEvent;

	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.StatusEvent;
	import flash.events.TouchEvent;
	import flash.media.Microphone;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite {

		private var _network:Network;

		private var _coin:uint;

		public function Main() {

			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			_network = new Network();
			addChild(_network);
			// Network is a Sprite instead of an EventDispatcher because of the EnterFrame

			_network.addEventListener(NetworkEvent.START_MICRO, _micro);
			_network.addEventListener(NetworkEvent.STOP_MICRO, _micro);

			_network.addEventListener(NetworkEvent.COIN_TAKEN, _addCoin);

			stage.addEventListener(TouchEvent.TOUCH_TAP, _network.pauseGame);
		}

		private function _micro(nEvt:NetworkEvent):void {

			switch (nEvt.type) {

				case NetworkEvent.START_MICRO:

					trace(Microphone.isSupported);

					_network.removeEventListener(NetworkEvent.START_MICRO, _micro);

					var microphone:Microphone = Microphone.getMicrophone();

					
					break;
					
				case NetworkEvent.STOP_MICRO:
					
					_network.removeEventListener(NetworkEvent.STOP_MICRO, _micro);
					
					microphone = null;
					
					break;
			}


		}

		private function _addCoin(nEvt:NetworkEvent):void {
			++_coin;
			trace("coin : " + _coin);
		}
	}
}