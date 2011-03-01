package pages.decor.enceinte {

	import pages.Pages;
	import pages.decor.DecorEvent;

	import com.gaiaframework.api.Gaia;
	import com.gaiaframework.api.ISound;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * @author Aymeric
	 */

	public class AEnceinte extends MovieClip {
		
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
		
		private const _NBR_ENCEINTE:uint = 19;
		private const _BAFFLE_PEAK:Number = 0.5;

		private var _s:Sound;
		private var _sc:SoundChannel;
		private var _st:SoundTransform;

		public function AEnceinte() {
			
			_s = new Sound();
			_sc = new SoundChannel();
			_st = new SoundTransform();		
		}
		
		public function init():void {
			
			var enceinteSon:ISound = Gaia.api.getPage(Pages.JEU).assets.enceinte;
			
			_sc = enceinteSon.play(0, int.MAX_VALUE);
			
			this.addEventListener(Event.ENTER_FRAME, _spectrum);
		}

		private function _spectrum(evt:Event):void {

			if (_sc.leftPeak > _BAFFLE_PEAK) {
				
				for (var i:uint = 1; i <= _NBR_ENCEINTE; ++i) {
					
					// TODO gérer le problème du baffle n°9
					if (i != 9) {
						this["speaker" + i].dispatchEvent(new DecorEvent(DecorEvent.BAFFLE));
					}
				}
			}
		}
		
		protected function baffler(dEvt:DecorEvent):void {
			
			dEvt.target.play();
		}
	}
}
