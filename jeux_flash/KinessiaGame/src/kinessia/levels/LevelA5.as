package kinessia.levels {

	import kinessia.objects.BodyPlatform;
	import kinessia.objects.Catapulte;

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class LevelA5 extends ALevel {

		public function LevelA5(levelObjectsMC:MovieClip) {
			super(levelObjectsMC);
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			_addContactRestartLevel();
			
			var catapulte:Catapulte = Catapulte(getFirstObjectByType(Catapulte));
			catapulte.initJoint(BodyPlatform(getObjectByName("PlatformJoint")));
		}
	}
}
