package afp.pages
{
	import afp.components.PopUp;
	import afp.core.Config;
	import afp.core.User;
	import afp.remoting.Service;
	import afp.services.vo.EventVO;
	import afp.services.vo.PhotoVO;
	import afp.utils.Alert;

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
		private var _service : Service;
		private var _geoloc : Geolocation;

		public function PageImageUpload($options : Object = null)
		{
			Alert.show(String($options));
			super($options);
			_initialize();
		}

		private function _initialize() : void
		{
			_service = new Service(Config.SERVICES_URL + 'usereventlinkservice.php');
			_service.onResult.add(_onResult);
			_service.onError.add(_onError);
			_service.geteventsforuser(User.getInstance().id);

			if (Geolocation.isSupported)
			{
				_geoloc = new Geolocation();
				_geoloc.setRequestedUpdateInterval(3000);
				_geoloc.addEventListener(GeolocationEvent.UPDATE, _geolocUpdate);
			}
			else
			{
				Alert.show("La géolocalisation n'est pas supportée", {colour:0xffffff, background:"blur"});
				trace('geolocation is not supported');
			}
			_displayImage();
		}

		private function _geolocUpdate(gEvt : GeolocationEvent) : void
		{
			trace(gEvt.latitude.toString() + " _ " + gEvt.longitude.toString());
		}

		private function _onResult(result : Object) : void
		{
			var json : Object = JSON.decode(String(result)).AFPResponse;
			if (json.success == 0)
			{
				_onError(result);
			}
			else if (json.success == 1)
			{
				var eventVo : Vector.<EventVO> = new Vector.<EventVO>();

				for each (var event : Object in json.dataObject)
				{
					eventVo.push(new EventVO(event));
				}

				var popup : PopUp = new PopUp(eventVo);
				addChild(popup);

				popup.x = stage.stageWidth - popup.width >> 1;
				popup.y = stage.stageHeight - popup.height >> 1;
			}
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
			var photo : PhotoVO = new PhotoVO({description:'desc', dateprise:'2006-04-8 5:25:78.789', idevent:'40', iduser:'11', idEvent:'41', idUser:'11'});
			var request : URLRequest = new URLRequest(Config.SERVICES_URL + 'mediaservice.php?file=test&param=' + JSON.encode(photo));
			var loader : URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, _onComplete);
			request.contentType = 'application/octet-stream';
			request.method = URLRequestMethod.POST;
			request.data = bytes;
			loader.load(request);
		}

		private function _onComplete(event : Event) : void
		{
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

		override public function dispose() : void
		{
			if (Geolocation.isSupported)
				_geoloc.removeEventListener(GeolocationEvent.UPDATE, _geolocUpdate);

			super.dispose();
		}
	}
}
