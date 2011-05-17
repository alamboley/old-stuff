package kinessia.objects {

	import com.citrusengine.objects.platformer.Sensor;

	/**
	 * @author Aymeric
	 */
	public class MusicalSensor extends Sensor {
		
		private var _song:String;

		public function MusicalSensor(name:String, params:Object = null) {
			super(name, params);
		}
		
		public function get song():String {
			return _song;
		}

		public function set song(value:String):void {
			_song = value;
		}
	}
}
