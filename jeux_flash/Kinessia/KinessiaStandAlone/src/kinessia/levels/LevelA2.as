package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Declik;
	import kinessia.objects.Croquis;
	import kinessia.objects.Piece;

	import com.citrusengine.objects.platformer.Sensor;

	import flash.display.MovieClip;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.utils.ByteArray;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */
	public class LevelA2 extends ALevel {

		private const _MICRO_FLY_LEVEL:Number = 0.9;
		private const _HERO_GRAVITY:Number = 0.6;

		private var _pieceCaught:Boolean;

		private var _heroInitGravity:Number;

		private var _microphoneSensor:Sensor;
		private var _croquis:Croquis;
		private var _piece:Piece;
		
		private var _microphone:Microphone;
		private var _micArray:Array;
		private var _timer:Timer;

		public function LevelA2(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}

		override public function initialize():void {

			super.initialize();

			_heroInitGravity = _declik.gravity;

			_addContactRestartLevel();

			_addMusicalSensor();

			_microphoneSensor = Sensor(getObjectByName("Microphone"));
			_microphoneSensor.onBeginContact.addOnce(_addMicrophone);
			_microphoneSensor.onBeginContact.add(_showText);
			_microphoneSensor.onEndContact.add(_hideText);

			_croquis = Croquis(getFirstObjectByType(Croquis));

			_piece = Piece(getFirstObjectByType(Piece));
			_piece.onBeginContact.add(_pieceTaken);
		}

		override public function destroy():void {

			super.destroy();
		}

		override protected function _endLevel(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik && _pieceCaught == true) {
				lvlEnded.dispatch();
			}
		}
		
		private function _showText(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_hud.putText(2);
				_hud.information.visible = true;
			}
		}
		
		private function _hideText(cEvt:ContactEvent):void {
			
			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				_hud.information.visible = false;
			}
		}

		private function _addMicrophone(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {

				_declik.gravity = _HERO_GRAVITY;

				_croquis.anim = "white";
				
				_microphone = Microphone.getMicrophone();
				_catchMic(true);
				_microphone.addEventListener(SampleDataEvent.SAMPLE_DATA, _sampleData);
			}
		}
		
		private function _catchMic($value:Boolean):void {

			if ($value == true) {

				_timer = new Timer(50);

				_micArray = [];

				_timer.start();
				_timer.addEventListener(TimerEvent.TIMER, _timeMic);

			} else {
				
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, _timeMic);
				
				_timer.reset();
				
				_timer = null;
			}
		}

		private function _timeMic(tEvt:TimerEvent):void {

			var max:Number = 0;

			for (var i:uint = 0; i < _micArray.length; ++i) {
				if (_micArray[i] > max)
					max = _micArray[i];
			}
			
			if (max > _MICRO_FLY_LEVEL) {
				_declik.microFly = true;
			} else {
				_declik.microFly = false;
			}
			
			_micArray = [];
		}

		private function _sampleData(sdEvt:SampleDataEvent):void {

			var byteArray:ByteArray = sdEvt.data;

			while (sdEvt.data.bytesAvailable > 0) {
				_micArray.push(byteArray.readByte());
			}
		}

		private function _pieceTaken(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {

				_declik.gravity = _heroInitGravity;
				
				_pieceCaught = true;

				_croquis.anim = "black";
				
				_declik.stopFlying();
				
				_catchMic(false);
				_microphone = null;
			}
		}
	}
}
