package afp
{
	import afp.pages.PageEventSelection;
	import afp.pages.PageImageUpload;
	import afp.pages.PageHome;
	import afp.pages.PageImageSelection;
	import afp.pages.PageManager;
	import afp.utils.Alert;

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;

	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite
	{
		private var _pageManager : PageManager;
		private var _header : HeaderAsset;

		public function Main()
		{
			if (stage)
				_init(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, _init);
		}

		private function _init(e : Event = null) : void
		{
			if (e) removeEventListener(Event.ADDED_TO_STAGE, _init);

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			Alert.init(stage);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, _handleKeyDown);

			_pageManager = new PageManager();
			_header = new HeaderAsset();
			_pageManager.initialize([PageHome, PageImageSelection,PageEventSelection, PageImageUpload]);
			_pageManager.y = _header.height;
			addChild(_pageManager);

			_header.addEventListener(MouseEvent.CLICK, _onHeaderClicked);
			addChild(_header);

			stage.addEventListener(Event.RESIZE, _resize);
		}

		private function _onHeaderClicked(event : MouseEvent) : void
		{
			_pageManager.gotoPage(0);
		}

		/**
		 * Handle keyboard events for menu, back, and seach buttons.
		 * */
		private function _handleKeyDown(e : KeyboardEvent) : void
		{
			if (e.keyCode == Keyboard.BACK)
			{
				e.preventDefault();
				_pageManager.goBack();
				//NativeApplication.nativeApplication.exit();
			}
			else if (e.keyCode == Keyboard.MENU)
			{
				e.preventDefault();
			}
			else if (e.keyCode == Keyboard.SEARCH)
			{
				e.preventDefault();
			}
		}

		private function _resize(evt : Event) : void
		{
			stage.removeEventListener(Event.RESIZE, _resize);

			trace("Detected Resolution:" + stage.fullScreenWidth + " x " + stage.fullScreenHeight + "\nDevice type : " + Capabilities.manufacturer);
		}
	}
}
