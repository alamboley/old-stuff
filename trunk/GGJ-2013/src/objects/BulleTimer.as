package objects {

	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	import levels.Hopital;
	import ui.Caption;

	import nape.callbacks.InteractionCallback;

	import com.greensock.TweenNano;

	import flash.utils.setTimeout;

	/**
	 * @author Aymeric
	 */
	public class BulleTimer extends Sensor {

		public var text:String = "default text";
		public var callback:Function = null;

		protected var _bulle:CitrusSprite;
		
		protected var _readed:Boolean = false;
		
		public var captionRef:Caption;

		public function BulleTimer(name:String, params:Object = null) {
			super(name, params);
			
			//_bulle = new CitrusSprite("bulle", {parallax:0, group:2, x:-200, y:-600, view:_tf});
			//_ce.state.add(_bulle);
			
		}

		override public function handleBeginContact(interactionCallback:InteractionCallback):void {
			super.handleBeginContact(interactionCallback);

			if (!_readed) {
					var Collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, interactionCallback);
					
				if (Collider is Hero) {
					
					captionRef.enqueueText(text);
					_readed = _readed;
					
					(Collider as Hero).velocity = [0, 0];
					
					kill = true;
				}
			}

		}

		override public function destroy():void {

			super.destroy();
		}

	}
}
