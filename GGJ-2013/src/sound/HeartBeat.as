package sound 
{
	
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import org.osflash.signals.Signal;

	public class HeartBeat 
	{

		private var _playbackSpeed:Number = 1;	
		private var _targetSpeed:Number = 1;	

		private var _mp3:Sound;
		private var _Samples:ByteArray;
		private var _dynamicSound:Sound;
		private var _phase:Number;
		private var _numSamples:int;
		
		public var volume:Number = 0.7;
		
		private var _easeFunc:Function;
		private var _easeTimer:uint = 0;
		private var _easeDuration:uint = 2048 * 1500;
		
		/*
		 * Base clock - 3/4 time signature, 66bpm
		 */
		[Embed(source="/../bin/0909ms.mp3")]
		private var _66bpm34:Class;
		
		[Embed(source="/../bin/Heartbeat1.mp3")]
		private var _heartbeat1:Class;
		
		[Embed(source="/../bin/Heartbeat2.mp3")]
		private var _heartbeat2:Class;
		
		
		private var _hb1:Sound;
		private var _hb2:Sound;
		
		private var _beat:uint = 0;

		public function HeartBeat()
		{
			_easeFunc = Tween_easeOut;
			_mp3 = new _66bpm34();
			
			_hb1 = new _heartbeat1();
			_hb2 = new _heartbeat2();
			
			var bytes:ByteArray = new ByteArray();
			s.extract(bytes, int(s.length * 44.1));
			s = null;
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
			
			onLoopStart.dispatch();
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
			
			while (outputLength < 2050) { 
				
				if (int(_phase) < 1)
				{
					_phase += _numSamples;
				}
				else if (int(_phase + _playbackSpeed) > _numSamples)
				{
					_phase -= _numSamples;
					
					// 3/4 time signature.
					
					if (_beat == 0)
						_hb1.play();
					else if (_beat == 1)
						_hb2.play();
					
					(_beat >= 2)? _beat = 0 : _beat++; 
				}
				
				if (_easeTimer < _easeDuration)
				{
					_easeTimer++;
					_playbackSpeed = _easeFunc(_easeTimer, _playbackSpeed, _targetSpeed - _playbackSpeed, _easeDuration);
				}else
					_playbackSpeed = _targetSpeed;
				
				newpos = int(_phase) * 8;
				_Samples.position = newpos;
				
				l0 = r0 = l1 = r1 = 0;

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
