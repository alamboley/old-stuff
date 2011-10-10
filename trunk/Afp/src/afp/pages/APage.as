package afp.pages
{
	import org.osflash.signals.Signal;

	import flash.display.MovieClip;

	/**
	 * @author lbineau
	 */
	public class APage extends MovieClip
	{
		protected var _id : String;
		protected var _state : String;
		protected var _busy : Boolean = true;
		protected var _initedSignal : Signal;
		protected var _gotoPage:Signal;
		protected var _showSignal : Signal;
		protected var _shownSignal : Signal;
		protected var _hideSignal : Signal;
		protected var _hiddenSignal : Signal;

		public function APage()
		{
			super();
			_initedSignal = new Signal();
			_gotoPage = new Signal(uint);
			_showSignal = new Signal();
			_shownSignal = new Signal();
			_hideSignal = new Signal();
			_hiddenSignal = new Signal();
		}

		public function dispose() : void
		{
			_state = null;
			_initedSignal.removeAll();
			_initedSignal = null;
			_gotoPage.removeAll();
			_gotoPage = null;
			_showSignal.removeAll();
			_showSignal = null;
			_shownSignal.removeAll();
			_shownSignal = null;
			_hideSignal.removeAll();
			_hideSignal = null;
			_hiddenSignal.removeAll();
			_hiddenSignal = null;
		}

		public function inited() : void
		{
			_state = Animation.INITED;
			_busy = false;
			_initedSignal.dispatch();
		}

		public function show() : void
		{
			_state = Animation.SHOW;
			_busy = true;
			_showSignal.dispatch();
		}

		public function shown() : void
		{
			_state = Animation.SHOWN;
			_busy = false;
			_shownSignal.dispatch();
		}

		public function hide() : void
		{
			_state = Animation.HIDE;
			_busy = true;
			_hideSignal.dispatch();
		}

		public function hidden() : void
		{
			_state = Animation.HIDDEN;
			_busy = false;
			_hiddenSignal.dispatch();
		}

		// --------------------------------------
		// GETTER / SETTER
		// --------------------------------------
		public function get state() : String
		{
			return _state;
		}

		public function get busy() : Boolean
		{
			return _busy;
		}

		public function get initedSignal() : Signal
		{
			return _initedSignal;
		}
		
		public function get gotoPage():Signal {
			return _gotoPage;
		}

		public function get showSignal() : Signal
		{
			return _showSignal;
		}

		public function get shownSignal() : Signal
		{
			return _shownSignal;
		}

		public function get hideSignal() : Signal
		{
			return _hideSignal;
		}

		public function get hiddenSignal() : Signal
		{
			return _hiddenSignal;
		}

		public function get id() : String
		{
			return _id;
		}

		public function set id(id : String) : void
		{
			_id = id;
		}
	}
}
