package levels
{
	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import citrus.view.starlingview.StarlingCamera;
	import flash.geom.Point;
	import nape.geom.Vec2;
	import starling.display.Quad;
	
	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;
	
	import objects.BulleTimer;
	import objects.Hills;
	import objects.HillsTexture;
	
	import sound.HeartBeat;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.krecha.ScrollImage;
	import starling.extensions.krecha.ScrollTile;
	import starling.extensions.particles.PDParticleSystem;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import objects.Lucioles;
	
	import ui.Hud;
	
	import utils.SpotlightFilter;
	
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.display.BlendMode;
	
	/**
	 * @author Aymeric
	 */
	public class Level1 extends StarlingState
	{
		
		protected var _ce:CitrusEngine;
		protected var _physics:Nape;
		
		protected var _hud:Hud;
		
		protected var _hero:Hero;
		
		private var _hillsTexture:HillsTexture;
		
		[Embed(source="/../embed/ArialFont.fnt",mimeType="application/octet-stream")]
		private var _fontConfig:Class;
		
		[Embed(source="/../embed/ArialFont.png")]
		private var _fontPng:Class;
		
		private var _containerGroupBgLight:Sprite;
		
		[Embed(source="/../embed/fillette.png",mimeType="application/octet-stream")]
		private const _ResourcesData:Class;
		
		[Embed(source="/../embed/torche.pex",mimeType="application/octet-stream")]
		private var _torchePex:Class;
		
		[Embed(source="/../embed/texture.png")]
		private var _particlePng:Class;
		
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
		
		private var _particleTorche:PDParticleSystem;
		private var _torche:CitrusSprite;
		private var quelleBulle:int = new int(0);
		private var heartrythme:Number = Number(3);
		
		private var volumeZik:Number = 0;
		private var volumeHeart:Number = 1;
		private var oursPosX:Number = 3500;
		private var startPosX:Number = 10000;
		private var distStartOurs:Number = oursPosX - startPosX;
		private var distHeroOurs:Number = 0;
		
		private var _ended:Boolean = false;
		
		private var _overlayQuad:Quad;
		
		public function Level1()
		{
			super();
			
			_ce = CitrusEngine.getInstance();
			_ce.stage.focus = _ce.stage;
		}
		
		override public function initialize():void
		{
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
			_physics.gravity = new Vec2(0, 250);
			add(_physics);
			
			var psconfig:XML = new XML(new _torchePex());
			var psTexture:Texture = Texture.fromBitmap(new _particlePng());
			
			_particleTorche = new PDParticleSystem(psconfig, psTexture);
			_particleTorche.start();
			
			_torche = new CitrusSprite("torche", {view: _particleTorche /*, offsetY:-40*/});
			add(_torche), _ce.sound.playSound("Feu", 0.02);
			
			_hero = new Hero("hero", {x: 11256, y: 1250, radius: 30});
			//_hero = new Hero("hero", {x: 4500, y: 1250, radius: 30});
			_hero.maxVelocity = 85;
			_hero.acceleration = 25;
			_hero.jumpHeight = 280;
			_hero.jumpAcceleration = 2;
			add(_hero);
			
			/*
			   var oursImage:Image = Image.fromBitmap(new _oursPng());
			   oursImage.scaleX = -1;
			   var ours:CitrusSprite = new CitrusSprite("ours", {x: 2287, y: 1685, view: oursImage});
			   add(ours);
			 */
			
			/*var bulle:Bulle = new Bulle("une bulle", {x:250, y:230});
			 add(bulle);*/
			
			_hillsTexture = new HillsTexture();
			var hills:Hills = new Hills("hills", {currentYPoint: 1581, sliceWidth: 128, widthHills: stage.stageWidth * 20, registration: "topLeft", view: _hillsTexture});
			add(hills);
			
			_scrollBackground = new ScrollImage(1600, 800);
			_scrollBackground.addLayer(new ScrollTile(AtlasSimple.getAtlas().getTexture("bg"), true));
			Starling.current.stage.addChildAt(_scrollBackground, 0);
			
			var circle:Shape = new Shape();
			circle.graphics.beginFill(0xFFFFFF);
			circle.graphics.drawCircle(5, 5, 5);
			
			var bmpd:BitmapData = new BitmapData(10, 10, true, 0x000000);
			bmpd.draw(circle, null);
			
			//for (var i:uint = 0; i < 30; ++i)
			//add(new Etoile("gre", {parallax:0, x:Math.random() * 160000, y:Math.random() * 400, view:Image.fromBitmap(new Bitmap(bmpd))}));
			
			view.camera.setUp(_hero, new MathVector((stage.stageWidth / 2), (stage.stageHeight / 1.5)), new Rectangle(0, 0, 50000, 6800), new MathVector(0.10, 0.15));
			_camera = (view.camera as StarlingCamera);
			_camera.allowZoom = true;
			_camera.zoomEasing = 0.008;
			
			//_containerGroupBgLight = view.getArt(bg).parent;
			//_containerGroupBgLight.filter = new SpotlightFilter(100, 400);
			
			_factory = new StarlingFactory();
			_factory.addEventListener(Event.COMPLETE, _textureCompleteHandler);
			_factory.parseData(new _ResourcesData());
			
			_HeartBeat = new HeartBeat();
			_HeartBeat.onHeartBeat.add(handleHeartBeat);

			
			_ce.sound.addSound("background music", "introTest2.mp3");
			_ce.sound.playSound("background music", 1);
			
			createDECOR();
			
			var decor:CitrusSprite = new CitrusSprite("Decor", {parallax: 1, view: ImageDECOR, group: 1});
			add(decor);
			decor.x = 128;
			
			lightSpot = new CitrusSprite("light", {view: new Image(AtlasSimple.getAtlas().getTexture("light")), group: 1});
			lightSpot.offsetX = -206;
			lightSpot.offsetY = -216;
			lightSpot.view.scaleX = lightSpot.view.scaleY = 0.7;
			
			TweenLite.to(lightSpot.view, 0.7, {alpha: 0.8, repeat: -1, yoyo: true});
			
			//- a tester sur mobile.
			(lightSpot.view as Image).blendMode = BlendMode.SCREEN;
			
			add(lightSpot);
			
			_ce.sound.addSound("HB1", "Heartbeat1.mp3");
			_ce.sound.addSound("HB2", "Heartbeat2.mp3");
			_HeartBeat.targetSpeed = 2.5;
			_HeartBeat.volume = 0;
			
			add(new Platform("murOurs", {x: 2600, y: 1600, width: 30, height: 600}));
			
			_ce.sound.addSound("roar", "ours.mp3");
			
			var lucioles:Lucioles = new Lucioles();
			Starling.juggler.add(lucioles);
			var luciolesCS:CitrusSprite = new CitrusSprite("lucioles", { x:_hero.x+128, y:_hero.y, view:lucioles } );
			add(luciolesCS);
			
			//TODO: changer les dimensions
			_overlayQuad = new Quad(stage.stageWidth, stage.stageHeight, 0);
			_overlayQuad.touchable = false;
			_overlayQuad.alpha = 0;
			Starling.current.stage.addChild(_overlayQuad);
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
				createITEMS(levelItemps[j][0], levelItemps[j][1], levelItemps[j][2]);
			}
		
		}
		
		private function createITEMS(x:Number, y:Number, ty:String):void
		{
			
			ty = ty.substr(5);
			
			var textBulle:String;
			
			if (ty == "1")
			{
				trace("je creer la bulle dont le texte est " + GameVars.SpeechNightMare[quelleBulle]);
				textBulle = GameVars.SpeechNightMare[quelleBulle];
				quelleBulle++;
			}
			
			var coin:BulleTimer = new BulleTimer("coin", {x: x, y: y, width: 150, height: 150, text: textBulle});
			add(coin);
		}
		
		private function createPROPS(x:Number, y:Number, ty:String):void
		{
			
			trace("BLAH " + ty);
			
			var tm:Image = new Image(AtlasSimple.getAtlas().getTexture(ty));
			tm.x = x;
			tm.y = y;
			ImageDECOR.addChild(tm);
		}
		
		private function handleHeartBeat(n:uint):void
		{
			if (n)
			{
				//	_camera.setZoom(0.6*_HeartBeat.currentSpeed);
				_ce.sound.playSound("HB2", _HeartBeat.volume, 0, -0.9);
			}
			else
				_ce.sound.playSound("HB1", _HeartBeat.volume, 0, 1.1);
		}
		
		private function _textureCompleteHandler(evt:Event):void
		{
			_factory.removeEventListener(Event.COMPLETE, _textureCompleteHandler);
			
			_armature = _factory.buildArmature("fillette");
			(_armature.display as Sprite).scaleX = 0.55;
			(_armature.display as Sprite).scaleY = 0.55;
			
			_hero.view = _armature;
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			// un peu degeu...
			if ((Math.abs(_hero.velocity[0]) > 0.5 || Math.abs(_hero.velocity[1])> 0.5) && !_ended)
				_camera.zoomFit(1500, 1500);
			else
				_camera.zoomFit(700, 700);
			
			_scrollBackground.tilesOffsetX = -_hero.x / 50;
			
			lightSpot.x = _hero.x;
			lightSpot.y = _hero.y;
			
			//(_containerGroupBgLight.filter as SepotlightFilter).centerX = _hero.x;
			//(_containerGroupBgLight.filter as SpotlightFilter).centerY = _hero.y;
			
			_hillsTexture.update();
			
			//trace(_hero.x, _hero.y);
			
			//test
			
			//heartrythme = (_hero.x / 100) 
			
			
			// gestion SON 
			
	
			
			if (_hero.x < startPosX)
			{
				distHeroOurs = oursPosX - _hero.x;
				volumeZik = distHeroOurs / distStartOurs;
				volumeHeart = 1 - distHeroOurs / distStartOurs;
				volumeHeart = (volumeHeart < 0) ? -volumeHeart : volumeHeart;
				volumeZik = (volumeZik < 0) ? -volumeZik : volumeZik;
				_HeartBeat.volume = volumeHeart;
				_ce.sound.setVolume("background music", volumeZik*0.8);
			
			}
			
			if (_hero.x < oursPosX && !_ended)
			{
				_hud.touchable = false;
				_ce.input.resetActions();
				_ce.input.startRouting(666);
				TweenLite.to(_hud, 1, { alpha:0 } );
				
				_camera.zoomEasing = 0.025;
				_camera.target = { x:oursPosX - 300, y:_hero.y };
				_camera.zoomFit(400, 400);
				_HeartBeat.targetSpeed = 8;
				// EN FACE DE L'OURS
				TweenLite.to(_HeartBeat, 1, { volume:1} );
				TweenLite.delayedCall(2, preEndLevel);
				_ended = true;
			}
			
			trace(_ended);

			
			_particleTorche.emitterX = _hero.inverted ? _hero.x - 18 : _hero.x + 18;
			_particleTorche.emitterY = _hero.y - 35;
		}
		
		private function preEndLevel():void
		{
			//ours et vignette
			_ce.sound.playSound("roar", 1, 0);
			var vpos:Point = _camera.pointFromLocal(new Point(_camera.offset.x,_camera.offset.y));
			vpos.y -= 200;
			add(new CitrusSprite("ours1", {x:vpos.x, y:vpos.y, view: new Image(AtlasSimple.getAtlas().getTexture("ours1")), group: 1}));
			TweenLite.delayedCall(5, postPreEndLevel);
		}
		
		private function postPreEndLevel():void
		{
			TweenLite.to(_overlayQuad, 5, { alpha:1 } );
			TweenLite.delayedCall(5, endLevel);
		}
		
		private function endLevel():void
		{
			//TweenLite.to(_overlayQuad, 5, { alpha:1 } );
			_HeartBeat.volume = 0;
			_ce.input.stopRouting();
			_HeartBeat.stop();
			_ce.sound.stopSound("background music");
			_ce.sound.removeSound("HB1");
			_ce.sound.removeSound("HB2");
			//...
			_ce.state = new Hopital();
		}
		
		override public function destroy():void
		{
			
			TextField.unregisterBitmapFont("ArialMT");
			
			super.destroy();
			
			Starling.current.stage.removeChildren();
		}
	
	}
}
