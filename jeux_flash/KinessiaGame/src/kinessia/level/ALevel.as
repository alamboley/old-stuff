package kinessia.level {

	import com.citrusengine.core.State;
	import com.citrusengine.physics.Box2D;

	import org.osflash.signals.Signal;

	/**
	 * @author Aymeric
	 */
	public class ALevel extends State {

		public var lvlEnded:Signal;

		public function ALevel() {

			super();
			
			lvlEnded = new Signal();
		}

		override public function initialize():void {
			
			super.initialize();
			
			var box2d:Box2D = new Box2D("box2D", {visible:true});
			add(box2d);
			view.loadManager.onLoadComplete.addOnce(handleLoadComplete);
		}

		override public function destroy():void {
			
			lvlEnded.removeAll();
			super.destroy();
		}


		override public function update(timeDelta:Number):void {

			super.update(timeDelta);

			// _percent = Math.round(view.loadManager.bytesLoaded / view.loadManager.bytesTotal * 100).toString();
		}

		private function handleLoadComplete():void {
			
			// virer l'écran de chargement
		}
	}
}
