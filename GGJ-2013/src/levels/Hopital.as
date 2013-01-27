package levels {

	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.HeroB;
	import citrus.objects.platformer.nape.Platform;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.view.starlingview.StarlingCamera;
	import starling.core.Starling;
	import starling.display.Quad;
	import ui.Caption;

	import dragonBones.factorys.StarlingFactory;

	import nape.callbacks.InteractionCallback;

	import objects.BulleTimer;

	import starling.display.Image;
	import starling.filters.BlurFilter;

	import com.greensock.TweenLite;

	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author 3wg
	 */
	public class Hopital extends ALevel
	{
		private var _camera:StarlingCamera;
		
		[Embed(source="/../embed/hopital.png")]
		private var _bgHopital:Class;
		
		[Embed(source="/../embed/oursHopital.png")]
		private var _oursHopital:Class;
		
		private var _sensorOurs:Sensor;
		
		private var _buttonAnim:Boolean = false;
		private var _ours:CitrusSprite;
		
		private var _overlayQuad:Quad;
		
		public var caption:Caption;
		
		public function Hopital()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var decor:CitrusSprite = new CitrusSprite("Decor", { view:Image.fromBitmap(new _bgHopital()), group: 0});
			add(decor);
			
			_ours = new CitrusSprite("ours", {view:Image.fromBitmap(new _oursHopital()), x:610, y:515});
			add(_ours);
			
			_hero = new HeroB("hero", {x: 980, y: 605, radius: 50});
			_hero.maxVelocity = 65;
			_hero.acceleration = 25;
			_hero.jumpHeight = 220;
			_hero.jumpAcceleration = 2;
			add(_hero);
			
			add(new Platform("sol", {x: 1600/2, y: 700, width: 1600, height: 80}));
			add(new Platform("murGAUCHE", { x: 0, y: 680, width: 40, height: 1600 } ));
			add(new Platform("murDROITE", { x: 1600, y: 680, width: 40, height: 1600 } ));
			
			view.camera.setUp(_hero, new MathVector((stage.stageWidth / 2), (stage.stageHeight / 1.5)), new Rectangle(0, 0, 1600, 768), new MathVector(0.10, 0.15));
			_camera = (view.camera as StarlingCamera);
			_camera.allowZoom = true;
			_camera.zoomEasing = 0.025;
			
			_factory = new StarlingFactory();
			_factory.addEventListener(Event.COMPLETE, _textureCompleteHandler);
			_factory.parseData(new _ResourcesData());
			
			caption = new Caption();
			Starling.current.stage.addChild(caption);
			
			createSpots();
			
			_sensorOurs = new Sensor("sensor ours", {x:630, y:610, width:50, height:50});
			add(_sensorOurs);
			_sensorOurs.onBeginContact.add(_clignoterBouton);
			_sensorOurs.onEndContact.add(_clignoterBoutonStop);
			
			_overlayQuad = new Quad(stage.stageWidth, stage.stageHeight, 0);
			_overlayQuad.touchable = false;
			_overlayQuad.alpha = 1;
			Starling.current.stage.addChild(_overlayQuad);
			
			//INTRO
			TweenLite.to(_overlayQuad, 5, { alpha:0 } );
			introCam();

		}
		
		private function introCam():void
		{
			_camera.zoomEasing = 0;
			_camera.zoomFit(50000, 50000);
			TweenLite.delayedCall(2, function():void 
			{
				_camera.zoomEasing = 0.01;
				_camera.zoomFit(500, 500);
			});
		}

		private function _clignoterBouton(callback:InteractionCallback):void {
			
			_buttonAnim = true;
			alphaTween1();
			_hud.mode = true;
			
			_ours.view.filter = BlurFilter.createGlow(0xFF0000);
		}
		
		private function alphaTween1():void {
			
			if (_hud.up && _buttonAnim)
				TweenLite.to(_hud.up, 0.4, {alpha:0.7,scaleX:1.2,scaleY:1.2, onComplete:alphaTween0});
		}
		
		private function alphaTween0():void {
			
			if (_hud.up && _buttonAnim)
				TweenLite.to(_hud.up, 0.4, {alpha:0.4,scaleX:1,scaleY:1, onComplete:alphaTween1});
		}
		
		private function _clignoterBoutonStop(callback:InteractionCallback):void {
			_ours.view.filter = null;
			_buttonAnim = false;
			_hud.mode = false;
			TweenLite.to(_hud.up, 0.4, {alpha:0.4, onComplete:alphaTween1});
		}
		
		private function createSpots():void {
			
			for (var i:int = 0; i < GameVars.SpeechHopital.length; i++) {
				
				var coin:BulleTimer = new BulleTimer("coin", {x: GameVars.SpeechDots[i], y: 600, width: 30, height: 30, text: GameVars.SpeechHopital[i]});
				coin.captionRef = caption;
				add(coin);	
			}
			
		}

		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			
			caption.update();
			
			if (_buttonAnim && _hud.upTouched) {
				
				GameVars.level1Fini = true;
				
				previousLevel.dispatch();
			}
			
		}
		
		override public function destroy():void
		{
			Starling.current.stage.removeChildren();
		}

	}

}