package kinessia.art {

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */
	public class ScreenGame extends MovieClip {
		
		public var skip:MovieClip;
		public var textfield:TextField;
		
		public var fullscreen:MovieClip;
		public var pause:MovieClip;
		public var sound:MovieClip;
		
		public var help:MovieClip;
		public var earth:MovieClip;
		
		public var coin:MovieClip;
		
		public var piece1:MovieClip;
		public var piece2:MovieClip;
		public var piece3:MovieClip;
		
		public var texte:MovieClip;
		
		private var _timer:Timer;

		public function ScreenGame() {
			
			skip.visible = false;
			textfield.visible = false;
		}
		
		public function playText():void {
			
			_timer = new Timer(14000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _nextText);
			_timer.start();
		}

		private function _nextText(tEvt:TimerEvent):void {
			
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _nextText);
			
			textfield.text = "Mais il va falloir faire vite ! \nLes Bullzors ont séparé la machine en trois fragments distincts, si tu parviens à les rassembler alors la vie pourra revenir.";
			textfield.appendText("\n\nPour les récupérer, tu devras faire face à trois épreuves, mais prends garde aux Bulzors car ils peuvent être n’importe où ! \n\nPars maintenant et sois courageux !");
		}

		public function stopText():void {
			
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _nextText);
		}
	}
}
