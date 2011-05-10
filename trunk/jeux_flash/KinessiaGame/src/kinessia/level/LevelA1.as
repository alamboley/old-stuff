package kinessia.level {

	import com.citrusengine.objects.platformer.Platform;

	/**
	 * @author Aymeric
	 */
	public class LevelA1 extends ALevel {

		public function LevelA1() {
			super();
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			var plateform:Platform = new Platform("Platform", {x:250, y:300, width:300, height:20});
			add(plateform);
		}
	}
}
