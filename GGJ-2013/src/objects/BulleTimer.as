package objects {

	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;

	import nape.callbacks.InteractionCallback;

	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;

	import com.greensock.TweenNano;

	import flash.utils.setTimeout;

	/**
	 * @author Aymeric
	 */
	public class BulleTimer extends Sensor {

		public var text:String = "default text";
		public var callback:Function = null;

		protected var _bulle:CitrusSprite;
		protected var _tf:TextField;
		
		protected var _readed:Boolean = false;

		public function BulleTimer(name:String, params:Object = null) {
			super(name, params);
			
			_tf = new TextField(400, 300, text, "ArialMT");
			_tf.alpha = 0;
			_tf.fontSize = BitmapFont.NATIVE_SIZE;
			_tf.width = _ce.stage.stageWidth;
			_tf.color = Color.WHITE;
			_tf.autoScale = true;
			_tf.hAlign = HAlign.CENTER;
			
			//_bulle = new CitrusSprite("bulle", {parallax:0, group:2, x:-200, y:-600, view:_tf});
			//_ce.state.add(_bulle);
			
			(_ce.state as StarlingState).addChild(_tf);
		}

		override public function handleBeginContact(interactionCallback:InteractionCallback):void {
			super.handleBeginContact(interactionCallback);

			if (!_readed) {
					var Collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, interactionCallback);
					
				if (Collider is Hero) {
					
					TweenNano.to(_tf, 0.4, {alpha:1});
					_readed = _readed;
					
					(Collider as Hero).velocity = [0, 0];
					//_ce.input.startRouting(666);
					
					setTimeout(function():void 
					{
						//a.animation.gotoAndPlay("baisser");
						killObject();
					}, 3000);
				}
			}

		}

		private function killObject():void {
			kill = true;
		}

		override public function destroy():void {

			(_ce.state as StarlingState).removeChild(_tf);

			super.destroy();
		}

	}
}
