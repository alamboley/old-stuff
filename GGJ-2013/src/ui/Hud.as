package ui {

	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * @author Aymeric
	 */
	public class Hud extends Sprite {

		public var leftTouched:Boolean = false;
		public var rightTouched:Boolean = false;
		public var upTouched:Boolean = false;
		public var downTouched:Boolean = false;
		
		private static var _instance:Hud;

		private var _left:Quad;
		private var _right:Quad;
		private var _up:Quad;
		private var _down:Quad;

		private const _WIDTH:uint = 50;
		private const _HEIGHT:uint = 50;

		public function Hud() {
			
			_instance = this;

			addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
		}
		
		static public function getInstance():Hud {
			return _instance;
		}

		private function _addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, _addedToStage);

			_left = new Quad(_WIDTH, _HEIGHT, 0xff0000);
			addChild(_left);
			_left.name = "left";
			_left.x = 5;
			_left.y = Starling.current.viewPort.height - _HEIGHT * 1.5;
			
			_right = new Quad(_WIDTH, _HEIGHT, 0x0000ff);
			addChild(_right);
			_right.name = "right";
			_right.x = _left.x + _WIDTH + 5;
			_right.y = _left.y;
			
			_up = new Quad(_WIDTH, _HEIGHT, 0x00ff00);
			addChild(_up);
			_up.name = "up";
			_up.x = Starling.current.viewPort.width - _WIDTH * 1.5;
			_up.y = Starling.current.viewPort.height - _HEIGHT * 2.5 - 5;
			
			_down = new Quad(_WIDTH, _HEIGHT, 0x000000);
			addChild(_down);
			_down.name = "down";
			_down.x = _up.x;
			_down.y = Starling.current.viewPort.height - _HEIGHT * 1.5;
			
			_left.addEventListener(TouchEvent.TOUCH, _touchHandler);
			_right.addEventListener(TouchEvent.TOUCH, _touchHandler);
			_up.addEventListener(TouchEvent.TOUCH, _touchHandler);
			_down.addEventListener(TouchEvent.TOUCH, _touchHandler);
		}

		private function _touchHandler(tEvt:TouchEvent):void {

			var buttonName:String = (tEvt.target as Quad).name;

			var touchBegan:Touch = tEvt.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = tEvt.getTouch(this, TouchPhase.ENDED);

			if (touchBegan) {

				switch(buttonName) {
					
					case "left":
						leftTouched = true;
						break;
						
					case "right":
						rightTouched = true;
						break;
						
					case "up":
						upTouched = true;
						break;
						
					case "down":
						downTouched = true;
						break;
				}

			} else if (touchEnded) {
				
				switch(buttonName) {
					
					case "left":
						leftTouched = false;
						break;
						
					case "right":
						rightTouched = false;
						break;
						
					case "up":
						upTouched = false;
						break;
						
					case "down":
						downTouched = false;
						break;
				}
			}
		}
	}
}
