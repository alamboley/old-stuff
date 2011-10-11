package afp.pages
{
	import afp.core.Config;
	import afp.core.User;
	import afp.remoting.Service;
	import afp.services.vo.UserVO;

	import com.adobe.serialization.json.JSON;

	import flash.events.MouseEvent;
	import flash.net.SharedObject;

	/**
	 * @author Aymeric
	 */
	public class PageHome extends APage
	{
		public static const ID : String = PagePaths.HOME;
		private var _so : SharedObject;
		private var _asset : HomPageAsset;
		private var _loaderAsset : LoaderAsset;

		public function PageHome()
		{
			super();
		}

		override protected function _onStaged() : void
		{
			super._onStaged();
			_initialize();
		}

		private function _initialize() : void
		{
			if (User.getInstance().id != null)
			{
				gotoPage.dispatch(PagePaths.IMAGE_SELECTION);
				return;
			}
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
				_asset.loginBTN.addEventListener(MouseEvent.CLICK, _onSubmit, false, 0, true);
			}
		}

		private function _onSubmit(event : MouseEvent) : void
		{
			_login(_asset.loginTF.text);
		}

		private function _onError(error : Object) : void
		{
			// TODO gérer les erreurs
		}

		private function _onResult(result : Object) : void
		{
			removeChild(_loaderAsset);
			var json : Object = JSON.decode(String(result)).AFPResponse;
			if (json.success == 0)
			{
				_onError(result);
			}
			else if (json.success == 1)
			{
				var vo : UserVO = new UserVO(JSON.decode(String(result)).AFPResponse.dataObject);
				User.getInstance().id = vo.id;
				User.getInstance().nom = vo.nom;
				User.getInstance().prenom = vo.prenom;
				_so.data.login = vo.id;
				gotoPage.dispatch(PagePaths.IMAGE_SELECTION);
			}
		}

		private function _login(login : String) : void
		{
			_loaderAsset = new LoaderAsset(); 
			addChild(_loaderAsset);
			var user : UserVO = new UserVO({id:login});
			var service : Service = new Service(Config.SERVICES_URL + 'userservice.php');
			service.onResult.add(_onResult);
			service.onError.add(_onError);
			service.getuserbyid(user.id);
		}

		override public function hide() : void
		{
			hidden();
			// TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}
	}
}
