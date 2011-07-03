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
		
		public var information:MovieClip;

		public function Hud() {
			
			_instance = this;
			
			information.visible = false;

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
		
		public function putText($num:uint):void {
			
			switch ($num) {
				
				case 1:
					information.texte.text = "Kinessia is the game school project of Tiffany Francony (designer) & Aymeric Lamboley (developer) at the Gobelins French School, in Annecy.\n\n This simple web version doesn't include Java Server and Smartphone controller such as the original one.\n\n Go through the levels and find 3 machine's fragments!";
					break;
					
				case 2:
					information.texte.text = "Use your microphone to fly away and gets the fragment! \n\n If you don't have one, you can jump higher.";
					break;
					
				case 3:
					information.texte.text = "Find the fragment into the maze.";
					break;
					
				case 4:
					information.texte.text = "Go into the catapult and draw a circle from left to right to be catapulted!";
					break;
			}
		}
	}
}
