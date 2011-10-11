package afp.pages {

	import afp.components.PopUp;
	import afp.core.Config;
	import afp.core.User;
	import afp.remoting.Service;
	import afp.services.vo.EventVO;
	import afp.services.vo.PhotoVO;
	import afp.utils.Camera;

	import by.blooddy.crypto.image.JPEGEncoder;

	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenMax;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.GeolocationEvent;
	import flash.events.MouseEvent;
	import flash.media.CameraUI;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.sensors.Geolocation;
	import flash.utils.ByteArray;

	/**
	 * @author Aymeric
	 */
	public class PageImage extends APage
	{
		public static const ID : String = PagePaths.IMAGE_SELECTION;
		public var scene : Scene;
		private var _cam : Camera;
		private var _fileRef : FileReference;
		private var _geoloc : Geolocation;
		private var _service : Service;

		public function PageImage()
		{
			super();
		}

		override protected function _onStaged() : void
		{
			super._onStaged();

			scene = new Scene();
			addChild(scene);

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
				trace('geolocation is not supported');
			}

			scene.photo.addEventListener(MouseEvent.CLICK, _takeShot);
			scene.upload.addEventListener(MouseEvent.CLICK, _uploadFile);
		}

		private function _takeShot(mEvt : MouseEvent) : void
		{
			if (CameraUI.isSupported)
			{
				// Ajout d'un shield de clic
				pause();
				_cam = new Camera();
				_cam.captured.addOnce(_showPicture);
			}
			else
			{
				trace('camera interface is not supported');
			}
		}

		private function _showPicture(picture : Loader) : void
		{
			var bmd : BitmapData = new BitmapData(picture.content.width, picture.content.height, false);
			bmd.draw(picture.content);
			var bitmap : Bitmap = new Bitmap(bmd);
			addChild(bitmap);
			var area : AutoFitArea = new AutoFitArea(this, 0, 0, stage.stageWidth, stage.stageHeight);
			area.attach(bitmap, {scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE,hAlign:AlignMode.LEFT, vAlign:AlignMode.TOP, crop:true});
			var bytes : ByteArray = JPEGEncoder.encode(bmd);
			_sendFile(bytes);

			// On enlève le shield du clic
			resume();
		}

		private function _uploadFile(mEvt : MouseEvent) : void
		{
			_fileRef = new FileReference();
			_fileRef.browse([new FileFilter("Images", "*.jpg;*.png")]);

			_fileRef.addEventListener(Event.SELECT, _fileSelected);
		}

		private function _fileSelected(evt : Event) : void
		{
			_fileRef.removeEventListener(Event.SELECT, _fileSelected);

			_fileRef.addEventListener(Event.COMPLETE, _fileLoaded);
			_fileRef.load();
			pause();
		}

		private function _fileLoaded(evt : Event) : void
		{
			_fileRef.removeEventListener(Event.COMPLETE, _fileLoaded);

			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onImageLoaded);
			loader.loadBytes(evt.target.data);
		}

		private function _onImageLoaded(event : Event) : void
		{
			var loader : Loader = Loader(LoaderInfo(event.target).loader);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onImageLoaded);
			var bmd : BitmapData = new BitmapData(loader.content.width, loader.content.height, false);
			bmd.draw(loader.content);
			var bitmap : Bitmap = new Bitmap(bmd);
			addChild(bitmap);
			var area : AutoFitArea = new AutoFitArea(this, 0, 0, stage.stageWidth, stage.stageHeight);
			area.attach(bitmap, {scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE,hAlign:AlignMode.LEFT, vAlign:AlignMode.TOP, crop:true});
			var bytes : ByteArray = JPEGEncoder.encode(bmd);
			_sendFile(bytes);
			resume();
		}

		private function _sendFile(bytes : ByteArray) : void
		{
			var photo : PhotoVO = new PhotoVO({description:'desc', dateprise:'2006-04-8 5:25:78.789', idevent:'41', iduser:'11', idEvent:'41', idUser:'11'});
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
			trace('event', event.target.data);
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

		override public function hide() : void
		{
			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}

		override public function dispose() : void
		{
			if (Geolocation.isSupported)
				_geoloc.removeEventListener(GeolocationEvent.UPDATE, _geolocUpdate);

			scene.photo.removeEventListener(MouseEvent.CLICK, _takeShot);
			scene.upload.removeEventListener(MouseEvent.CLICK, _uploadFile);

			super.dispose();
		}
	}
}
