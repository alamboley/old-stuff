package kinessia.objects {

	import Box2DAS.Dynamics.ContactEvent;

	import com.citrusengine.objects.platformer.Hero;
	import com.citrusengine.objects.platformer.Sensor;

	/**
	 * @author Aymeric
	 */
	public class Piece extends Sensor {

		public var label:String;

		private var _collectorClass:Class = Hero;

		public function Piece(name:String, params:Object = null) {
			super(name, params);

			_animation = label;
		}

		override protected function handleBeginContact(e:ContactEvent):void {
			
			super.handleBeginContact(e);

			if (_collectorClass && e.other.GetBody().GetUserData() is _collectorClass) {
				kill = true;
			}
		}
	}
}
