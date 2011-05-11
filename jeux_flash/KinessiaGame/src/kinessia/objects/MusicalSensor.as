package kinessia.objects {

	import com.citrusengine.objects.platformer.Sensor;

	/**
	 * @author Aymeric
	 */
	public class MusicalSensor extends Sensor {
		
		public var song:String;

		public function MusicalSensor(name:String, params:Object = null) {
			super(name, params);
		}
	}
}
