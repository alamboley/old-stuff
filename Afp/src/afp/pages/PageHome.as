package afp.pages
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.adobe.serialization.json.JSON;
	import afp.core.Config;

	import com.greensock.TweenMax;

	import flash.events.AsyncErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Aymeric
	 */
	public class PageHome extends APage
	{
		public static const ID : String = PagePaths.HOME;
		private var _so : SharedObject;
		private var _asset : MovieClip;

		public function PageHome()
		{
			super();
			_initialize();
		}

		private function _initialize() : void
		{
			_so = SharedObject.getLocal("afp/user", "/");

			// Si l'utilisateur est enregistré
			if (_so.data.login != undefined)
			{
				var login : String = _so.data.login;
				_so.flush();
				_login(login);
			}
			else
			{
				addEventListener(MouseEvent.CLICK, _onSubmit, false, 0, true);
			}
		}

		private function _onSubmit(event : MouseEvent) : void
		{
			var urlLoader : URLLoader = new URLLoader(new URLRequest(Config.SERVICES_URL + 'userservice.php?method=getuserbyid&param=23'));
			urlLoader.addEventListener(Event.COMPLETE, _onResponse);

			urlLoader.addEventListener(Event.OPEN, _onError);
			urlLoader.addEventListener(ErrorEvent.ERROR, _onError)
			urlLoader.addEventListener(AsyncErrorEvent.ASYNC_ERROR, _onError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onError);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, _onError);
		}

		private function _onError(event : Event) : void
		{
			// TODO gérer les erreurs
		}

		private function _onResponse(event : Event) : void
		{
			_login(JSON.decode(event.target.data).AFPResponse.dataObject.id);
		}

		private function _login(login : String) : void
		{
		}

		override public function hide() : void
		{
			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}
	}
}
