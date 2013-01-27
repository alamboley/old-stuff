package levels {

	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.HeroB;
	import citrus.objects.platformer.nape.Platform;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.view.starlingview.StarlingCamera;

	import dragonBones.factorys.StarlingFactory;

	import nape.callbacks.InteractionCallback;

	import objects.BulleTimer;

	import starling.display.Image;

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
		
		private var _sensorOurs:Sensor;
		
		private var _buttonAnim:Boolean = false;
		
		public function Hopital()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var ImageDECOR:Image = Image.fromBitmap(new _bgHopital());
			
			var decor:CitrusSprite = new CitrusSprite("Decor", { view: ImageDECOR, group: 0});
			add(decor);
			
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
			
			createSpots();
			
			_sensorOurs = new Sensor("sensor ours", {x:630, y:610, width:50, height:50});
			add(_sensorOurs);
			_sensorOurs.onBeginContact.add(_clignoterBouton);
			_sensorOurs.onEndContact.add(_clignoterBoutonStop);
		}

		private function _clignoterBouton(callback:InteractionCallback):void {
			
			_buttonAnim = true;
			alphaTween1();
			_hud.mode = true;
		}
		
		private function alphaTween1():void {
			
			if (_hud.up && _buttonAnim)
				TweenLite.to(_hud.up, 0.4, {alpha:0.7, onComplete:alphaTween0});
		}
		
		private function alphaTween0():void {
			
			if (_hud.up && _buttonAnim)
				TweenLite.to(_hud.up, 0.4, {alpha:0.4, onComplete:alphaTween1});
		}
		
		private function _clignoterBoutonStop(callback:InteractionCallback):void {
			_buttonAnim = false;
			_hud.mode = false;
			TweenLite.to(_hud.up, 0.4, {alpha:0.4, onComplete:alphaTween1});
		}
		
		private function createSpots():void {
			
			for (var i:int = 0; i < GameVars.SpeechHopital.length; i++) {
				
				var coin:BulleTimer = new BulleTimer("coin", {x: GameVars.SpeechDots[i], y: 600, width: 30, height: 30, text: GameVars.SpeechHopital[i]});
				add(coin);	
			}
			
		}

		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			
			if (_buttonAnim && _hud.upTouched) {
				
				GameVars.level1Fini = true;
				
				previousLevel.dispatch();
			}
			
		}

	}

}