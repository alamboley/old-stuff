package levels {

	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import citrus.core.starling.StarlingState;

	/**
	 * @author Aymeric
	 */
	public class Level1 extends StarlingState {

		private var _physics:Nape;

		public function Level1() {
			super();
		}

		override public function initialize():void {
			super.initialize();

			_physics = new Nape("physics");
			_physics.visible = true;
			add(_physics);

			add(new Platform("border left", {y:stage.stageWidth / 2, height:stage.stageWidth}));
		}

	}
}
