package afp.pages
{
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author lbineau
	 */
	public class PageManager extends Sprite
	{
		protected var _pages : Array;
		protected var _currentIdx : uint;
		protected var _currentPageView : APage;

		public function PageManager()
		{
			super();
		}

		public function initialize($pages : *, $startPage : uint = 0) : void
		{
			_pages = [];
			for (var i : int = 0; i < $pages.length; i++)
			{
				_pages[i] = $pages[i];
			}
			_currentIdx = $startPage;
			_currentPageView = APage(new _pages[_currentIdx]);
			addChild(_currentPageView);
			_currentPageView.show();
		}

		public function dispose() : void
		{
			removeChild(_currentPageView);
			_currentPageView = null;
			_pages = [];
		}

		protected function next() : void
		{
			(_currentIdx < _pages.length) ? _currentIdx++ : 0;
			_update();
		}

		public function prev() : void
		{
			(_currentIdx > 0) ? _currentIdx-- : _pages.length;
			_update();
		}

		public function gotoPage($numPage : uint) : void
		{
			if (_currentIdx != $numPage)
			{
				_currentIdx = $numPage;
				_update();
			}
		}

		protected function _update() : void
		{
			_currentPageView.hiddenSignal.add(_onCurrentPageHidden);
			_currentPageView.hide();
		}

		protected function _onCurrentPageHidden() : void
		{
			_currentPageView.hiddenSignal.remove(_onCurrentPageHidden);
			_flushCurrentPage();
			trace(_currentIdx, _pages[_currentIdx]);
			_currentPageView = APage(new _pages[_currentIdx]);
			addChild(_currentPageView);
			_currentPageView.show();
			dispatchEvent(new Event(Event.CHANGE));
		}

		protected function _flushCurrentPage() : void
		{
			removeChild(_currentPageView);
			_currentPageView = null;
			_currentPageView.dispose();
		}

		public function get currentPageView() : APage
		{
			return _currentPageView;
		}
	}
}
