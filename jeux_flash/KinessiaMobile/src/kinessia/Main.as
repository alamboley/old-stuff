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

		public function Main() {

			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			_network = new Network();
			addChild(_network);
			// Network is a Sprite instead of an EventDispatcher because of the EnterFrame

			_network.addEventListener(NetworkEvent.START_MICRO, _startMicro);

			stage.addEventListener(TouchEvent.TOUCH_TAP, _network.pauseGame);
		}

		private function _startMicro(nEvt:NetworkEvent):void {
			
			trace(Microphone.isSupported);
			
			var microphone:Microphone = Microphone.getMicrophone();

			microphone.gain = 100;
			microphone.rate = 100;
			
			microphone.setLoopBack();

			microphone.setUseEchoSuppression(true);
			microphone.addEventListener(ActivityEvent.ACTIVITY, _activityHandler);
			microphone.addEventListener(StatusEvent.STATUS, _statusHandler);

		}

		private function _activityHandler(aEvt:ActivityEvent):void {
			trace("activity handler : " + aEvt);
		}

		private function _statusHandler(sEvt:StatusEvent):void {
			trace("status handler : " + sEvt);
		}
	}
}