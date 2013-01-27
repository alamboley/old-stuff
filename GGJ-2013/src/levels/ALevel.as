package levels {

	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.nape.Hero;
	import citrus.physics.nape.Nape;

	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;

	import nape.geom.Vec2;

	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	import ui.Hud;

	import org.osflash.signals.Signal;

	import flash.display.Bitmap;
	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class ALevel extends StarlingState {
		
		public var lvlEnded:Signal;
		public var restartLevel:Signal;

		protected var _ce:CitrusEngine;
		protected var _hud:Hud;
		protected var _physics:Nape;
		protected var _hero:Hero;
		
		protected var _armature:Armature;
		protected var _factory:StarlingFactory;

		[Embed(source="/../embed/font.fnt",mimeType="application/octet-stream")]
		private var _fontConfig:Class;

		[Embed(source="/../embed/font_0.png")]
		private var _fontPng:Class;

		[Embed(source="/../embed/fillette.png",mimeType="application/octet-stream")]
		protected const _ResourcesData:Class;

		public function ALevel() {
			super();
			
			lvlEnded = new Signal();
			restartLevel = new Signal();
			
			_ce = CitrusEngine.getInstance();
			_ce.stage.focus = _ce.stage;
		}

		override public function initialize():void {
			super.initialize();

			_ce = CitrusEngine.getInstance();
			_ce.stage.focus = _ce.stage;

			scaleX = GameVars.GameScale;
			scaleY = GameVars.GameScale;

			_hud = new Hud();
			addChild(_hud);
			_hud.scaleX = GameVars.UpScale;
			_hud.scaleY = GameVars.UpScale;
			_hud.mode = true;

			var bitmap:Bitmap = new _fontPng();
			var ftTexture:Texture = Texture.fromBitmap(bitmap);
			var ftXML:XML = XML(new _fontConfig());
			TextField.registerBitmapFont(new BitmapFont(ftTexture, ftXML));

			_physics = new Nape("physics");
			// _physics.visible = true;
			_physics.timeStep = 1 / 30;
			_physics.gravity = new Vec2(0, 250);
			add(_physics);
		}
		
		protected function _textureCompleteHandler(evt:Event):void
		{
			_factory.removeEventListener(Event.COMPLETE, _textureCompleteHandler);
			
			_armature = _factory.buildArmature("fillette");
			(_armature.display as Sprite).scaleX = 0.55;
			(_armature.display as Sprite).scaleY = 0.55;
			
			_hero.view = _armature;
		}

		override public function destroy():void {
			TextField.unregisterBitmapFont("ArialMT");

			super.destroy();
		}

	}
}
