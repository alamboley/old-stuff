package levels {

	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;

	import objects.Bulle;
	import objects.Hills;
	import objects.HillsTexture;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	import utils.SpotlightFilter;

	import flash.display.Bitmap;
	import flash.geom.Rectangle;

	/**
	 * @author Aymeric
	 */
	public class Level1 extends StarlingState {
		
		protected var _ce:CitrusEngine;
		protected var _physics:Nape;
		
		protected var _hero:Hero;
		
		private var _hillsTexture:HillsTexture;
		
		[Embed(source="/../embed/ArialFont.fnt", mimeType="application/octet-stream")]
		private var _fontConfig:Class;
		
		[Embed(source="/../embed/ArialFont.png")]
		private var _fontPng:Class;
		
		[Embed(source="/../embed/Horror.jpg")]
		private var _horrorPNG:Class;		
		private var _containerGroupBgLight:Sprite;

		public function Level1() {
			super();
			
			_ce = CitrusEngine.getInstance();
		}

		override public function initialize():void {
			super.initialize();
			
			var bitmap:Bitmap = new _fontPng();
			var ftTexture:Texture = Texture.fromBitmap(bitmap);
			var ftXML:XML = XML(new _fontConfig());
			TextField.registerBitmapFont(new BitmapFont(ftTexture, ftXML));

			_physics = new Nape("physics");
			_physics.visible = true;
			_physics.timeStep = 1 / 30;
			add(_physics);			

			add(new Platform("border left", {y:stage.stageHeight / 2, height:stage.stageHeight}));
			//add(new Platform("border left", {x:stage.stageWidth / 2, width:stage.stageWidth, y:250}));
			
			_hero = new Hero("hero", {x:150});
			add(_hero);
			
			/*var bulle:Bulle = new Bulle("gre", {x:250, y:230});
			add(bulle);*/
			
			_hillsTexture = new HillsTexture();
			var hills:Hills = new Hills("hills", {currentYPoint:600, sliceWidth:128, widthHills:stage.stageWidth * 2, view:_hillsTexture});
			add(hills);
			
			view.camera.setUp(_hero, new MathVector(_ce.stage.stageWidth / 2, _ce.stage.stageHeight / 2), new Rectangle(0, 0, 5000, 6000), new MathVector(0.25, 0.15));
			
			var bg:CitrusSprite = add(new CitrusSprite("test", {view:Image.fromBitmap(new _horrorPNG())})) as CitrusSprite;
			
			_containerGroupBgLight = view.getArt(bg).parent;
			_containerGroupBgLight.filter = new SpotlightFilter(100, 400);
		}
			
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			
			(_containerGroupBgLight.filter as SpotlightFilter).centerX = _hero.x;
			(_containerGroupBgLight.filter as SpotlightFilter).centerY = _hero.y;
		}

		override public function destroy():void {
			
			TextField.unregisterBitmapFont("ArialMT");
			
			super.destroy();
		}

	}
}
