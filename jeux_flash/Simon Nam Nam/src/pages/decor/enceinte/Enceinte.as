package pages.decor.enceinte {

	import pages.Pages;
	import pages.decor.DecorEvent;

	import com.gaiaframework.api.Gaia;
	import com.gaiaframework.api.ISound;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * @author Aymeric
	 */

	public class Enceinte extends MovieClip {
		
		private const _NBR_ONDE:uint = 6;
		
		private const _NBR_ENCEINTE:uint = 19;
		
		private const _BAFFLE_PEAK:Number = 0.5;

		public var lumieres:MovieClip;
		
		public var ondes1:MovieClip;
		public var ondes2:MovieClip;
		public var ondes3:MovieClip;
		public var ondes4:MovieClip;
		public var ondes5:MovieClip;
		public var ondes6:MovieClip;

		public var speaker1:Speaker1;
		public var speaker2:Speaker2;
		public var speaker3:Speaker3;
		public var speaker4:Speaker4;
		public var speaker5:Speaker5;
		public var speaker6:Speaker6;
		public var speaker7:Speaker7;
		public var speaker8:Speaker8;
		public var speaker9:Speaker9;
		public var speaker10:Speaker10;
		public var speaker11:Speaker11;
		public var speaker12:Speaker12;
		public var speaker13:Speaker13;
		public var speaker14:Speaker14;
		public var speaker15:Speaker15;
		public var speaker16:Speaker16;
		public var speaker17:Speaker17;
		public var speaker18:Speaker18;
		public var speaker19:Speaker19;

		private var _sc:SoundChannel;
		private var _st:SoundTransform;

		public function Enceinte() {

			_sc = new SoundChannel();
			_st = new SoundTransform();
		}

		public function init():void {

			lumieres.gotoAndPlay("boucle");

			_sc = ISound(Gaia.api.getPage(Pages.JEU).assets.enceinte).play(0, int.MAX_VALUE);

			_st.volume = 1;
			_sc.soundTransform = _st;

			this.addEventListener(Event.ENTER_FRAME, _spectrum);
		}

		public function echec():void {
			lumieres.gotoAndPlay("echec");
		}
		
		public function reussite($value:uint):void {
			
			if ($value == 1) {
				lumieres.gotoAndPlay("reussite1");
			} else {
				lumieres.gotoAndPlay("reussite2");
			} 
		}
		
		public function onde():void {
			
			for (var i:uint = 1; i <= _NBR_ONDE; ++i) {
				this["ondes" + i].play();
			}
		}

		private function _spectrum(evt:Event):void {

			if (_sc.leftPeak > _BAFFLE_PEAK) {

				for (var i:uint = 1; i <= _NBR_ENCEINTE; ++i) {
					this["speaker" + i].dispatchEvent(new DecorEvent(DecorEvent.BAFFLE));
				}
			}
		}

		public function augmenterVolume($value:Number):void {

			_st.volume = $value;
			_sc.soundTransform = _st;
		}

		protected function baffler(dEvt:DecorEvent):void {

			dEvt.target.play();
		}
	}
}
