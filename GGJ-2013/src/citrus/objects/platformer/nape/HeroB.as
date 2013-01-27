package citrus.objects.platformer.nape {

	/**
	 * This is a common, simple, yet solid implementation of a side-scrolling Hero. 
	 * The hero can run, jump, get hurt, and kill enemies. It dispatches signals
	 * when significant events happen. The game state's logic should listen for those signals
	 * to perform game state updates (such as increment coin collections).
	 * 
	 * Don't store data on the hero object that you will need between two or more levels (such
	 * as current coin count). The hero should be re-created each time a state is created or reset.
	 */
	public class HeroB extends Hero {

		public function HeroB(name:String, params:Object = null) {

			super(name, params);
		}
		
		override protected function updateAnimation():void {
			
			var prevAnimation:String = _animation;
			
			//var walkingSpeed:Number = getWalkingSpeed();
			var walkingSpeed:Number = _body.velocity.x; // this won't work long term!
			
			if (_hurt)
				_animation = "hurt";
				
			else if (!_onGround) {
				
				_animation = "idleH";
				
				if (walkingSpeed < -acceleration)
					_inverted = true;
				else if (walkingSpeed > acceleration)
					_inverted = false;
				
			} else if (_ducking)
				_animation = "duck";
				
			else {
				
				if (walkingSpeed < -acceleration) {
					_inverted = true;
					_animation = "walk";
					
				} else if (walkingSpeed > acceleration) {
					
					_inverted = false;
					_animation = "walk";
					
				} else
					_animation = "idleH";
			}
			
			if (prevAnimation != _animation)
				onAnimationChange.dispatch();

		}
	}
}
