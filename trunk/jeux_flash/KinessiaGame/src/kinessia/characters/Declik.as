package kinessia.characters {

	import Box2DAS.Common.V2;

	import kinessia.network.PhoneInput;

	import com.citrusengine.objects.platformer.Hero;

	import flash.ui.Keyboard;

	/**
	 * @author Aymeric
	 */
	public class Declik extends Hero {
		
		private var _phoneInput:PhoneInput;

		private var _onGround:Boolean = false;
		private var _springOffEnemy:Number = -1;
		private var _hurt:Boolean = false;
		private var _friction:Number = 0.75;
		private var _playerMovingHero:Boolean = false;

		public function Declik(name:String, params:Object = null) {
			
			super(name, params);
			
			_phoneInput = new PhoneInput();
			_phoneInput.initialize();
		}

		/*override public function update(timeDelta:Number):void {
			
			super.update(timeDelta);

			var velocity:V2 = _body.GetLinearVelocity();

			if (controlsEnabled) {
				
				var moveKeyPressed:Boolean = false;

				if (_ce.input.isDown(Keyboard.RIGHT) || _phoneInput.phoneDirecton == "right") {
					velocity.x += (acceleration);
					moveKeyPressed = true;
				}

				if (_ce.input.isDown(Keyboard.LEFT) || _phoneInput.phoneDirecton == "left") {
					velocity.x -= (acceleration);
					moveKeyPressed = true;
				}

				if (moveKeyPressed && !_playerMovingHero) {
					_playerMovingHero = true;
					_fixture.SetFriction(0);
				} else if (!moveKeyPressed && _playerMovingHero) {
					_playerMovingHero = false;
					_fixture.SetFriction(_friction);
				}

				if (_onGround && (_ce.input.justPressed(Keyboard.SPACE) || _phoneInput.phoneJump == true)) {
					velocity.y = -jumpHeight;
					onJump.dispatch();
				}

				if ((_ce.input.isDown(Keyboard.SPACE) || _phoneInput.phoneJump == true) && !_onGround && velocity.y < 0) {
					velocity.y -= jumpAcceleration;
				}

				if (_springOffEnemy != -1) {
					y = _springOffEnemy;
					if (_ce.input.isDown(Keyboard.SPACE) || _phoneInput.phoneJump == true)
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

			updateAnimation();
		}

		private function updateAnimation():void {

			var prevAnimation:String = _animation;

			var velocity:V2 = _body.GetLinearVelocity();
			if (_hurt) {
				_animation = "hurt";
			} else if (!_onGround) {
				_animation = "jump";
			} else {
				if (velocity.x < -.5) {
					_inverted = true;
					_animation = "walk";
				} else if (velocity.x > .5) {
					_inverted = false;
					_animation = "walk";
				} else {
					_animation = "idle";
				}
			}

			if (prevAnimation != _animation) {
				onAnimationChange.dispatch();
			}
		}*/
	}
}
