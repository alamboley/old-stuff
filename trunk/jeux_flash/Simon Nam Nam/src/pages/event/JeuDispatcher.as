package pages.event {

	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */

	public class JeuDispatcher extends EventDispatcher {

		private var _stage:Stage;

		private var _timer:Timer;
		private var _timerRunning:Boolean;

		private var _espace:Boolean;
		private var _valeurScroll:int;


		public function JeuDispatcher($stage:Stage, target:IEventDispatcher = null) {

			_stage = $stage;

			_timer = new Timer(500, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _reInitTimer);
			_timer.start();

			_stage.addEventListener(KeyboardEvent.KEY_DOWN, _toucheDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, _toucheUp);
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL, _scroll);

			super(target);
		}

		private function _reInitTimer(tEvt:TimerEvent):void {

			_timer.start();
			_timerRunning = true;
		}

		private function _toucheDown(kEvt:KeyboardEvent):void {

			if (kEvt.keyCode == Keyboard.SPACE) {
				_espace = true;
			}
		}

		private function _toucheUp(kEvt:KeyboardEvent):void {

			if (kEvt.keyCode == Keyboard.SPACE) {
				_espace = false;
			}
		}

		private function _scroll(mEvt:MouseEvent):void {

			_valeurScroll = mEvt.delta;

			if (_timerRunning == true) {

				if (_valeurScroll > 0) {
					
					_timerRunning = false;
					
					if (_espace == true) {
						this.dispatchEvent(new JeuEvent(JeuEvent.SCROLLH_ESPACE));
					} else {
						this.dispatchEvent(new JeuEvent(JeuEvent.SCROLLH));
					}

				} else {
					
					_timerRunning = false;

					if (_espace == true) {
						this.dispatchEvent(new JeuEvent(JeuEvent.SCROLLB_ESPACE));
					} else {
						this.dispatchEvent(new JeuEvent(JeuEvent.SCROLLB));
					}
				}
			}
		}
	}
}
