package kinessia {

	import gesture.Gesture;
	import gesture.RecognizeEvent;

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
		private var _gesture:Gesture;

		private var _tmpLvlCoin:uint;

		public function Main() {

			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			_network = new Network(home);
			addChild(_network);
			// Network is a Sprite instead of an EventDispatcher because of the EnterFrame

			_network.addEventListener(NetworkEvent.LEVEL_COMPLETE, _gameOnPhone);
			_network.addEventListener(NetworkEvent.RESTART_LEVEL, _gameOnPhone);

			_network.addEventListener(ArtEvent.REMOVE_HOME, _artHandler);

			_network.addEventListener(NetworkEvent.START_MICRO, _gameOnPhone);
			_network.addEventListener(NetworkEvent.STOP_MICRO, _gameOnPhone);

			_network.addEventListener(NetworkEvent.START_CATAPULTE, _gameOnPhone);

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

		private function _gameOnPhone(nEvt:NetworkEvent):void {

			switch (nEvt.type) {

				case NetworkEvent.LEVEL_COMPLETE:
					
					_tmpLvlCoin = 0;
					break;

				case NetworkEvent.RESTART_LEVEL:
				
					_screenGame.coin.coin_txt.text = String(uint(_screenGame.coin.coin_txt.text) - _tmpLvlCoin);

					_tmpLvlCoin = 0;
					break;

				case NetworkEvent.START_MICRO:

					_screenGame.texte.gotoAndStop("start_micro");
					_screenGame.piece1.gotoAndStop("search");
					trace("microphone supporté :" + Microphone.isSupported);

					var microphone:Microphone = Microphone.getMicrophone();


					break;

				case NetworkEvent.STOP_MICRO:

					_screenGame.piece1.gotoAndStop("find");

					microphone = null;

					break;

				case NetworkEvent.START_CATAPULTE:

					_gesture = new Gesture();
					_screenGame.addChild(_gesture);
					_gesture.addEventListener(RecognizeEvent.CIRCLE_IDENTIFIED, _drawCircleForCatapulte);

					break;
			}
			
		}

		private function _drawCircleForCatapulte(rEvt:RecognizeEvent):void {

			_gesture.removeEventListener(RecognizeEvent.CIRCLE_IDENTIFIED, _drawCircleForCatapulte);
			_screenGame.removeChild(_gesture);
			_gesture = null;

			_network.drawCircleForCatapulte();
		}

		private function _addCoin(nEvt:NetworkEvent):void {
			
			_screenGame.coin.coin_txt.text = String(uint(_screenGame.coin.coin_txt.text) + 1);
			++_tmpLvlCoin;
		}
	}
}