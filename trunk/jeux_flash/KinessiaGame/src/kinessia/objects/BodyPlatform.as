package kinessia.objects {

	import Box2DAS.Dynamics.b2Body;

	import com.citrusengine.objects.platformer.Platform;

	/**
	 * @author Aymeric
	 */
	public class BodyPlatform extends Platform {

		public function BodyPlatform(name:String, params:Object = null) {
			super(name, params);
		}
		
		override public function destroy():void {
			super.destroy();
		}
		
		public function get body():b2Body {
			return _body;
		}
		
	}
}
