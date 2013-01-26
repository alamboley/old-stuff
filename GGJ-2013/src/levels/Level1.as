package levels {

	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Hero;
	import citrus.physics.nape.Nape;
	import citrus.view.starlingview.StarlingCamera;

	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;

	import objects.Hills;
	import objects.HillsTexture;

	import sound.HeartBeat;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.krecha.ScrollImage;
	import starling.extensions.krecha.ScrollTile;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	import ui.Hud;

	import utils.SpotlightFilter;

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

		private var _containerGroupBgLight:Sprite;

		[Embed(source="/../embed/filette.png",mimeType="application/octet-stream")]
		private const _ResourcesData:Class;

		private var _armature:Armature;
		private var _factory:StarlingFactory;
		
		private var _scrollBackground:ScrollImage;
		private var _camera:StarlingCamera;
		private var _spotlightFilter:SpotlightFilter;
		private var ImageDECOR:Sprite;
		private var levelProps:Array = GameVars.Props;
		private var levelItemps:Array = GameVars.levelItems;
		private var lightSpot:CitrusSprite;
		
		private var _HeartBeat:HeartBeat;

		public function Level1() {
			super();

			_ce = CitrusEngine.getInstance();
			_ce.stage.focus = _ce.stage;
		}

		override public function initialize():void {
			super.initialize();
			
			scaleX = GameVars.GameScale;
			scaleY = GameVars.GameScale;
			
			_hud = new Hud();
			addChild(_hud);
			_hud.scaleX = GameVars.UpScale;
			_hud.scaleY = GameVars.UpScale;

			var bitmap:Bitmap = new _fontPng();
			var ftTexture:Texture = Texture.fromBitmap(bitmap);
			var ftXML:XML = XML(new _fontConfig());
			TextField.registerBitmapFont(new BitmapFont(ftTexture, ftXML));

			_physics = new Nape("physics");
			//_physics.visible = true;
			_physics.timeStep = 1 / 30;
			add(_physics);

			_hero = new Hero("hero", {x:1500, radius:30});
			_hero.maxVelocity = 180;
			_hero.acceleration = 40;
			_hero.jumpHeight = 460;
			_hero.jumpAcceleration = 2;

			/*var bulle:Bulle = new Bulle("une bulle", {x:250, y:230});
			add(bulle);*/

			_hillsTexture = new HillsTexture();
			var hills:Hills = new Hills("hills", {currentYPoint:1581, sliceWidth:128, widthHills:stage.stageWidth * 12, registration:"topLeft", view:_hillsTexture});
			add(hills);
			
			_scrollBackground = new ScrollImage(1600, 800);
			_scrollBackground.addLayer(new ScrollTile(AtlasSimple.getAtlas().getTexture("bg"), true));
			Starling.current.stage.addChildAt(_scrollBackground, 0);

			 view.camera.setUp(_hero, new MathVector((stage.stageWidth / 2) ,(stage.stageHeight / 1.5)), new Rectangle(0, 0, 25000, 6000), new MathVector(0.10, 0.15));
			 _camera = (view.camera as StarlingCamera);

			//_containerGroupBgLight = view.getArt(bg).parent;
			//_containerGroupBgLight.filter = new SpotlightFilter(100, 400);

			_factory = new StarlingFactory();
			_factory.addEventListener(Event.COMPLETE, _textureCompleteHandler);
			_factory.parseData(new _ResourcesData());
			
			_HeartBeat = new HeartBeat();
			_HeartBeat.targetSpeed = 1;
			
			_ce.sound.addSound("HB1", "HeartBeat1.mp3");
			_ce.sound.addSound("HB2", "HeartBeat2.mp3");
			_HeartBeat.onHeartBeat.add(handleHeartBeat);
			
			createDECOR();
			
			var decor:CitrusSprite = new CitrusSprite("Decor", {parallax: 1, view: ImageDECOR,group:1});
			add(decor);
			decor.x = 128;
			
			lightSpot= new CitrusSprite("light", {parallax: 1, view: new Image(AtlasSimple.getAtlas().getTexture("light")),group:1});
			lightSpot.offsetX = -256;
			lightSpot.offsetY = -256;
			
			add(lightSpot);
		}
		
		private function createDECOR():void
		{
			ImageDECOR = new Sprite();
			
			for (var i:int = 0; i < levelProps.length; i++)
			{
				createPROPS(levelProps[i][0], levelProps[i][1], levelProps[i][2]);
			}
			
			for (var j:int = 0; j < levelItemps.length; j++)
			{
				trace("je creer un item "  + levelItemps[j][2]);
			//	createITEMS(levelItemps[j][0], levelItemps[j][1], levelItemps[j][2]);
			}
			
		}
		
		private function createPROPS(x:Number, y:Number, ty:String):void
		{
			
			var tm:Image = new Image(AtlasSimple.getAtlas().getTexture(ty));
			tm.x = x;
			tm.y = y;
			ImageDECOR.addChild(tm);
		}

		private function handleHeartBeat(n:uint):void
		{
			if (n)
				_ce.sound.playSound("HB2",_HeartBeat.volume,0);
			else
				_ce.sound.playSound("HB1", _HeartBeat.volume, 0);
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
			
			_scrollBackground.tilesOffsetX = -_hero.x / 50;
			
			lightSpot.x = _hero.x;
			lightSpot.y = _hero.y;

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
