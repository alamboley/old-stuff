package sound 
{
	
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;

	public class SoundNav 
	{

		private var _playbackSpeed:Number = 0;	
		private var _targetSpeed:Number = 1;	

		private var _mp3:Sound;
		private var _Samples:ByteArray;
		private var _dynamicSound:Sound;
		private var _phase:Number;
		private var _numSamples:int;
		
		public var volume:Number = 0.7;
		
		private var _easeFunc:Function;
		private var _easeTimer:uint = 0;
		private var _easeDuration:uint = 2048*1500;

		public function SoundNav(sound:Sound,ts:TimeShifter)
		{
			_easeFunc = Tween_easeOut;
			_mp3 = sound;
			_timeshifter = ts;
			
			var bytes:ByteArray = new ByteArray();
			sound.extract(bytes, int(sound.length * 44.1));
			sound = null;
			play(bytes);
		}
		
		public function stop():void
		{
			if (_dynamicSound) {
				_dynamicSound.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
				_dynamicSound = null;
			}
		}

		private function play(bytes:ByteArray):void
		{
			stop();
			_dynamicSound = new Sound();
			_dynamicSound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			
			_Samples = bytes;
			_numSamples = _Samples.length/8;
			
			_phase = 0;
			_dynamicSound.play();
		}

		private function onSampleData( event:SampleDataEvent ):void
		{
			_Samples.position = 0;
			
			var l0:Number;
			var r0:Number;
			var l1:Number;
			var r1:Number;
			
			var outputLength:int = 0;
			var newpos:int;
			var alpha:Number = _phase - int(_phase);
			
			while (outputLength < 2048) { 
				
				//loop both ways to prevent EOF errors
				if (int(_phase) < 0)
					_phase += _numSamples;
				else if (int(_phase+_playbackSpeed) >= _numSamples)
					_phase -= _numSamples; 
				
				//speed easing
				if (_easeTimer < _easeDuration)
				{
					_easeTimer++;
					_playbackSpeed = _easeFunc(_easeTimer, _playbackSpeed, _targetSpeed - _playbackSpeed, _easeDuration);
				}else
					_playbackSpeed = _targetSpeed;
				
				//read ByteArray
				newpos = int(_phase) * 8;
				_Samples.position = newpos;
				
				l0 = _Samples.readFloat();
				r0 = _Samples.readFloat();
				l1 = _Samples.readFloat();
				r1 = _Samples.readFloat();

				//Write interpolated values
				event.data.writeFloat((l0 + alpha * ( l1 - l0 ))* volume);
				event.data.writeFloat((r0 + alpha * ( r1 - r0 ))* volume);
				
				outputLength++;

				_phase += _playbackSpeed;
				
				alpha += (_playbackSpeed >= 0) ? _playbackSpeed : -_playbackSpeed;
				while ( alpha >= 1.0 ) --alpha;

			}
	
		}
		
		public function get currentSpeed():Number
		{
			return _playbackSpeed;
		}
		
		public function get targetSpeed():Number
		{
			return _targetSpeed;
		}
		
		public function set targetSpeed(value:Number):void
		{
			_easeTimer = 0;
			_targetSpeed = value;
		}
		
		protected function Tween_easeOut(t:Number, b:Number, c:Number, d:Number):Number { t /= d; return -c * t*(t-2) + b; }
	}
}
