package kinessia {

	import kinessia.art.ArtEvent;
	import kinessia.art.ScreenGame;
	import kinessia.network.Network;
	import kinessia.network.NetworkEvent;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.media.Microphone;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite {
		
		public var home:MovieClip;
		
		private var _screenGame:ScreenGame;

		private var _network:Network;

		private var _coin:uint;

		public function Main() {

			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_network = new Network(home);
			addChild(_network);
			// Network is a Sprite instead of an EventDispatcher because of the EnterFrame
			
			_network.addEventListener(ArtEvent.REMOVE_HOME, _artHandler);

			_network.addEventListener(NetworkEvent.START_MICRO, _micro);
			_network.addEventListener(NetworkEvent.STOP_MICRO, _micro);

			_network.addEventListener(NetworkEvent.COIN_TAKEN, _addCoin);
		}

		private function _artHandler(aEvt:ArtEvent):void {
			
			switch (aEvt.type) {
				
				case ArtEvent.REMOVE_HOME:
				
					_network.removeEventListener(ArtEvent.REMOVE_HOME, _artHandler);
					removeChild(home);
					home = null;
					
					_screenGame = new ScreenGame();
					addChild(_screenGame);
					_screenGame.alpha = 0;
					TweenMax.to(_screenGame, 0.4, {alpha:1});
					
					_screenGame.pause.addEventListener(TouchEvent.TOUCH_TAP, _network.pauseGame);
					break;
			}
		}

		private function _micro(nEvt:NetworkEvent):void {

			switch (nEvt.type) {

				case NetworkEvent.START_MICRO:
				
					_screenGame.texte.gotoAndStop("start_micro");
					_screenGame.piece1.gotoAndStop("search");
					trace(Microphone.isSupported);

					_network.removeEventListener(NetworkEvent.START_MICRO, _micro);

					var microphone:Microphone = Microphone.getMicrophone();

					
					break;
					
				case NetworkEvent.STOP_MICRO:
					
					_screenGame.piece1.gotoAndStop("find");
					_network.removeEventListener(NetworkEvent.STOP_MICRO, _micro);
					
					microphone = null;
					
					break;
			}


		}

		private function _addCoin(nEvt:NetworkEvent):void {
			_screenGame.coin.coin_txt.text = String(++_coin);
		}
	}
}