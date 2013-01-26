package levels {

	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Hero;
	import citrus.physics.nape.Nape;

	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;

	import objects.Hills;
	import objects.HillsTexture;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	import ui.Hud;

	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Rectangle;

	/**
	 * @author Aymeric
	 */
	public class Level1 extends StarlingState {

		protected var _ce:CitrusEngine;
		protected var _physics:Nape;
		
		protected var _hud:Hud;

		protected var _hero:Hero;

		private var _hillsTexture:HillsTexture;

		[Embed(source="/../embed/ArialFont.fnt", mimeType="application/octet-stream")]
		private var _fontConfig:Class;

		[Embed(source="/../embed/ArialFont.png")]
		private var _fontPng:Class;

		[Embed(source="/../embed/Horror.jpg")]
		private var _horrorPNG:Class;
		private var _containerGroupBgLight:Sprite;

		[Embed(source="/../embed/filette.png",mimeType="application/octet-stream")]
		private const _ResourcesData:Class;

		private var _armature:Armature;
		private var _factory:StarlingFactory;

		public function Level1() {
			super();

			_ce = CitrusEngine.getInstance();
			_ce.stage.focus = _ce.stage;
		}

		override public function initialize():void {
			super.initialize();
			
			_hud = new Hud();
			addChild(_hud);

			var bitmap:Bitmap = new _fontPng();
			var ftTexture:Texture = Texture.fromBitmap(bitmap);
			var ftXML:XML = XML(new _fontConfig());
			TextField.registerBitmapFont(new BitmapFont(ftTexture, ftXML));

			_physics = new Nape("physics");
			//_physics.visible = true;
			_physics.timeStep = 1 / 30;
			add(_physics);

			_hero = new Hero("hero", {x:1000, radius:50});
			_hero.maxVelocity = 150;
			add(_hero);

			/*var bulle:Bulle = new Bulle("une bulle", {x:250, y:230});
			add(bulle);*/

			_hillsTexture = new HillsTexture();
			var hills:Hills = new Hills("hills", {currentYPoint:1581, sliceWidth:128, widthHills:stage.stageWidth * 12, registration:"topLeft", view:_hillsTexture});
			add(hills);

			view.camera.setUp(_hero, new MathVector(_ce.stage.stageWidth / 2, _ce.stage.stageHeight / 2), new Rectangle(0, 0, 50000, 6000), new MathVector(0.25, 0.15));

			var bg:CitrusSprite = add(new CitrusSprite("test", {view:Image.fromBitmap(new _horrorPNG())})) as CitrusSprite;

			_containerGroupBgLight = view.getArt(bg).parent;
			//_containerGroupBgLight.filter = new SpotlightFilter(100, 400);

			_factory = new StarlingFactory();
			_factory.addEventListener(Event.COMPLETE, _textureCompleteHandler);
			_factory.parseData(new _ResourcesData());
		}

		private function _textureCompleteHandler(evt:Event):void {
			_factory.removeEventListener(Event.COMPLETE, _textureCompleteHandler);

			_armature = _factory.buildArmature("fillette");
			(_armature.display as Sprite).scaleX = 0.55;
			(_armature.display as Sprite).scaleY = 0.55;

			_hero.view = _armature;

			add(_hero);
		}

		override public function update(timeDelta:Number):void {
			super.update(timeDelta);

			//(_containerGroupBgLight.filter as SpotlightFilter).centerX = _hero.x;
			//(_containerGroupBgLight.filter as SpotlightFilter).centerY = _hero.y;

			_hillsTexture.update();
		}

		override public function destroy():void {

			TextField.unregisterBitmapFont("ArialMT");

			super.destroy();
		}

	}
}
