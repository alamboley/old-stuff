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
			_left.y =  Starling.current.viewPort.height - _HEIGHT * 1.5;
			
			_right = new Image(AtlasSimple.getAtlas().getTexture("btRIGHT"))
			addChild(_right);
			_right.name = "right";
			_right.x = _left.x + _WIDTH + 5;
			_right.y = _left.y;
			
			_up = new Image(AtlasSimple.getAtlas().getTexture("btJUMP"))
			addChild(_up);
			_up.name = "up";
			_up.x = Starling.current.viewPort.width - _WIDTH * 1.5;
			_up.y = Starling.current.viewPort.height - _HEIGHT * 2.5 - 5;
			
			_down = new Image(AtlasSimple.getAtlas().getTexture("btACTION"))
			addChild(_down);
			_down.name = "down";
			_down.x = _up.x;
			_down.y = Starling.current.viewPort.height - _HEIGHT * 1.5;
			
			_left.addEventListener(TouchEvent.TOUCH, _touchHandler);
			_right.addEventListener(TouchEvent.TOUCH, _touchHandler);
			
			
			_up.addEventListener(TouchEvent.TOUCH, accelerate);
				
				
		//_up.addEventListener(TouchEvent.TOUCH, _touchHandler);
			
		//	_down.addEventListener(TouchEvent.TOUCH, _touchHandler);
			_left.alpha = _right.alpha = _up.alpha = _down.alpha = 0.25;
		}

		
		private function accelerate(tEvt:TouchEvent):void
		{
			var touch:Touch = tEvt.getTouch(this.stage);
			trace("Accelerate");
			if (touch.phase == TouchPhase.BEGAN) //on finger down
			{
				trace("pressed just now");
				
				upTouched = true;
				_up.alpha = 0.55;
					//do your stuff
				
			}
			
			if (touch.phase == TouchPhase.ENDED) //on finger up
			{
				trace("release");
				upTouched = false;
				_up.alpha = 0.25;
				
					//stop doing stuff
				
			}
		
		/*
		   var touch:Touch = tEvt.getTouch(stage);
		   if (touch)
		   {
		
		   trace(tEvt.target, touch.target, touch.phase);
		   }
		 */
		}
		
		
		
			private function _touchHandler(tEvt:TouchEvent):void
		{
			
			var touches:Vector.<Touch> = tEvt.getTouches(this);
			
			for each (var touch:Touch in touches)
			{
				var buttonName:String = (tEvt.target as Quad).name;
				
				var touchBegan:Touch = tEvt.getTouch(this, TouchPhase.BEGAN);
				var touchEnded:Touch = tEvt.getTouch(this, TouchPhase.ENDED);
				//var touchMoved:Touch = tEvt.getTouch(this, TouchPhase.MOVED);
				
				if (touchBegan)
				{
					
					switch (buttonName)
					{
						
						case "left": 
							leftTouched = true;
							_left.alpha = 0.55;
							break;
						
						case "right": 
							rightTouched = true;
							_right.alpha = 0.55;
							break;
						
						case "down": 
							downTouched = true;
							break;
						
						case "reset": 
							//CallBack();
							break;
					/*
					   case "up":
					   upTouched = true;
					   _up.alpha = 0.55;
					   break;
					 */
					}
					
				}
				if (touchEnded)
				{
					
					switch (buttonName)
					{
						
						case "left": 
							leftTouched = false;
							_left.alpha = 0.25;
							break;
						
						case "right": 
							rightTouched = false;
							_right.alpha = 0.25;
							break;
						
						case "down": 
							downTouched = false;
							break;
					/*
					   case "up":
					   upTouched = false;
					   _up.alpha = 0.25;
					   break;
					 */
					}
				}
				
			}
		
		}
	}
}
