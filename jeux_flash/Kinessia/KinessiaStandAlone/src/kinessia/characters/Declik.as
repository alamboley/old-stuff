package kinessia.characters {

	import Box2DAS.Common.V2;

	import com.citrusengine.objects.platformer.Hero;

	/**
	 * @author Aymeric
	 */
	public class Declik extends Hero {

		private var _velocityCatapulte:V2;

		private var _securityMicro:Boolean = false;

		public function Declik(name:String, params:Object = null) {

			super(name, params);
			
			enemyClass = Bullzor;
			hurtDuration = 2000;
		}

		override public function destroy():void {
			super.destroy();
		}

		override public function update(timeDelta:Number):void {

			super.update(timeDelta);

			var velocity:V2 = _body.GetLinearVelocity();

			if (_velocityCatapulte != null) {
				_body.SetLinearVelocity(_velocityCatapulte);
			} else {
				_body.SetLinearVelocity(velocity);
			}
		}

		public function stopFlying():void {
			_securityMicro = true;
		}

		public function get velocityCatapulte():V2 {
			return _velocityCatapulte;
		}

		public function set velocityCatapulte(velocityCatapulte:V2):void {
			_velocityCatapulte = velocityCatapulte;
		}
	}
}

