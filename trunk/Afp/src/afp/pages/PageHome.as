package afp.pages
{
	import afp.core.Config;
	import afp.core.User;
	import afp.remoting.Service;
	import afp.remoting.vo.UserVO;
	import afp.utils.Alert;

	import com.adobe.serialization.json.JSON;

	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.ui.Keyboard;




	/**
	 * @author Aymeric
	 */
	public class PageHome extends APage
	{
		public const defaultTextTF : String = 'Identifiant';
		public static const ID : String = PagePaths.HOME;
		private var _so : SharedObject;
		private var _asset : HomePageAsset;

		public function PageHome($options : Object = null)
		{
			super($options);
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
				gotoPage.dispatch(PagePaths.IMAGE_SELECTION, null);
				return;
			}
			_asset = new HomePageAsset();
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
				_asset.loginTF.addEventListener(FocusEvent.FOCUS_IN, textInputHandler);
				_asset.loginTF.addEventListener(FocusEvent.FOCUS_OUT, textInputHandlerOut);

				_asset.loginBTN.addEventListener(MouseEvent.CLICK, _onSubmit, false, 0, true);
				_asset.loginTF.text = defaultTextTF;
			}
		}

		private function textInputHandler(event : FocusEvent) : void
		{
			if(_asset.loginTF.text == defaultTextTF) _asset.loginTF.text = '';
			_asset.loginTF.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown, false, 0, true);
		}

		private function textInputHandlerOut(event : FocusEvent) : void
		{
			if(_asset.loginTF.text == '') _asset.loginTF.text = defaultTextTF;
			_asset.loginTF.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown, false, 0, true);
		}

		private function _onKeyDown(event : KeyboardEvent) : void
		{
			if (event.charCode == Keyboard.ENTER)
			{
				_login(_asset.loginTF.text);
			}
		}

		private function _onSubmit(event : MouseEvent) : void
		{
			_login(_asset.loginTF.text);
		}

		private function _onError(error : Object) : void
		{
			resume();
			// TODO gérer les erreurs
			Alert.show('Veuillez entrer à nouveau votre login', {colour:0xffffff, background:"blur"});
		}

		private function _onResult(result : Object) : void
		{
			resume();
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
				gotoPage.dispatch(PagePaths.IMAGE_SELECTION, null);
			}
		}

		private function _login(login : String) : void
		{
			pause();
			var user : UserVO = new UserVO({id:login});
			var service : Service = new Service(Config.SERVICES_URL + 'userservice.php');
			service.onResult.addOnce(_onResult);
			service.onError.addOnce(_onError);
			service.getuserbyid(user.id);
		}

		override public function dispose() : void
		{
			_asset.loginTF.removeEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			_asset.loginBTN.removeEventListener(MouseEvent.CLICK, _onSubmit);
			super.dispose();
		}

		override public function hide() : void
		{
			hidden();
			// TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}

		override public function hidden() : void
		{
			resume();
			super.hidden();
		}
	}
}
