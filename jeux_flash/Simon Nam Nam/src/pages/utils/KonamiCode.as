package pages.utils {

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;


	public class KonamiCode extends EventDispatcher {

		private var _konamiCode:Vector.<String>;
		private var _callBack:Function;

		public function KonamiCode($stage:Stage) {

			_konamiCode = new Vector.<String>();
			_konamiCode.length = 5;

			$stage.addEventListener(KeyboardEvent.KEY_DOWN, _checkKonamiCode);
		}


		private function _checkKonamiCode(e:KeyboardEvent):void {

			_konamiCode.shift();
			_konamiCode.push(e.keyCode);

			/*trace("___________________________________________");
			trace("User Input:", _konamiCode);
			trace("Comared To:", [69, 186, 73, 76, 69]);
			trace("Is a match:", _konamiCode.toString() == [69, 186, 73, 76, 69].toString());
			trace("___________________________________________");*/
			if (_konamiCode.toString() == [69, 186, 73, 76, 69].toString()) {
				this.dispatchEvent(new Event("KonamiCode"));
			} else if (_konamiCode.toString() == [69, 77, 73, 76, 69].toString()) {
				this.dispatchEvent(new Event("KonamiCode"));
			}

		}
	}
}