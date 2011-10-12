package afp.pages
{
	import afp.utils.Alert;
	import afp.utils.Camera;

	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MediaEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.media.CameraRoll;
	import flash.media.CameraUI;
	import flash.media.MediaPromise;

	/**
	 * @author Aymeric
	 */
	public class PageImageSelection extends APage
	{
		public static const ID : String = PagePaths.IMAGE_SELECTION;
		private var _cam : Camera;
		private var _asset : SelectionPageAsset;
		private var _cameraRoll : CameraRoll;

		public function PageImageSelection($options:Object = null)
		{
			super($options);
			visible = false;
		}

		override protected function _onStaged() : void
		{
			super._onStaged();
			show();
			_asset = new SelectionPageAsset();
			addChild(_asset);


			_asset.photo.addEventListener(MouseEvent.CLICK, _takeShot);
			_asset.upload.addEventListener(MouseEvent.CLICK, _uploadFile);
		}

		private function _takeShot(mEvt : MouseEvent) : void
		{
			if (CameraUI.isSupported)
			{
				// Ajout d'un shield de clic
				pause();
				_cam = new Camera();
				_cam.captured.addOnce(_endPage);
			}
			else
			{
				Alert.show("Votre appareil photo n'est pas supporté", {colour:0xffffff, background:"blur"});
			}
		}

		private function _uploadFile(event : MouseEvent) : void
		{
			if (!_cameraRoll)
			{
				if (CameraRoll.supportsBrowseForImage)
					_cameraRoll = new CameraRoll;
				else
				{
					Alert.show("Fonctionnalité browseForImage non supportée...", {colour:0xffffff, background:"blur"});
					return;
				}
				_cameraRoll.addEventListener(MediaEvent.SELECT, _onSelection);
				_cameraRoll.addEventListener(ErrorEvent.ERROR, _onErrorEvent);
			}
			// demande de récupération d'image au système Android
			_cameraRoll.browseForImage();
		}

		private function _onErrorEvent(event : Event) : void
		{
			Alert.show("Veuillez réessayer...", {colour:0xffffff, background:"blur"});
		}

		private function _onSelection(event : MediaEvent) : void
		{
			_cameraRoll.removeEventListener(Event.COMPLETE, _onSelection);
			var imagePromise : MediaPromise = event.data;
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onImageLoaded);
			loader.loadFilePromise(imagePromise);
		}

		private function _onImageLoaded(event : Event) : void
		{
			var loader : Loader = Loader(LoaderInfo(event.target).loader);
			_endPage(loader);
		}

		private function _endPage(loader : Loader) : void
		{
			var _image : Bitmap = Bitmap(loader.content);
			var ratio : Number = Math.min(stage.stageWidth / _image.width, stage.stageHeight / _image.height);
			ratio = ratio > 1 ? 1 : ratio;
			const bd : BitmapData = new BitmapData(ratio * _image.width, ratio * _image.height);
			const matrix : Matrix = new Matrix();
			matrix.scale(ratio, ratio);
			bd.draw(_image.bitmapData, matrix);
			var bmd : BitmapData = bd;

			gotoPage.dispatch(PagePaths.IMAGE_UPLOAD,{imageData:bmd});
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
			_asset.photo.removeEventListener(MouseEvent.CLICK, _takeShot);
			_asset.upload.removeEventListener(MouseEvent.CLICK, _uploadFile);

			super.dispose();
		}
	}
}
