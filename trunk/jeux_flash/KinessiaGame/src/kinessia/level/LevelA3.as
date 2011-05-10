package kinessia.level {

	import com.citrusengine.objects.platformer.Platform;

	/**
	 * @author Aymeric
	 */
	public class LevelA3 extends ALevel {

		public function LevelA3() {
			super();
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			var plateform:Platform = new Platform("Platform", {x:250, y:300, width:150, height:150});
			add(plateform);
		}
	}
}
