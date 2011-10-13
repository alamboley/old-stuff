package afp.pages
{
	import afp.core.Config;
	import afp.core.User;
	import afp.remoting.vo.PhotoVO;
	import afp.utils.Alert;
	import afp.utils.UDate;

	import by.blooddy.crypto.image.JPEGEncoder;

	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenMax;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.GeolocationEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.sensors.Geolocation;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;

	/**
	 * @author lbineau
	 */
	public class PageImageUpload extends APage
	{
		public static const ID : String = PagePaths.IMAGE_UPLOAD;
		private var _geoloc : Geolocation;
		private var _asset : UploadPageAsset;
		private var _defaultText : String = 'Ajoutez un commentaire à votre photo';

		public function PageImageUpload($options : Object = null)
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
			_asset = new UploadPageAsset();
			addChild(_asset);
			_asset.sendBTN.addEventListener(MouseEvent.CLICK, _onSendClicked);
			if (Geolocation.isSupported)
			{
				_geoloc = new Geolocation();
				_geoloc.setRequestedUpdateInterval(3000);
				_geoloc.addEventListener(GeolocationEvent.UPDATE, _geolocUpdate);
			}
			else
			{
				Alert.show("La géolocalisation n'est pas supportée", {colour:0xffffff, background:"blur"});
			}
			_displayImage();
			_displayDescription();
		}

		private function _onSendClicked(event : MouseEvent) : void
		{
			pause();
			var bytes : ByteArray = JPEGEncoder.encode(_options.imageData, 80);
			_sendFile(bytes);
		}

		private function _displayDescription() : void
		{
			_asset.descriptionTF.addEventListener(FocusEvent.FOCUS_IN, textInputHandler);
			_asset.descriptionTF.addEventListener(FocusEvent.FOCUS_OUT, textInputHandlerOut);

			_asset.descriptionTF.text = _defaultText;
		}

		private function textInputHandler(event : FocusEvent) : void
		{
			if (_asset.descriptionTF.text == _defaultText) _asset.descriptionTF.text = '';
			_asset.descriptionTF.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown, false, 0, true);
		}

		private function textInputHandlerOut(event : FocusEvent) : void
		{
			if (_asset.descriptionTF.text == '') _asset.descriptionTF.text = _defaultText;
			_asset.descriptionTF.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown, false, 0, true);
		}

		private function _onKeyDown(event : KeyboardEvent) : void
		{
			if (event.charCode == Keyboard.ENTER)
			{
			}
		}

		private function _geolocUpdate(gEvt : GeolocationEvent) : void
		{
			trace('_geolocUpdate',gEvt.latitude.toString() + " _ " + gEvt.longitude.toString());
		}

		private function _displayImage() : void
		{
			var bm : Bitmap = new Bitmap(_options.imageData);
			bm.smoothing = true;
			var container : Sprite = Sprite(_asset['container']);
			container.addChild(bm);
			var area : AutoFitArea = new AutoFitArea(container, 0, 0, stage.stageWidth - (container.x * 2), stage.stageHeight - container.y, 0xCC0000);
			area.attach(bm, {scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, crop:true});
		}

		private function _sendFile(bytes : ByteArray) : void
		{
			var desc : String = (_asset.descriptionTF.text == _defaultText) ? '' : _asset.descriptionTF.text;
			var photo : PhotoVO = new PhotoVO({description:desc, dateprise:UDate.getMySQLDate(new Date()), idevent:_options.eventId, iduser:User.getInstance().id});
			var url : String = Config.SERVICES_URL + 'mediaservice.php?file=' + new Date().valueOf() + '&param=' + com.adobe.serialization.json.JSON.encode(photo);
			var request : URLRequest = new URLRequest(url);
			var loader : URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, _onComplete, false, 0, true);
			request.contentType = 'application/octet-stream';
			request.method = URLRequestMethod.POST;
			request.data = bytes;
			trace(url);
			loader.load(request);
		}

		private function _onComplete(event : Event) : void
		{
			URLLoader(event.target).removeEventListener(Event.COMPLETE, _onComplete);
			resume();
			Alert.show("Image envoyée avec succès", {colour:0xffffff, background:"blur"});
			gotoPage.dispatch(PagePaths.IMAGE_SELECTION, null);
		}

		override public function hide() : void
		{
			super.hide();
			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}

		override public function show() : void
		{
			super.show();
			TweenMax.to(this, 0.5, {autoAlpha:1, onComplete:shown});
		}

		override public function hidden() : void
		{
			resume();
			super.hidden();
		}

		override public function dispose() : void
		{
			if (Geolocation.isSupported)
				_geoloc.removeEventListener(GeolocationEvent.UPDATE, _geolocUpdate);
			_asset.descriptionTF.removeEventListener(FocusEvent.FOCUS_IN, textInputHandler);
			_asset.descriptionTF.removeEventListener(FocusEvent.FOCUS_OUT, textInputHandlerOut);
			_asset.descriptionTF.removeEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			_asset.sendBTN.addEventListener(MouseEvent.CLICK, _onSendClicked);

			super.dispose();
		}
	}
}
