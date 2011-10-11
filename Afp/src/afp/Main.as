package afp
{
	import flash.events.MouseEvent;
	import afp.pages.PageHome;
	import afp.pages.PageImage;
	import afp.pages.PageManager;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;

	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite
	{
		private var _pageManager : PageManager;
		private var _header : HeaderAsset;

		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, _init);
		}

		private function _init(evt : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _init);

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			_pageManager = new PageManager();
			_pageManager.initialize([PageHome, PageImage], 0);
			addChild(_pageManager);
			
			_header = new HeaderAsset();
			_header.addEventListener(MouseEvent.CLICK, _onHeaderClicked);
			addChild(_header);
			
			stage.addEventListener(Event.RESIZE, _resize);
		}

		private function _onHeaderClicked(event : MouseEvent) : void
		{
			_pageManager.gotoPage(0);
		}

		private function _resize(evt : Event) : void
		{
			stage.removeEventListener(Event.RESIZE, _resize);

			trace("Detected Resolution:" + stage.fullScreenWidth + " x " + stage.fullScreenHeight + "\nDevice type : " + Capabilities.manufacturer);
		}
	}
}
