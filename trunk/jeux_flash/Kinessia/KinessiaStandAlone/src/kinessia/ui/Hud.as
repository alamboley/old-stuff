package kinessia.ui {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Aymeric
	 */
	public class Hud extends Sprite {
		
		private static var _instance:Hud;

		public var fullscreen:MovieClip;
		public var pause:MovieClip;
		public var sound:MovieClip;

		public var coin:MovieClip;

		public function Hud() {
			
			_instance = this;

			fullscreen.buttonMode = pause.buttonMode = sound.buttonMode = true;

			fullscreen.addEventListener(MouseEvent.CLICK, _buttonClicked);
			pause.addEventListener(MouseEvent.CLICK, _buttonClicked);
			sound.addEventListener(MouseEvent.CLICK, _buttonClicked);
		}
		
		public static function getInstance():Hud {
			return _instance;
		}

		private function _buttonClicked(mEvt:MouseEvent):void {

			switch (mEvt.target.name) {

				case "fullscreen":
				
					this.dispatchEvent(new HudEvent(HudEvent.FULLSCREEN));

					if (mEvt.target.currentFrameLabel == "fullscreen") {
						mEvt.target.gotoAndStop("normal");
					} else {
						mEvt.target.gotoAndStop("fullscreen");
					}

					break;

				case "pause":
				
					this.dispatchEvent(new HudEvent(HudEvent.PAUSE));

					if (mEvt.target.currentFrameLabel == "play") {
						mEvt.target.gotoAndStop("pause");
					} else {
						mEvt.target.gotoAndStop("play");
					}

					break;

				case "sound":
				
					this.dispatchEvent(new HudEvent(HudEvent.SOUND));

					if (mEvt.target.currentFrameLabel == "play") {
						mEvt.target.gotoAndStop("mute");
					} else {
						mEvt.target.gotoAndStop("play");
					}

					break;
			}
		}
	}
}
