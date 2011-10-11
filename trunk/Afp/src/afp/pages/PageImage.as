package afp.pages {

	import afp.utils.Camera;

	import com.greensock.TweenMax;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.CameraUI;
	import flash.net.FileFilter;
	import flash.net.FileReference;

	/**
	 * @author Aymeric
	 */
	public class PageImage extends APage {
		
		public var scene:Scene;
		
		private var _cam:Camera;
		
		private var _fileRef:FileReference;

		public function PageImage() {
			
			super();
			
			 scene = new Scene();
			 addChild(scene);
			 
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
		
		override public function hide():void {
			
			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}
	}
}
