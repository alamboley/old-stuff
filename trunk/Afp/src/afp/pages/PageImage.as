package afp.pages {

	import afp.components.List;
	import afp.core.Config;
	import afp.core.User;
	import afp.remoting.Service;
	import afp.services.vo.EventVO;
	import afp.utils.Camera;

	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenMax;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.GeolocationEvent;
	import flash.events.MouseEvent;
	import flash.media.CameraUI;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.sensors.Geolocation;

	/**
	 * @author Aymeric
	 */
	public class PageImage extends APage {

		public static const ID:String = PagePaths.IMAGE_SELECTION;
		public var scene:Scene;

		private var _cam:Camera;
		private var _fileRef:FileReference;
		private var _geoloc:Geolocation;

		private var _service:Service;

		public function PageImage() {

			super();
		}

		override protected function _onStaged():void {

			super._onStaged();

			scene = new Scene();
			addChild(scene);

			_service = new Service(Config.SERVICES_URL + 'usereventlinkservice.php');
			_service.onResult.add(_onResult);
			_service.onError.add(_onError);
			_service.geteventsforuser(User.getInstance().id);


			if (Geolocation.isSupported) {

				_geoloc = new Geolocation();
				_geoloc.setRequestedUpdateInterval(3000);
				_geoloc.addEventListener(GeolocationEvent.UPDATE, _geolocUpdate);

			} else {
				trace('geolocation is not supported');
			}

			scene.logo.addEventListener(MouseEvent.CLICK, _goHome);
			scene.photo.addEventListener(MouseEvent.CLICK, _takeShot);
			scene.upload.addEventListener(MouseEvent.CLICK, _uploadFile);
		}


		private function _goHome(mEvt:MouseEvent):void {

			scene.logo.removeEventListener(MouseEvent.CLICK, _goHome);

			_gotoPage.dispatch(PagePaths.HOME);
		}

		private function _takeShot(mEvt:MouseEvent):void {

			if (CameraUI.isSupported) {

				_cam = new Camera();
				_cam.captured.add(_showCapturedPicture);

			} else {
				trace('camera interface is not supported');
			}
		}

		private function _showCapturedPicture(picture:Loader):void {

			addChild(picture.content);
			picture.content.scaleX = picture.content.scaleY = 0.1;
		}

		private function _uploadFile(mEvt:MouseEvent):void {

			_fileRef = new FileReference();
			_fileRef.browse([new FileFilter("Images", "*.jpg;*.png")]);

			_fileRef.addEventListener(Event.SELECT, _fileSelected);
		}

		private function _fileSelected(evt:Event):void {

			_fileRef.removeEventListener(Event.SELECT, _fileSelected);

			_fileRef.addEventListener(Event.COMPLETE, _fileLoaded);
			_fileRef.load();
		}

		private function _fileLoaded(evt:Event):void {

			_fileRef.removeEventListener(Event.COMPLETE, _fileLoaded);

			var loader:Loader = new Loader();
			loader.loadBytes(evt.target.data);

			addChild(loader);
		}

		private function _geolocUpdate(gEvt:GeolocationEvent):void {
			trace(gEvt.latitude.toString() + " _ " + gEvt.longitude.toString());
		}

		private function _onResult(result:Object):void {

			var json:Object = JSON.decode(String(result)).AFPResponse;
			if (json.success == 0) {
				_onError(result);
			} else if (json.success == 1) {

				var eventVo:Vector.<EventVO> = new Vector.<EventVO>();

				for each (var event : Object in json.dataObject) {
					eventVo.push(new EventVO(event));
				}
				
				var listEvent:List = new List(eventVo);
				addChild(listEvent);
			}
		}

		private function _onError(result:Object):void {
			trace(result);
		}

		override public function hide():void {

			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}

		override public function dispose():void {

			if (Geolocation.isSupported)
				_geoloc.removeEventListener(GeolocationEvent.UPDATE, _geolocUpdate);

			scene.logo.removeEventListener(MouseEvent.CLICK, _goHome);
			scene.photo.removeEventListener(MouseEvent.CLICK, _takeShot);
			scene.upload.removeEventListener(MouseEvent.CLICK, _uploadFile);

			super.dispose();

		}
	}
}
