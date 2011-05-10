package kinessia.level {

	import com.citrusengine.core.State;
	import com.citrusengine.physics.Box2D;
	import com.citrusengine.utils.ObjectMaker;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class ALevel extends State {

		public var lvlEnded:Signal;
		
		private var _levelObjectsMC:MovieClip;

		public function ALevel(levelObjectsMC:MovieClip) {

			super();
			
			_levelObjectsMC = levelObjectsMC;
			
			lvlEnded = new Signal();
		}

		override public function initialize():void {
			
			super.initialize();
			
			var box2d:Box2D = new Box2D("box2D", {visible:true});
			add(box2d);
			
			view.loadManager.onLoadComplete.addOnce(handleLoadComplete);
			
			ObjectMaker.FromMovieClip(_levelObjectsMC);
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
			
			// remove loader
		}
	}
}
