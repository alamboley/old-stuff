package afp.pages
{
	import flash.net.SharedObject;
	import com.greensock.TweenMax;

	/**
	 * @author Aymeric
	 */
	public class PageHome extends APage
	{
		private var _so : SharedObject;
		public function PageHome()
		{
			super();
			_initialize();
		}

		private function _initialize() : void
		{
			// in your init function
			_so = SharedObject.getLocal("afp/login", "/");
			/*if (_so.data.highScore == undefined) _lastHighScore = _so.data.highScore;

			// and later on game over:
			if (_highScore > _lastHighScore)
			{
				_so.data.highScore = _lastHighScore = _highScore;
				_so.flush();
			}*/
		}

		override public function hide() : void
		{
			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}
	}
}
