package afp.pages
{
	import afp.core.Config;
	import afp.remoting.Service;
	import afp.services.vo.UserVO;

	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.AsyncErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
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
			var service : Service = new Service(Config.SERVICES_URL+'userservice.php');
			service.onResult.add(_onResult);
			service.onError.add(_onError);
			service.getuserbyid('11');
//			_initialize();
		}

		private function _initialize() : void
		{
			_asset = new HomPageAsset();
			addChild(_asset);
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
				_asset.validBTN.addEventListener(MouseEvent.CLICK, _onSubmit, false, 0, true);
			}
		}

		private function _onSubmit(event : MouseEvent) : void
		{
			var user : UserVO = new UserVO(_asset.validBTN.text);
			var urlLoader : URLLoader = new URLLoader(new URLRequest(Config.SERVICES_URL + 'userservice.php?method=getuserbyid&param=' + user.id));
			urlLoader.addEventListener(Event.COMPLETE, _onResult);

			urlLoader.addEventListener(Event.OPEN, _onError);
			urlLoader.addEventListener(ErrorEvent.ERROR, _onError);
			urlLoader.addEventListener(AsyncErrorEvent.ASYNC_ERROR, _onError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onError);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, _onError);
		}

		private function _onError(error : Object) : void
		{
			/*URLLoader(event.target).removeEventListener(Event.COMPLETE, _onResponse);
			URLLoader(event.target).removeEventListener(Event.OPEN, _onError);
			URLLoader(event.target).removeEventListener(ErrorEvent.ERROR, _onError);
			URLLoader(event.target).removeEventListener(AsyncErrorEvent.ASYNC_ERROR, _onError);
			URLLoader(event.target).removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onError);
			URLLoader(event.target).removeEventListener(IOErrorEvent.IO_ERROR, _onError);*/
			// TODO gérer les erreurs
		}

		private function _onResult(result : Object) : void
		{
			/*URLLoader(event.target).removeEventListener(Event.COMPLETE, _onResponse);
			URLLoader(event.target).removeEventListener(Event.OPEN, _onError);
			URLLoader(event.target).removeEventListener(ErrorEvent.ERROR, _onError);
			URLLoader(event.target).removeEventListener(AsyncErrorEvent.ASYNC_ERROR, _onError);
			URLLoader(event.target).removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onError);
			URLLoader(event.target).removeEventListener(IOErrorEvent.IO_ERROR, _onError);*/
			trace(this,result);
			MonsterDebugger.trace(this,result);
//			_login(JSON.decode(event.target.data).AFPResponse.dataObject.id);
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
