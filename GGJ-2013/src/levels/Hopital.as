package levels {

	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.HeroB;
	import citrus.objects.platformer.nape.Platform;
	import citrus.view.starlingview.StarlingCamera;

	import dragonBones.factorys.StarlingFactory;

	import objects.BulleTimer;

	import starling.display.Image;

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
		
		[Embed(source="/../embed/fillette.png",mimeType="application/octet-stream")]
		private const _ResourcesData:Class;
		
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
		}
		
		private function createSpots():void {
			
			for (var i:int = 0; i < GameVars.SpeechHopital.length; i++) {
				
				var coin:BulleTimer = new BulleTimer("coin", {x: GameVars.SpeechDots[i], y: 600, width: 30, height: 30, text: GameVars.SpeechHopital[i]});
				add(coin);	
			}
			
		}
		
		override public function update(timeDelta:Number):void
		{			
			super.update(timeDelta);
		}
			
		override public function destroy():void {
			super.destroy();
		}
	
	}

}