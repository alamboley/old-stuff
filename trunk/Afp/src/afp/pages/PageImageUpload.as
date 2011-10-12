package afp.pages
{
	import afp.core.User;
	import afp.core.Config;
	import afp.services.vo.PhotoVO;
	import afp.utils.Alert;
	import afp.utils.UDate;

	import by.blooddy.crypto.image.JPEGEncoder;

	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.GeolocationEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.sensors.Geolocation;
	import flash.utils.ByteArray;

	/**
	 * @author lbineau
	 */
	public class PageImageUpload extends APage
	{
		public static const ID : String = PagePaths.IMAGE_UPLOAD;
		private var _geoloc : Geolocation;

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
		}

		private function _geolocUpdate(gEvt : GeolocationEvent) : void
		{
			trace(gEvt.latitude.toString() + " _ " + gEvt.longitude.toString());
		}

		private function _onError(result : Object) : void
		{
			trace('error', result);
		}

		private function _displayImage() : void
		{
			var bm : Bitmap = new Bitmap(_options.imageData);
			addChild(bm);
			bm.x = (stage.stageWidth - bm.width) * .5;
			bm.y = (stage.stageHeight - bm.height) * .5;
			var bytes : ByteArray = JPEGEncoder.encode(_options.imageData, 80);
			_sendFile(bytes);
		}

		private function _sendFile(bytes : ByteArray) : void
		{
			trace(_options.eventId);
			var photo : PhotoVO = new PhotoVO({description:'desc', dateprise:UDate.getMySQLDate(new Date()), idevent:_options.eventId, iduser:User.getInstance().id, idEvent:_options.eventId, idUser:User.getInstance().id});
			var url : String = Config.SERVICES_URL + 'mediaservice.php?file=' + new Date().valueOf() + '&param=' + JSON.encode(photo);
			var request : URLRequest = new URLRequest(url);
			var loader : URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, _onComplete);
			request.contentType = 'application/octet-stream';
			request.method = URLRequestMethod.POST;
			request.data = bytes;
			trace(url);
			loader.load(request);
		}

		private function _onComplete(event : Event) : void
		{
			trace('image uploaded !', event.target);
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

			super.dispose();
		}
	}
}
