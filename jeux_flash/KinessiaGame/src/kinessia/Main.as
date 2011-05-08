package kinessia {

	import com.citrusengine.core.CitrusEngine;

	/**
	 * @author Aymeric
	 */
	public class Main extends CitrusEngine {

		public function Main() {
			
			super();
			
			this.console.addCommand("fullscreen", _fullscreen);
			this.console.addCommand("play", _playGame);
		}
		
		private function _fullscreen():void {
			stage.displayState = "fullScreen";
		}

		private function _playGame():void {
			this.playing = !this.playing;
		}
	}
}
