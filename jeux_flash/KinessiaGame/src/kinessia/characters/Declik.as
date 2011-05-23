package kinessia.characters {

	import Box2DAS.Common.V2;

	import kinessia.network.PhoneInput;

	import com.citrusengine.objects.platformer.Hero;

	/**
	 * @author Aymeric
	 */
	public class Declik extends Hero {

		private var _phoneInput:PhoneInput;

		private var _springOffEnemy:Number = -1;
		private var _playerMovingHero:Boolean = false;

		public function Declik(name:String, params:Object = null) {

			super(name, params);

			_phoneInput = new PhoneInput();
			_phoneInput.initialize();
		}

		override public function update(timeDelta:Number):void {

			super.update(timeDelta);

			var velocity:V2 = _body.GetLinearVelocity();

			if (controlsEnabled) {

				var moveKeyPressed:Boolean = false;

				if (_phoneInput.phoneDirecton == "right") {
					velocity.x += (acceleration);
					moveKeyPressed = true;
				}

				if (_phoneInput.phoneDirecton == "left") {
					velocity.x -= (acceleration);
					moveKeyPressed = true;
				}

				if (moveKeyPressed && !_playerMovingHero) {
					_playerMovingHero = true;
					_fixture.SetFriction(0);
				} else if (!moveKeyPressed && _playerMovingHero) {
					_playerMovingHero = false;
					_fixture.SetFriction(friction);
				}

				if (onGround && _phoneInput.justJumped() == true) {
					velocity.y = -jumpHeight;
					onJump.dispatch();
				}

				if ((_phoneInput.phoneJump == true) && !onGround && velocity.y < 0) {
					velocity.y -= jumpAcceleration;
				}

				if (_springOffEnemy != -1) {
					y = _springOffEnemy;
					if (_phoneInput.phoneJump == true)
						velocity.y = -enemySpringJumpHeight;
					else
						velocity.y = -enemySpringHeight;
					_springOffEnemy = -1;
				}
			}

			if (velocity.x > (maxVelocity))
				velocity.x = maxVelocity;
			else if (velocity.x < (-maxVelocity))
				velocity.x = -maxVelocity;

			_body.SetLinearVelocity(velocity);
		}
	}
}