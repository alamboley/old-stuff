package pages.decor.enceinte {

	import pages.decor.DecorEvent;
	import pages.Pages;

	import com.gaiaframework.api.Gaia;
	import com.gaiaframework.api.ISound;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * @author Aymeric
	 */

	public class AEnceinte extends EventDispatcher {

		private var _s:Sound;
		private var _sc:SoundChannel;
		private var _st:SoundTransform;

		public function AEnceinte() {
			
			_s = new Sound();
			_sc = new SoundChannel();
			_st = new SoundTransform();
			
			var enceinteSon:ISound = Gaia.api.getPage(Pages.JEU).assets.enceinte;
			
			_sc = enceinteSon.play(0, int.MAX_VALUE);
			
			this.addEventListener(Event.ENTER_FRAME, _spectrum);		
		}

		private function _spectrum(evt:Event):void {

			if (_sc.leftPeak > 0.95) {
				this.dispatchEvent(new DecorEvent(DecorEvent.BAFFLE));
			}
		}
	}
}
