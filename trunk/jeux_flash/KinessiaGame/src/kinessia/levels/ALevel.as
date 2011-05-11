package kinessia.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import kinessia.characters.Bullzor;
	import kinessia.characters.Declik;
	import kinessia.objects.Roseau;

	import com.citrusengine.core.CitrusObject;
	import com.citrusengine.core.State;
	import com.citrusengine.math.MathVector;
	import com.citrusengine.objects.CitrusSprite;
	import com.citrusengine.objects.platformer.Platform;
	import com.citrusengine.objects.platformer.Sensor;
	import com.citrusengine.physics.Box2D;
	import com.citrusengine.utils.ObjectMaker;
	import com.citrusengine.view.ExternalArt;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	/**
	 * @author Aymeric
	 */
	public class ALevel extends State {

		public var lvlEnded:Signal;
		public var damageTaken:Signal;

		protected var _declik:Declik;
		protected var _bullzors:Vector.<CitrusObject>;

		private var _levelObjectsMC:MovieClip;

		public function ALevel(levelObjectsMC:MovieClip) {

			super();

			_levelObjectsMC = levelObjectsMC;

			lvlEnded = new Signal();
			damageTaken = new Signal();

			var objects:Array = [Platform, Declik, CitrusSprite, Sensor, Roseau, Bullzor];
		}

		override public function initialize():void {

			super.initialize();

			var box2d:Box2D = new Box2D("box2D", {visible:false});
			add(box2d);

			view.loadManager.onLoadComplete.addOnce(handleLoadComplete);

			ObjectMaker.FromMovieClip(_levelObjectsMC);

			ExternalArt.smoothBitmaps = true;

			_declik = Declik(getObjectByName("Declik"));
			_declik.onTakeDamage.add(_hurt);

			var roseaux:Vector.<CitrusObject> = getObjectsByType(Roseau);
			for each (var roseau:Sensor in roseaux) {
				roseau.onBeginContact.add(_roseauTouche);
				roseau.onEndContact.add(_roseauFin);
			}

			view.setupCamera(_declik, new MathVector(320, 240), new Rectangle(-1000, 0, 4000, 650), new MathVector(.25, .05));
		}

		private function _roseauTouche(cEvt:ContactEvent):void {

			cEvt.fixture.GetBody().GetUserData().anim = "white";
		}

		private function _roseauFin(cEvt:ContactEvent):void {

			cEvt.fixture.GetBody().GetUserData().anim = "black";
		}


		protected function _hurt():void {
			damageTaken.dispatch();
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
