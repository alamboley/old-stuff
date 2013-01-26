package objects {

	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;

	import nape.callbacks.InteractionCallback;

	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;

	import com.greensock.TweenNano;

	/**
	 * @author Aymeric
	 */
	public class Bulle extends Sensor {

		public var text:String = "default text";
		public var callback:Function = null;

		protected var _bulle:CitrusSprite;
		protected var _tf:TextField;

		public function Bulle(name:String, params:Object = null) {
			super(name, params);
			
			_tf = new TextField(400, 200, text, "ArialMT");
			_tf.alpha = 0;
			_tf.fontSize = BitmapFont.NATIVE_SIZE;
			_tf.color = Color.WHITE;
			_tf.autoScale = true;
			_tf.hAlign = HAlign.LEFT;
			
			_bulle = new CitrusSprite("bulle", {group:1, x:_x + 30, y:_y - 130, view:_tf});
			_ce.state.add(_bulle);
		}

		override public function handleBeginContact(interactionCallback:InteractionCallback):void {
			super.handleBeginContact(interactionCallback);

			if (NapeUtils.CollisionGetOther(this, interactionCallback) is Hero) {
				TweenNano.to(_tf, 0.4, {alpha:1});
			}

		}

		override public function handleEndContact(interactionCallback:InteractionCallback):void {
			super.handleBeginContact(interactionCallback);

			if (NapeUtils.CollisionGetOther(this, interactionCallback) is Hero) {

				TweenNano.to(_tf, 0.4, {alpha:0});
				
				if (callback)
					callback.call();
			}

		}

		override public function destroy():void {

			_ce.state.remove(_bulle);

			super.destroy();
		}

	}
}
