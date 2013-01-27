package levels
{
	import citrus.core.starling.StarlingState;
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.HeroB;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import citrus.view.starlingview.StarlingCamera;
	import nape.geom.Vec2;
	
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
	 * ...
	 * @author 3wg
	 */
	public class Hopital extends StarlingState
	{
		
		protected var _hero:HeroB;
		private var _armature:Armature;
		private var _factory:StarlingFactory;
		private var _camera:StarlingCamera;
		private var ImageDECOR:Sprite;
	 
				protected var _hud:Hud;
		protected var _ce:CitrusEngine;
		protected var _physics:Nape;
		
		[Embed(source="/../embed/hopital.png")]
		private var _bgHopital:Class;
		
		[Embed(source="/../embed/fillette.png",mimeType="application/octet-stream")]
		private const _ResourcesData:Class;
		
		public function Hopital()
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
			_hud.mode = true;
			
			_physics = new Nape("physics");
			_physics.timeStep = 1 / 30;
			_physics.visible = true;
			_physics.gravity = new Vec2(0, 250);
			add(_physics);
			
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
			
			var ImageDECOR:Image = Image.fromBitmap(new _bgHopital());
			
			var decor:CitrusSprite = new CitrusSprite("Decor", { view: ImageDECOR, group: 0});
			add(decor);
			
			
			
			createSpots();
			
		
		}
		
		private function createSpots():void {
			
			
			for (var i:int = 0; i < GameVars.SpeechHopital.length; i++) {
				
			var coin:BulleTimer = new BulleTimer("coin", {x: GameVars.SpeechDots[i], y: 600, width: 30, height: 30, text: GameVars.SpeechHopital[i]});
			add(coin);	
				
			}
			
			
		}
		
		
		private function _textureCompleteHandler(evt:Event):void
		{
			_factory.removeEventListener(Event.COMPLETE, _textureCompleteHandler);
			
			_armature = _factory.buildArmature("fillette");
			(_armature.display as Sprite).scaleX = 0.55;
			(_armature.display as Sprite).scaleY = 0.55;
			trace(_armature.animation.movementList);
			_hero.view = _armature;
			
			add(_hero);
		}
		
		
		override public function update(timeDelta:Number):void
		{
			
			trace(_hero.x, _hero.y);
			
			super.update(timeDelta);
			
		}
	
	}

}