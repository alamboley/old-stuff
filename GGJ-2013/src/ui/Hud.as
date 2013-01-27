package ui {

	import starling.core.Starling;
	import starling.display.Image;
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

		private const _WIDTH:uint = 150;
		private const _HEIGHT:uint = 150;

		public  var mode:Boolean = new Boolean(false);
		
		
		public function Hud() {

			_instance = this;

			addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
		}

		static public function getInstance():Hud {
			return _instance;
		}

		private function _addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, _addedToStage);

			_left = new Image(AtlasSimple.getAtlas().getTexture("btLEFT"))
			addChild(_left);
			_left.name = "left";
			_left.x = 5;
			_left.y = Starling.current.viewPort.height - _HEIGHT * 1.5;

			_right = new Image(AtlasSimple.getAtlas().getTexture("btRIGHT"))
			addChild(_right);
			_right.touchable = true;
			_right.name = "right";
			_right.x = _left.x + _WIDTH + 5;
			_right.y = _left.y;

			_up = new Image(AtlasSimple.getAtlas().getTexture("btACTION"))
			addChild(_up);
			_up.name = "up";
			_up.x = Starling.current.viewPort.width - _WIDTH * 1.5;
			_up.y = Starling.current.viewPort.height - _HEIGHT * 1.5;
			
			
			_down = new Image(AtlasSimple.getAtlas().getTexture("btACTION"))
			//addChild(_down);
			_down.name = "down";
			_down.x = _up.x;
			_down.y = Starling.current.viewPort.height - _HEIGHT * 1.5;

			
			
			_left.addEventListener(TouchEvent.TOUCH, _touchHandler);
			_right.addEventListener(TouchEvent.TOUCH, _touchHandler);

			_up.addEventListener(TouchEvent.TOUCH, _touchHandler);

			// _down.addEventListener(TouchEvent.TOUCH, _touchHandler);
			_left.alpha = _right.alpha = _up.alpha = _down.alpha = 0.25;
		}

		private function _touchHandler(tEvt:TouchEvent):void {

			var touches:Vector.<Touch> = tEvt.getTouches(this);

			for each (var touch:Touch in touches) {
				var buttonName:String = (tEvt.target as Quad).name;

				var touchBegan:Touch = tEvt.getTouch(tEvt.target as Image, TouchPhase.BEGAN);
				var touchEnded:Touch = tEvt.getTouch(tEvt.target as Image, TouchPhase.ENDED);

				if (touchBegan) {

					if (buttonName == "left") {
						leftTouched = true;
						_left.alpha = 0.55;
					}

					if (buttonName == "right") {
						rightTouched = true;
						_right.alpha = 0.55;
					}


					if (buttonName == "up") {
						if (!mode) {
							
							upTouched = true;
						_up.alpha = 0.55;
						}else {
							
							trace("BOUTON ACTION");
						}
						
					}

				}

				if (touchEnded) {

					if (buttonName == "left") {
						leftTouched = false;
						_left.alpha = 0.25;
					}

					if (buttonName == "right") {
						rightTouched = false;
						_right.alpha = 0.25;
					}

					if (buttonName == "up") {

						
						if (!mode) {
						upTouched = false;
						_up.alpha = 0.25;
							
						}else {
							
						trace("Bouton Action ended");	
						}
						

					}
				}

			}

		}
	}
}
