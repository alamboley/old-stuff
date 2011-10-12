package afp.pages
{
	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author lbineau
	 */
	public class APage extends MovieClip
	{
		protected var _shield : Sprite;
		protected var _loaderAsset : Sprite;
		protected var _state : String;
		protected var _busy : Boolean = true;
		protected var _initedSignal : Signal;
		protected var _gotoPage : Signal;
		protected var _showSignal : Signal;
		protected var _shownSignal : Signal;
		protected var _hideSignal : Signal;
		protected var _hiddenSignal : Signal;
		protected var _options : Object;

		public function APage($options : Object = null)
		{
			super();
			_options = $options;
			_shield = new Sprite();
			_loaderAsset = new LoaderAsset();
			_shield.addChild(_loaderAsset);
			_initedSignal = new Signal();
			_gotoPage = new Signal(Object, Object);
			_showSignal = new Signal();
			_shownSignal = new Signal();
			_hideSignal = new Signal();
			_hiddenSignal = new Signal();
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
		}

		private function _onRemoveFromStage(event : Event) : void
		{
			_onUnStaged();
		}

		protected function _onUnStaged() : void
		{
		}

		private function _onAddedToStage(event : Event) : void
		{
			_onStaged();
		}

		protected function _onStaged() : void
		{
			_loaderAsset.x = uint((stage.stageWidth) / 2);
			_loaderAsset.y = uint((stage.stageHeight) / 2);
		}

		public function dispose() : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
			_options = null;
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

		public function pause() : void
		{
			_loaderAsset.visible = true;
			_shield.graphics.clear();
			_shield.graphics.beginFill(0xffffff, 0.5);
			_shield.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			_shield.graphics.endFill();
			if (stage) stage.addChild(_shield);
		}

		public function resume() : void
		{
			_loaderAsset.visible = false;
			_shield.graphics.clear();
			if (stage && stage.contains(_shield)) stage.removeChild(_shield);
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

		public function get gotoPage() : Signal
		{
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
	}
}
