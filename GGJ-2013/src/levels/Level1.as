package levels {

	import citrus.objects.platformer.nape.Hills;
	import flash.geom.Rectangle;
	import citrus.math.MathVector;
	import citrus.objects.platformer.nape.Hero;
	import citrus.core.CitrusEngine;
	import utils.SpotlightFilter;
	import citrus.objects.CitrusSprite;
	import starling.display.Image;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import citrus.core.starling.StarlingState;

	/**
	 * @author Aymeric
	 */
	public class Level1 extends StarlingState {
		
		protected var _ce:CitrusEngine;
		protected var _physics:Nape;
		
		protected var _hero:Hero;
		
		private var imageFilter:Image;
		
		[Embed(source="/../embed/Horror.jpg")]
		private var _horrorPNG:Class;		

		public function Level1() {
			super();
			
			_ce = CitrusEngine.getInstance();
		}

		override public function initialize():void {
			super.initialize();

			_physics = new Nape("physics");
			_physics.visible = true;
			add(_physics);

			add(new Platform("border left", {y:stage.stageWidth / 2, height:stage.stageWidth}));
			
			_hero = new Hero("hero", {x:150});
			add(_hero);
			
			var hills:Hills = new Hills("hills", {currentYPoint:600, sliceWidth:128, widthHills:stage.stageWidth * 2});
			add(hills);
			
			view.camera.setUp(_hero, new MathVector(_ce.stage.stageWidth / 2, _ce.stage.stageHeight / 2), new Rectangle(0, 0, 5000, 6000), new MathVector(0.25, 0.15));
			
			imageFilter = Image.fromBitmap(new _horrorPNG());
			imageFilter.filter = new SpotlightFilter(100, 400);
			add(new CitrusSprite("test", {view:imageFilter}));
		}
			
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			
			(imageFilter.filter as SpotlightFilter).centerX = _ce.stage.mouseX;
			(imageFilter.filter as SpotlightFilter).centerY = _ce.stage.mouseY;
		}

	}
}
