package afp.utils {

	import org.osflash.signals.Signal;

	import flash.desktop.NativeApplication;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MediaEvent;
	import flash.media.CameraUI;
	import flash.media.MediaPromise;
	import flash.media.MediaType;

	/**
	 * @author Aymeric
	 */
	public class Camera extends CameraUI {
		
		public var captured:Signal;

		private var _imageLoader:Loader;

		public function Camera() {

			addEventListener(MediaEvent.COMPLETE, pictureCaptured);
			addEventListener(Event.CANCEL, captureCanceled);
			addEventListener(ErrorEvent.ERROR, cameraError);
			
			captured = new Signal(Loader);

			launch(MediaType.IMAGE);
		}

		public function pictureCaptured(mEvt:MediaEvent):void {

			trace("Media captured...");

			var imagePromise:MediaPromise = mEvt.data;

			if (imagePromise.isAsync) {

				trace("Asynchronous media promise.");

				_imageLoader = new Loader();
				_imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _asyncImageLoaded);
				_imageLoader.addEventListener(IOErrorEvent.IO_ERROR, cameraError);

				_imageLoader.loadFilePromise(imagePromise);

			} else {

				trace("Synchronous media promise.");

				_imageLoader.loadFilePromise(imagePromise);
				showMedia(_imageLoader);
			}
		}

		private function _asyncImageLoaded(event:Event):void {
			
			_imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _asyncImageLoaded);

			trace("Media loaded in memory.");

			showMedia(_imageLoader);
		}

		private function showMedia(loader:Loader):void {
			
			captured.dispatch(loader);
		}

		public function captureCanceled(evt:Event):void {

			trace("Media capture canceled.");

			NativeApplication.nativeApplication.exit();
		}

		public function cameraError(eEvt:ErrorEvent):void {

			trace("Error:" + eEvt.text);

			NativeApplication.nativeApplication.exit();
		}

		public function destroy():void {

			removeEventListener(MediaEvent.COMPLETE, pictureCaptured);
			removeEventListener(Event.CANCEL, captureCanceled);
			removeEventListener(ErrorEvent.ERROR, cameraError);
			
			_imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _asyncImageLoaded);
			_imageLoader.removeEventListener(IOErrorEvent.IO_ERROR, cameraError);
			
			captured = null;
		}
	}
}
